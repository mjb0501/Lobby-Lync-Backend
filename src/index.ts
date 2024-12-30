import express, { application } from 'express';
import dotenv from 'dotenv';
import bodyParser from 'body-parser';
import cors from 'cors';
import authRoutes from './routes/authRoutes';
import postRoutes from './routes/postRoutes';
import gameRoutes from './routes/gameRoutes';
import sequelize from './configs/database';
import { testDatabaseConnection } from './configs/database';
import defineAssociations from './models/modelAssociations';

dotenv.config();

const app = express();
app.use(bodyParser.json());
app.use(cors());

app.use('/auth', authRoutes);
app.use('/posts', postRoutes);
app.use('/games', gameRoutes);

defineAssociations();

sequelize.sync({ alter: true }).then(() => {
    app.listen(process.env.PORT || 3000, async () => { 
        console.log('Server running')
        await testDatabaseConnection();
    });
});

export default app;