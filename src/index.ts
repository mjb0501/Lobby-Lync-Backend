import express, { application } from 'express';
import dotenv from 'dotenv';
import cors from 'cors';
import cookieParser from 'cookie-parser';
import authRoutes from './routes/authRoutes';
import postRoutes from './routes/postRoutes';
import gameRoutes from './routes/gameRoutes';
import sequelize from './configs/database';
import { testDatabaseConnection } from './configs/database';
import defineAssociations from './models/modelAssociations';
import { startPostCleanupJob, stopPostCleanupJob} from './services/postCleanupService';

dotenv.config();

const corsOptions = {
    //This specifies for cors that the calls will come from localhost...
    origin: 'http://localhost:5173',
    methods: ['GET', 'POST', 'PUT', 'DELETE'],
    credentials: true,
}

const app = express();
app.use(express.json());
app.use(cookieParser());
app.use(cors(corsOptions));

app.use('/auth', authRoutes);
app.use('/posts', postRoutes);
app.use('/games', gameRoutes);

defineAssociations();

startPostCleanupJob();

sequelize.sync({}).then(() => {
    const server = app.listen(process.env.PORT || 3000, async () => { 
        console.log('Server running')
        await testDatabaseConnection();
    });

    const shutDownHandler = async () => {
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

    process.on('SIGINT', shutDownHandler);
    process.on('SIGTERM', shutDownHandler);
});

export default app;