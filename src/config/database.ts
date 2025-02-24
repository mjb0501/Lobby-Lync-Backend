require('dotenv').config();
import { Pool } from 'pg';

const isProduction = process.env.NODE_ENV === 'production';
//console.log(isProduction)

const pool = new Pool({
    user: process.env.POSTGRES_USER,
    password: process.env.POSTGRES_PASSWORD,
    host: isProduction ? 'db' : 'localhost',
    port: Number(process.env.DB_PORT),
    database: process.env.NODE_ENV === 'test' ? 'testDB' : process.env.POSTGRES_DB,
    max: 10,
    idleTimeoutMillis: 10000,
});

export const query = (text: string, params?: any[]) => pool.query(text, params);

pool.on('connect', () => {
    console.log('Database connected successfully.');
});

pool.on('error', (err) => {
    console.log('Unexpected error on idle client', err);
    process.exit(-1);
});

export default pool;