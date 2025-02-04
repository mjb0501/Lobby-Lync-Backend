import pool from '../config/database';

export interface Conversation {
  id?: number;
  postId: number;
  creatorId: number;
  acceptorId: number;
  createdAt?: Date;
}

export const createConversation = async (postId: number, creatorId: number, acceptorId: number) => {
    const query = `
        INSERT INTO conversation ("postId", "creatorId", "acceptorId")
        VALUES ($1, $2, $3)
        RETURNING id;
    `;
    try {
        const values = [postId, creatorId, acceptorId];
        const result = await pool.query(query, values);
        return result.rows[0];
    } catch (error) {
        console.error('Error creating conversation:', error);
        throw new Error('Failed to create conversation');
    }
}