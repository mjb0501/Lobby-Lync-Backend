import pool from '../config/database';

export interface Message {
  id?: number;
  conversationId: number;
  senderId: number;
  content: string;
  createdAt?: Date;
}

export const createMessage = async (conversationId: number, senderId: number, content: string) => {
    const query = `
        INSERT INTO "message" ("conversationId", "senderId", content)
        VALUES ($1, $2, $3)
        RETURNING *;
    `;

    try {
        const values = [conversationId, senderId, content];
        const result = await pool.query(query, values);
        return result.rows[0];
    } catch (error) {
        console.error('Error creating message:', error);
        throw new Error('Failed to create message');
    }
}

export const readMessages = async (conversationId: number) => {
    const query = `
        SELECT m.*, u.username
        FROM "message" m
        JOIN "user" u ON m."senderId" = u.id
        WHERE m."conversationId" = $1
        ORDER BY m."createdAt" ASC;
    `;

    try {
        const result = await pool.query(query, [conversationId]);
        return result.rows;
    } catch (error) {
        console.error('Error getting messages:', error);
        throw new Error('Failed to read messages');
    }
}