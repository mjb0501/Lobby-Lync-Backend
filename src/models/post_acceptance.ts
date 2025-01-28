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

export const readAcceptedPosts = async (userId: number): Promise<any> => {
  const query = `
    SELECT p.id AS "postId", g.name AS "gameName", p.description,
      p."createdAt", pl.name AS "platformName", u.username AS "postCreator"
    FROM post_acceptance pa
    LEFT JOIN post p ON pa."postId" = p.id
    LEFT JOIN game g ON p."gameId" = g.id
    LEFT JOIN post_platform pp ON p.id = pp."postId"
    LEFT JOIN platform pl ON pp."platformId" = pl.id
    LEFT JOIN "user" u ON p."userId" = u.id
    WHERE pa."userId" = $1
  `;

  try {
    const result = await pool.query(query, [userId]);
    return result.rows.length ? result.rows : [];    
  } catch (error) {
    console.log(error);
  }
}

export const deletePostAcceptanceById = async (userId: number): Promise<any> => {
  const query = `
    DELETE FROM post_acceptance
    WHERE post_acceptance."userId" = $1
  `;

  try {
    await pool.query(query, [userId]);
  } catch (error) {
    console.error('Error deleting post acceptance by id:', error);
    throw new Error('Failed to delete post by id');
  }
}