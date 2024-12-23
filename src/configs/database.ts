require('dotenv').config();
import { Sequelize } from "sequelize";

const sequelize = new Sequelize(
    process.env.DB_NAME!,
    process.env.DB_USER!, 
    process.env.DB_PASSWORD!, 
    {
        host: process.env.DB_HOST!,
        port: Number(process.env.DB_PORT),
        dialect: 'postgres',
    }
);

//testing the connection to ensure it is connected
export const testDatabaseConnection = async () => {
    try {
        await sequelize.authenticate();
        console.log('Database connection has been established successfully.');
    } catch (err) {
        console.error('Unable to connect to the database:', err);
    }
};

export default sequelize;