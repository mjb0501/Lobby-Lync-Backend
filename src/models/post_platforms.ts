import pool from '../config/database';

export interface PostPlatform {
  id?: number;
  postId: number;
  platformId: number;
}

export const createPostPlatform = async (platformId: number, postId: number): Promise<void> => {
  const query = `
    INSERT INTO post_platform ("platformId", "postId")
    VALUES ($1, $2)
  `;
  const values = [platformId, postId];
  await pool.query(query, values);
  return;
}