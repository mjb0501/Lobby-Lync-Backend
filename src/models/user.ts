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
    try {
        const result = await pool.query(query, values);
        return result.rows[0];
    } catch (error) {
        console.error('Error creating user:', error);
        throw new Error('Failed to create new user');
    }
};

export const getUserByEmail = async (email: string): Promise<User | null> => {
    const query = `
        SELECT id, username, email, password
        FROM "user"
        WHERE email = $1
    `;
    try {
        const result = await pool.query(query, [email]);
        return result.rows[0] || null;
    } catch (error) {
        console.error('Error fetching user by email:', error);
        throw new Error('Failed to find user by email');
    }
};

export const getUserById = async (id: number): Promise<User | null> => {
    const query = `
        SELECT id, username, email
        FROM "user"
        WHERE id = $1
    `;
    try {
        const result = await pool.query(query, [id]);
        console.log(result.rows[0]);
        return result.rows[0] || null;
    } catch (error) {
        console.error('Error fetching user by id:', error);
        throw new Error('Failed to find user by id');
    }
};

