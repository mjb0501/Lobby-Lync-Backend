import pool from '../config/database';

export interface Post {
  id?: number;
  userId: number;
  gameId: number;
  description: string;
  createdAt?: Date;
}

export const createPost = async (post: Post): Promise<Post> => {
  const query = `
    INSERT INTO post ("userId", "gameId", description, "createdAt")
    VALUES ($1, $2, $3, NOW())
    RETURNING id, "userId", "gameId", description, "createdAt";
  `;
  const values = [post.userId, post.gameId, post.description];
  const result = await pool.query(query, values);
  return result.rows[0];
};

export const readAllPosts = async (userId?: number): Promise<any[]> => {
  const query = `
    SELECT p.id AS "postId", u.username AS user, g.name AS "gameName", p.description, p."createdAt", pl.name AS "platformName"
    FROM post p
	  LEFT JOIN "user" u ON p."userId" = u.id
    LEFT JOIN game g ON p."gameId" = g.id
    LEFT JOIN post_platform pp ON p.id = pp."postId"
    LEFT JOIN platform pl ON pp."platformId" = pl.id
    WHERE ($1::INT IS NULL OR p."userId" != $1);
  `;

  try {
    const result = await pool.query(query, [userId || null]);
    return result.rows;
  } catch (error) {
    console.error('Error fetching posts:', error);
    throw new Error('Failed to fetch posts');
  }
}

export const deleteOldPosts = async (time: string): Promise<number> => {
  const query = `
    DELETE FROM post
    WHERE "createdAt" < $1
  `;

  try {
    const result = await pool.query(query, [time]);
    return Number(result.rowCount);
  } catch (error) {
    console.error('Error deleting old posts:', error);
    throw new Error('Failed to delete old posts');
  }
}
