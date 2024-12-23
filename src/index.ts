import express, { application } from 'express';
import dotenv from 'dotenv';
import bodyParser from 'body-parser';
import cors from 'cors';
import authRoutes from './routes/authRoutes';
import postRoutes from './routes/postRoutes';
import sequelize from './configs/database';
import { testDatabaseConnection } from './configs/database';

dotenv.config();

const app = express();
app.use(bodyParser.json());
app.use(cors());

app.use('/auth', authRoutes);
app.use('/posts', postRoutes);

sequelize.sync().then(() => {
    app.listen(process.env.PORT || 3000, async () => { 
        console.log('Server running')
        await testDatabaseConnection();
    });
});

export default app;