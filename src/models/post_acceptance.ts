import pool from '../config/database';

export interface PostAcceptance {
  id?: number;
  postId: number;
  userId: number;
  description: string;
  platform: string;
  platformUsername?: string;
}

export const createPostAccept = async (postId: number, userUuid: string, description: string, platform: string, platformUsername: string): Promise<any> => {
  let query = `
    INSERT INTO post_acceptance ("postId", "userId", description, platform
  `;

  const values = [postId, userUuid, description, platform];
  if (platformUsername) {
    query += `, "platformUsername"`;
    values.push(platformUsername);
  }

  query += `) VALUES ($1, (SELECT id FROM "user" WHERE uuid = $2), $3, $4`;

  if (platformUsername) {
    query += `, $5`;
  }

  query += `) RETURNING "postId", "userId", description, platform, "platformUsername";`;

  try {
    const results = await pool.query(query, values);
    return results.rows[0];
  } catch (error) {
    console.error('Error creating post acceptance:', error);
    throw new Error('Failed to accept post');
  }
}

export const readAcceptedPosts = async (userUuid: string): Promise<any> => {
  const query = `
    SELECT p.id AS "postId", g.name AS "gameName", p.description,
      p."createdAt", pl.name AS "platformName", u.username AS "postCreator", c.id AS "conversationId"
    FROM post_acceptance pa
    LEFT JOIN post p ON pa."postId" = p.id
    LEFT JOIN game g ON p."gameId" = g.id
    LEFT JOIN post_platform pp ON p.id = pp."postId"
    LEFT JOIN platform pl ON pp."platformId" = pl.id
    LEFT JOIN "user" u ON p."userId" = u.id
    LEFT JOIN conversation c ON p.id = c."postId" AND pa."userId" = c."acceptorId"
    WHERE pa."userId" = (SELECT id FROM "user" WHERE uuid = $1)
  `;

  try {
    const result = await pool.query(query, [userUuid]);
    return result.rows.length ? result.rows : [];    
  } catch (error) {
    console.log(error);
  }
}

export const deletePostAcceptanceById = async (userUuid: string, postId: number): Promise<any> => {
  const query = `
    DELETE FROM post_acceptance
    WHERE post_acceptance."userId" = (SELECT id FROM "user" WHERE uuid = $1) AND post_acceptance."postId" = $2;
  `;

  try {
    await pool.query(query, [userUuid, postId]);
  } catch (error) {
    console.error('Error deleting post acceptance by id:', error);
    throw new Error('Failed to delete post by id');
  }
}

export const deletePostAcceptanceByUsername = async (username: string, postId: number): Promise<any> => {
  const query = `
    DELETE FROM post_acceptance
    USING "user"
    WHERE post_acceptance."userId" = "user".id
    AND "user".username = $1
    AND post_acceptance."postId" = $2;
  `;

  try {
    await pool.query(query, [username, postId]);
  } catch (error) {
    console.error('Error rejecting post acceptance:', error);
    throw new Error('Failed to reject post');
  }
}