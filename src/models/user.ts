import pool from '../config/database';

export interface User {
    id?: number;
    username: string;
    email: string;
    password: string;
}

export const createUser = async (user: User): Promise<User> => {
    const query = `
        INSERT INTO "user" (username, email, password)
        VALUES ($1, $2, $3)
        RETURNING id, username, email;
    `;
    const values = [user.username, user.email, user.password];
    const result = await pool.query(query, values);
    return result.rows[0];
};

export const getUserByEmail = async (email: string): Promise<User | null> => {
    const query = `
        SELECT id, username, email, password
        FROM "user"
        WHERE email = $1
    `;
    const result = await pool.query(query, [email]);
    return result.rows[0] || null;
};

