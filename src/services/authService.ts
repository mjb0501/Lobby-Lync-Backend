import jwt from 'jsonwebtoken';

export const generateToken = (userUuid: string): string => {

    if (!process.env.JWT_SECRET) {
        throw Error("JWT SECRET not defined.");
    }

    const payload = { userUuid };

    const token = jwt.sign(payload, process.env.JWT_SECRET, { expiresIn: '2h' });

    return token;
}