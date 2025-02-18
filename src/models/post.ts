import pool from '../config/database';

export interface Post {
  id?: number;
  userId: number;
  gameId: number;
  description: string;
  createdAt?: Date;
}

export const createPost = async (userUuid: string, gameId: number, description: string): Promise<Post> => {
  const query = `
    INSERT INTO post ("userId", "gameId", description, "createdAt")
    VALUES ((SELECT id FROM "user" WHERE uuid = $1), $2, $3, NOW())
    RETURNING id, "userId", "gameId", description, "createdAt";
  `;
  const values = [userUuid, gameId, description];
  try {
    const result = await pool.query(query, values);
    return result.rows[0];
  } catch (error) {
    console.error('Error fetching posts:', error);
    throw new Error('Failed to create post');
  }
  
};

export const updatePost = async (postId: number, userUuid: string, gameId: number, description: string) => {
  const query = `
  UPDATE post
  SET
    "gameId" = $1,
    description = $2,
    "createdAt" = NOW()
  WHERE
    id = $3 AND "userId" = (SELECT id FROM "user" WHERE uuid = $4);
  `;
  
  const values = [gameId, description, postId, userUuid];
  try {
    const result = await pool.query(query, values);
    return result.rows[0];
  } catch (error) {
    console.error('Error editing post:', error);
    throw new Error('Failed to edit post');
  }
}

export const readAllPosts = async (userUuid: string, gameName?: string, filteredPlatform?: string, limit?: number, offset?: number): Promise<any[]> => {
  const query = `
    SELECT p.id AS "postId", u.id AS "userId", u.username AS user, g.name AS "gameName", g.id AS "gameId", p.description, p."createdAt", pl.name AS "platformName"
    FROM post p
	  LEFT JOIN "user" u ON p."userId" = u.id
    LEFT JOIN game g ON p."gameId" = g.id
    LEFT JOIN post_platform pp ON p.id = pp."postId"
    LEFT JOIN platform pl ON pp."platformId" = pl.id
    WHERE ((SELECT id FROM "user" WHERE uuid = $1)::INT IS NULL 
    OR p."userId" IS DISTINCT FROM (SELECT id FROM "user" WHERE uuid = $1))
    AND ($2::TEXT IS NULL OR g.name = $2)
    AND ($3::TEXT IS NULL OR EXISTS (
      SELECT 1 FROM post_platform pp2
      JOIN platform pl2 ON pp2."platformId" = pl2.id
      WHERE pp2."postId" = p.id AND pl2.name = $3
    ))
    ORDER BY p."createdAt" DESC
    LIMIT $4 OFFSET $5;
  `;

  try {
    const result = await pool.query(query, [userUuid, gameName || null, filteredPlatform || null, limit, offset]);
    return result.rows;
  } catch (error) {
    console.error('Error fetching posts:', error);
    throw new Error('Failed to fetch posts');
  }
}

export const readUserCreatedPost = async (userUuid: string): Promise<any> => {
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
    WHERE p."userId" = (SELECT id FROM "user" where uuid = $1);
  `;

  try {
    const result = await pool.query(query, [userUuid]);
    return result.rows.length ? result.rows : [];
  } catch (error) {
    console.error('Error fetching post:', error);
    throw new Error('Failed to fetch post created by user');
  }
}

export const deletePostById = async (userUuid: string): Promise<any> => {
  const query = `
    DELETE FROM post
    WHERE post."userId" = (SELECT id FROM "user" WHERE uuid = $1);
  `;

  try {
    await pool.query(query, [userUuid]);
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

export const getTotalPostsCount = async (userUuid: string, gameName?: string): Promise<number> => {
  const query = `
    SELECT COUNT(*) AS "total"
    FROM post p
    LEFT JOIN game g ON p."gameId" = g.id
    WHERE ((SELECT id FROM "user" WHERE uuid = $1)::INT IS NULL 
    OR p."userId" IS DISTINCT FROM (SELECT id FROM "user" WHERE uuid = $1))
    AND ($2::TEXT IS NULL OR g.name = $2);
  `;

  try {
    const result = await pool.query(query, [userUuid, gameName || null]);
    return parseInt(result.rows[0].total, 10);
  } catch (error) {
    console.error('Error fetching total post count:', error);
    throw new Error('Failed to fetch total post count');
  }
}