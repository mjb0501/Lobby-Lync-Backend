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
  try {
    const result = await pool.query(query, values);
    return result.rows[0];
  } catch (error) {
    console.error('Error fetching posts:', error);
    throw new Error('Failed to create post');
  }
  
};

export const updatePost = async (postId: number, userId: number, gameId: number, description: string) => {
  const query = `
  UPDATE post
  SET
    "gameId" = $1,
    description = $2,
    "createdAt" = NOW()
  WHERE
    id = $3 AND "userId" = $4;
  `;
  
  const values = [gameId, description, postId, userId];
  try {
    const result = await pool.query(query, values);
    return result.rows[0];
  } catch (error) {
    console.error('Error editing post:', error);
    throw new Error('Failed to edit post');
  }
}

export const readAllPosts = async (userId: number, gameName?: string, limit?: number, offset?: number): Promise<any[]> => {
  const query = `
    SELECT p.id AS "postId", u.id AS "userId", u.username AS user, g.name AS "gameName", g.id AS "gameId", p.description, p."createdAt", pl.name AS "platformName"
    FROM post p
	  LEFT JOIN "user" u ON p."userId" = u.id
    LEFT JOIN game g ON p."gameId" = g.id
    LEFT JOIN post_platform pp ON p.id = pp."postId"
    LEFT JOIN platform pl ON pp."platformId" = pl.id
    WHERE ($1::INT IS NULL OR p."userId" IS DISTINCT FROM $1)
    AND ($2::TEXT IS NULL OR g.name = $2)
    ORDER BY p."createdAt" DESC
    LIMIT $3 OFFSET $4;
  `;

  try {
    const result = await pool.query(query, [userId, gameName || null, limit, offset]);
    return result.rows;
  } catch (error) {
    console.error('Error fetching posts:', error);
    throw new Error('Failed to fetch posts');
  }
}

export const readUserCreatedPost = async (userId: number): Promise<any> => {
  const query = `
    SELECT p.id AS "postId", g.name AS "gameName", g.id AS "gameId", 
	    p.description, p."createdAt", pl.name AS "platformName", u.username, 
      pa.description AS "acceptDescription", pa.platform AS "acceptPlatform",
      pa."platformUsername" AS "acceptedPlatformUsername", c.id AS "conversationId"
    FROM post p
    LEFT JOIN game g ON p."gameId" = g.id
    LEFT JOIN post_platform pp ON p.id = pp."postId"
    LEFT JOIN platform pl ON pp."platformId" = pl.id
    LEFT JOIN post_acceptance pa ON p."id" = pa."postId"
    LEFT JOIN "user" u ON pa."userId" = u.id
    LEFT JOIN conversation c ON u.id = c."acceptorId" AND p.id = c."postId"
    WHERE p."userId" = $1;
  `;

  try {
    const result = await pool.query(query, [userId]);
    return result.rows.length ? result.rows : [];
  } catch (error) {
    console.error('Error fetching post:', error);
    throw new Error('Failed to fetch post created by user');
  }
}

export const deletePostById = async (userId: number): Promise<any> => {
  const query = `
    DELETE FROM post
    WHERE post."userId" = $1;
  `;

  try {
    await pool.query(query, [userId]);
  } catch (error) {
    console.error('Error deleting post by id:', error);
    throw new Error('Failed to delete post by id');
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

export const getTotalPostsCount = async (userId: number, gameName?: string): Promise<number> => {
  const query = `
    SELECT COUNT(*) AS "total"
    FROM post p
    LEFT JOIN game g ON p."gameId" = g.id
    WHERE ($1::INT IS NULL OR p."userId" IS DISTINCT FROM $1)
    AND ($2::TEXT IS NULL OR g.name = $2);
  `;

  try {
    const result = await pool.query(query, [userId, gameName || null]);
    return parseInt(result.rows[0].total, 10);
  } catch (error) {
    console.error('Error fetching total post count:', error);
    throw new Error('Failed to fetch total post count');
  }
}