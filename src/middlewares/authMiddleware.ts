import { Request, Response, NextFunction } from 'express';
import jwt from 'jsonwebtoken';
import cookieParser from 'cookie-parser';

export const useCookieParser = cookieParser();

export const authenticate = (req: Request, res: Response, next: NextFunction): void => {
    //this splits the authorization header so that the token in the header is assigned to token
    //header is formatted like: "Bearer <token>" this splits that string and grabs the token.
    //const token = req.headers.authorization?.split(' ')[1];
    const token = req.cookies.accessToken;
    if (!token) 
    {
        req.userId = null;
        return next();
    }

    try 
    {
        //validates the token with the secret key
        const decoded = jwt.verify(token, process.env.JWT_SECRET!) as { userId: number };

        //attaches the decoded token to the req object as a user cast as any to pass typescript check
        req.userId = decoded.userId;
        
        //indicates a succesful login
        //res.locals.loggedIn = true;

        //tells express to move onto next function
        next();
    }
    catch (err)
    {
        res.status(401).json({ error: 'Invalid token' });
    }
}

export const optionalAuthenticate = (req: Request, res: Response, next: NextFunction): void => {
    const token = req.cookies?.accessToken;

    if (!token) {
        return next();
    }

    try {
        const decoded = jwt.decode(token) as { userId: number } | null;

        if (decoded && decoded.userId) {
            req.userId = decoded.userId;
        }
    } catch (error) {
        console.error('Invalid token', error);
    }

    next();
};