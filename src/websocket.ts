import { WebSocketServer, WebSocket } from 'ws';
const cookie = require('cookie');
import jwt from 'jsonwebtoken';
import pool from './config/database';
import { IncomingMessage, Server } from 'http';
import { Socket } from "net";
import { getUserByUuid } from './models/user';


type Client = {
    socket: WebSocket;
    userUuid: string;
    conversationIds: Set<number>;
};

const clients: Client[] = [];

export const setupWebSockets = (server: Server) => {
    const wss = new WebSocketServer({
        server, 
        path: '/ws',
        verifyClient: (info, done) => {
            const origin = info.origin;

            if (process.env.NODE_ENV === 'production') {
                if (origin === process.env.FRONTEND_URL) {
                    done(true);
                } else {
                    done(false);
                }
            } else {
                done(true);
            }
        }
    });

    wss.on("connection", async (ws: WebSocket, req: IncomingMessage) => {
        try {
            if (!req.headers.cookie) {
                console.log(req.headers.cookie);
                throw new Error("No cookies found in headers.")
            };

            const cookies = cookie.parse(req.headers.cookie);
            const token = cookies.accessToken;
            if(!token) throw new Error("Missing token.");

            const decoded = jwt.verify(token, process.env.JWT_SECRET!) as { userUuid: string };
            

            const userUuid = decoded.userUuid;
            const user = await getUserByUuid(userUuid);

            const client: Client = { socket: ws, userUuid, conversationIds: new Set() };
            clients.push(client);

            console.log(`User ${user[0].username} connected to WebSocket.`);

            ws.on("message", async (data) => {
                try {
                    const message = JSON.parse(data.toString());

                    if (message.type === "subscribe" && typeof message.conversationId === "number") {
                        client.conversationIds.add(message.conversationId);
                        console.log(client.conversationIds);
                        console.log(`User ${user[0].username} subscribed to conversation ${message.conversationId}`);

                        const result = await pool.query(
                            `SELECT "creatorId", "acceptorId" FROM conversation WHERE id = $1`,
                            [message.conversationId]
                        );

                        if (result.rows.length > 0) {
                            const { creatorId, acceptorId } = result.rows[0];

                            const otherUserId = user[0].id === creatorId ? acceptorId : creatorId;
                            const otherUser = await pool.query(`SELECT uuid FROM "user" WHERE id = $1`, [otherUserId]);

                            if (otherUser.rows.length > 0) {
                                const otherUserUuid = otherUser.rows[0].uuid;

                                const otherClient = clients.find(c => c.userUuid === otherUserUuid);

                                if (otherClient) {
                                    otherClient.conversationIds.add(message.conversationId);
                                    
                                    otherClient.socket.send(JSON.stringify({
                                        type: "refresh",
                                        conversationId: message.conversationId
                                    }));

                                    console.log(`User ${otherUserUuid} auto-subscribed to conversation ${message.conversationId}`);
                                }
                            }
                        }
                    }

                    if (message.type === "unsubscribe" && typeof message.conversationId === "number") {
                        client.conversationIds.delete(message.conversationId);
                        console.log(`User ${user[0].username} unsubscribed to conversation ${message.conversastionId}`);
                    }

                    if (message.type === "message" && typeof message.conversationId === "number" && typeof message.content === "string") {
                        console.log(`Received message from user ${user[0].username}: ${message.content}`);

                        const result = await pool.query(
                            `INSERT INTO message ("conversationId", "senderId", content)
                            VALUES ($1, (SELECT id FROM "user" WHERE uuid = $2), $3) RETURNING *,
                                (SELECT "creatorId" FROM conversation WHERE id = $1);`,
                            [message.conversationId, userUuid, message.content]
                        );

                        //console.log("clients:", clients);

                        const newMessage = result.rows[0];

                        notifyClients(message.conversationId, newMessage);
                    }

                } catch (error) {
                    console.error("Invalid message format:", error);
                }
            });

            ws.on("close", () => {
                console.log(`User ${user[0].username} disconnected.`);
                const index = clients.findIndex(client => client.socket === ws);
                if (index !== -1) clients.splice(index, 1);
            });
        } catch (error) {
            console.error("WebSocket authentication failed:", error);
            ws.close();
        }
    });

    console.log("WebSocket server initialized.");
};


export const notifyClients = (conversationId: number, newMessage: any) => {
    clients.forEach(({ socket, conversationIds }) => {
        if (conversationIds.has(conversationId)) {
            socket.send(JSON.stringify(newMessage));
        }
    });
};