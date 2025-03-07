import express from 'express';
import dotenv from 'dotenv';
import cors from 'cors';
import cookieParser from 'cookie-parser';
import authRoutes from './routes/authRoutes';
import postRoutes from './routes/postRoutes';
import gameRoutes from './routes/gameRoutes';
import messageRoutes from './routes/messageRoutes';
import pool from './config/database';
import http from 'http';
import { startPostCleanupJob, stopPostCleanupJob} from './services/postCleanupService';
import { setupWebSockets } from './websocket';
import { WebSocketServer } from 'ws';

dotenv.config();

const corsOptions = {
    //This specifies for cors that the calls will come from localhost...
    origin: ['http://localhost:5173', 'http://lobbylync.com'],
    methods: ['GET', 'POST', 'PUT', 'DELETE'],
    credentials: true,
}
console.log(process.env.NODE_ENV);

const app = express();
const server = http.createServer(app);
app.set('trust proxy', 1);
app.use(express.json());
app.use(cookieParser());
app.use(cors(corsOptions));

app.use('/api/auth', authRoutes);
app.use('/api/posts', postRoutes);
app.use('/api/games', gameRoutes);
app.use('/api/messages', messageRoutes);



const testDatabaseConnection = async () => {
    try {
        const result = await pool.query('SELECT NOW()');
        console.log('Database connected:', result.rows[0].now);
    } catch (error) {
        console.error('Failed to connect to the database:', error);
        process.exit(1);
    }
};

const shutDownHandler = async (server: ReturnType<typeof app.listen>) => {
    console.log('Gracefully shutting down...');
    stopPostCleanupJob();

    server.close(() => {
        console.log('Server closed.');
        process.exit(0);
    });

    setTimeout(() => {
        console.error('Forcing server shutdown...');
        process.exit(1);
    }, 10000);
};

(async () => {
    await testDatabaseConnection();

    const server = app.listen(process.env.PORT || 3001, () => {
        console.log(`Server is running on port ${process.env.PORT}`);

        setupWebSockets(server);
    });

    startPostCleanupJob();

    process.on('SIGINT', () => shutDownHandler(server));
    process.on('SIGTERM', () => shutDownHandler(server));
})();

export default app;
