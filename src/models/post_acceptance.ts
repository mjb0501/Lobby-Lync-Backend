import pool from '../config/database';

export interface PostAcceptance {
  id?: number;
  postId: number;
  userId: number;
  description: string;
}

export const createPostAccept = async (accept: PostAcceptance): Promise<any> => {
  const query = `
    INSERT INTO post_acceptance ("postId", "userId", description)
    VALUES ($1, $2, $3)
    RETURNING "postId", "userId", description;
  `;
  const values = [accept.postId, accept.userId, accept.description];
  try {
    const results = await pool.query(query, values);
    return results.rows[0];
  } catch (error) {
    console.error('Error creating post acceptance:', error);
    throw new Error('Failed to accept post');
  }
  
}