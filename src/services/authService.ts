import jwt from 'jsonwebtoken';
import User from '../models/user';

const JWT_SECRET_KEY = process.env.JWT_SECRET || 'secret';

export const generateToken = (userId: number): string => {
    const payload = { userId };

    const token = jwt.sign(payload, JWT_SECRET_KEY, { expiresIn: '2h' });

    return token;
}