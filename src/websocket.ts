import { WebSocketServer, WebSocket } from 'ws';
const cookie = require('cookie');
import jwt from 'jsonwebtoken';
import pool from './config/database';
import { IncomingMessage, Server } from 'http';
import { Socket } from "net";


type Client = {
    socket: WebSocket;
    userId: number;
    conversationIds: Set<number>;
};

const clients: Client[] = [];

export const setupWebSockets = (server: Server) => {
    const wss = new WebSocketServer({ server, path: '/ws' });

    // server.on('upgrade', (req: IncomingMessage, socket: Socket, head: Buffer) => {
    //     console.log(cookie);
    //     if (!req.headers.cookie) {
    //         console.log('No cookies found in headers.');
    //         socket.write('HTTP/1.1 401 Unauthorized\r\n\r\n');
    //         socket.destroy();
    //         return;
    //     }

    //     const cookies = cookie.parse(req.headers.cookie);
    //     const token = cookies.accessToken;

    //     if (!token) {
    //         console.log("Websocket rejected: Missing token.");
    //         socket.write('HTTP/1.1 401 Unauthorized\r\n\r\n');
    //         socket.destroy();
    //         return;
    //     }

    //     try {
    //         const decoded = jwt.verify(token, process.env.JWT_SECRET!) as { userId: number };
    //         req.userId = decoded.userId;

    //         if (!wss.shouldHandle(req)) {
    //             console.log("Websocket rejected: Connection not handled by WebSocketServer.");
    //             socket.write('HTTP/1.1 400 Bad Request\r\n\r\n');
    //             socket.destroy();
    //             return;
    //         }

    //         wss.handleUpgrade(req, socket, head, (ws) => {
    //             wss.emit('connection', ws, req);
    //         });
    //     } catch (error) {
    //         console.error("WebSocket authentication failed:", error);
    //         socket.write('HTTP/1.1 403 Forbidden\r\n\r\n');
    //         socket.destroy();
    //     }
    // });

    wss.on("connection", (ws: WebSocket, req: IncomingMessage) => {
        try {
            if (!req.headers.cookie) throw new Error("No cookies found in headers.");

            const cookies = cookie.parse(req.headers.cookie);
            const token = cookies.accessToken;
            if(!token) throw new Error("Missing token.");

            const decoded = jwt.verify(token, process.env.JWT_SECRET!) as { userId: number };
            

            const userId = decoded.userId;

            const client: Client = { socket: ws, userId, conversationIds: new Set() };
            clients.push(client);

            console.log(`User ${userId} connected to WebSocket.`);

            ws.on("message", async (data) => {
                try {
                    const message = JSON.parse(data.toString());

                    if (message.type === "subscribe" && typeof message.conversationId === "number") {
                        client.conversationIds.add(message.conversationId);
                        console.log(`User ${userId} subscribed to conversation ${message.conversationId}`);
                    }

                    if (message.type === "unsubscribe" && typeof message.conversationId === "number") {
                        client.conversationIds.delete(message.conversationId);
                        console.log(`User ${userId} unsubscribed to conversation ${message.conversastionId}`);
                    }

                    if (message.type === "message" && typeof message.conversationId === "number" && typeof message.content === "string") {
                        console.log(`Received message from user ${userId}: ${message.content}`);

                        const result = await pool.query(
                            `INSERT INTO message ("conversationId", "senderId", content)
                            VALUES ($1, $2, $3) RETURNING *`,
                            [message.conversationId, userId, message.content]
                        );

                        console.log("clients:", clients);

                        const newMessage = result.rows[0];

                        notifyClients(message.conversationId, newMessage);
                    }

                } catch (error) {
                    console.error("Invalid message format:", error);
                }
            });

            ws.on("close", () => {
                console.log(`User ${userId} disconnected.`);
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