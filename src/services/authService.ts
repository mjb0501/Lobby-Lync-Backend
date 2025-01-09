import jwt from 'jsonwebtoken';

export const generateToken = (userId: number): string => {

    if (!process.env.JWT_SECRET) {
        throw Error("JWT SECRET not defined.");
    }

    const payload = { userId };

    const token = jwt.sign(payload, process.env.JWT_SECRET, { expiresIn: '2h' });

    return token;
}