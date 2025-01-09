import pool from '../config/database';

export interface Platform {
    id?: number;
    name: string;
}

export const getPlatformIdByName = async (platformName: string): Promise<number | null> => {
    const query = `
        SELECT id
        FROM platform
        WHERE name = $1
    `;
    const result = await pool.query(query, [platformName]);
    return result.rows[0].id;
}

