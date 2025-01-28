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
  try {
    await pool.query(query, values);
    return;
  } catch (error) {
    console.error('Error assigning platforms to post:', error);
    throw new Error('Failed to assign platforms to post');
  }
}

export const deletePostPlatforms = async (postId: number): Promise<void> => {
  const query = `
  DELETE FROM post_platform
  WHERE "postId" = $1;
  `;

  try {
    await pool.query(query, [postId]);
    return;
  } catch (error) {
    console.error('Error deleting platforms associated with post:', error);
    throw new Error('Failed to assign platforms to post');
  }
}