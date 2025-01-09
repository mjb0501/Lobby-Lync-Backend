import pool from '../config/database';

export interface Game {
  id?: number;
  name: string;
}

export const searchGames = async (query: string): Promise<Game[]> => {
  const sql = `
    SELECT name
    FROM game
    WHERE name ILIKE $1
    LIMIT 10;
  `;
  try {
    const result = await pool.query(sql, [`%${query}%`]);
    return result.rows;
  } catch (error) {
    console.error('Error searching for games:', error);
    throw new Error('Failed to search for games');
  }
}

export const readGamePlatforms = async (gameName: string): Promise<any[]> => {
  const query = `
    SELECT g.id AS "gameId", p.name AS "platformName"
    FROM game g
    LEFT JOIN game_platform gp ON g.id = gp."gameId"
    LEFT JOIN platform p ON gp."platformId" = p.id
    WHERE g.name = $1;
  `;
  try {
    const result = await pool.query(query, [gameName]);
    return result.rows;
  } catch (error) {
    console.error('Error fetching platforms for game:', error);
    throw new Error('Failed to fetch platforms');
  }
}
