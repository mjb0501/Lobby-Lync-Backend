import { Request, Response, NextFunction } from 'express';
import jwt from 'jsonwebtoken';

export const authenticate = (req: Request, res: Response, next: NextFunction): void => {
    //this splits the authorization header so that the token in the header is assigned to token
    //header is formatted like: "Bearer <token>" this splits that string and grabs the token.
    const token = req.headers.authorization?.split(' ')[1];
    if (!token) 
    {
        res.status(401).json({error: 'No token provided' });
        return;
    }

    try 
    {
        //validates the token with the secret key
        const decoded = jwt.verify(token, process.env.JWT_SECRET!);
        //attaches the decoded token to the req object as a user cast as any to pass typescript check
        (req as any).user = decoded;
        //tells express to move onto next function
        next();
    }
    catch (err)
    {
        res.status(401).json({ error: 'Invalid token' });
    }
}