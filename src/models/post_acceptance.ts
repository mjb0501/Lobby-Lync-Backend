import pool from '../config/database';

export interface PostAcceptance {
  id?: number;
  postId: number;
  userId: number;
  description: string;
}

export const createPostAccept = async (accept: PostAcceptance): Promise<void> => {
  const query = `
    INSERT INTO post_acceptance ("postId", "userId", description)
    VALUES ($1, $2, $3)
    RETURNING "postId", "userId", description;
  `;
  const values = [accept.postId, accept.userId, accept.description];
  await pool.query(query, values);
}