require('dotenv').config();
import { Sequelize } from "sequelize";

console.log(process.env);  // Log environment variables
console.log(process.env.DB_HOST, process.env.DB_PORT, process.env.POSTGRES_DB);  // Log specific config values

export const sequelize = new Sequelize(process.env.POSTGRES_DB!, process.env.POSTGRES_USER!, process.env.POSTGRES_PASSWORD!, 
    {
        host: process.env.DB_HOST!,
        port: Number(process.env.DB_PORT),
        dialect: 'postgres',
        logging: process.env.NODE_ENV === 'development' ? console.log : false,
        pool: {
            max: 10, //max # of connections
            min: 0,
            idle: 10000, //close idle connections after 10 seconds
        }
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