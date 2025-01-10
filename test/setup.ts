/*
Sets up a mock database to be used in integration tests
*/
import pool from '../src/config/database';

beforeAll(async () => {
    try {
        await pool.query(`
            CREATE TABLE IF NOT EXISTS "user" (
                id SERIAL PRIMARY KEY,
                username VARCHAR(255) NOT NULL UNIQUE,
                email VARCHAR(255) NOT NULL UNIQUE,
                password VARCHAR(255) NOT NULL
            );
        `);
        await pool.query('SELECT setval(\'user_id_seq\', (SELECT MAX(id) FROM "user"));');
        await pool.query(`
            CREATE TABLE IF NOT EXISTS game (
                id SERIAL PRIMARY KEY,
                name VARCHAR(255) NOT NULL UNIQUE
            );
        `);
        await pool.query(`
            CREATE TABLE IF NOT EXISTS platform (
                id SERIAL PRIMARY KEY,
                name VARCHAR(255) NOT NULL UNIQUE
            );
        `);
        await pool.query(`
            CREATE TABLE IF NOT EXISTS game_platform (
                "gameId" INT REFERENCES game(id),
                "platformId" INT REFERENCES platform(id)
            );
        `);
        await pool.query(`
            INSERT INTO game (name) VALUES ('The Legend of Zelda'), ('Zelda: Breath of the Wild');
        `);
        await pool.query(`
            INSERT INTO platform (name) VALUES ('Nintendo Switch'), ('Wii U');
        `);
        await pool.query(`
            INSERT INTO game_platform ("gameId", "platformId") VALUES 
                (1, 1), (1, 2), (2, 1);
        `);
        console.log('Database connection successful!');
    } catch (error) {
        console.error('Database connection failed: ', error);
    }
});

afterAll(async () => {
    await pool.query('DROP TABLE IF EXISTS game_platform, platform, game, "user"');
    await pool.end();
});