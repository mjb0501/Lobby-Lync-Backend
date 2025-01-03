import { Request, Response } from "express";
import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';
import User from '../models/user';
import { generateToken } from "../services/authService";

export const register = async (req: Request, res: Response): Promise<void> => {
    try 
    {
        //destructures the request body so that its values can be easily adjusted
        const { username, email, password } = req.body;
        //hashes password 10 times
        const hashedPassword = await bcrypt.hash(password, 10);
        const user = await User.create({username, email, password: hashedPassword });
        //status indicates 'created' and .json(user) sends the newly created user to the client
        res.status(201).json(user);
    } 
    catch (err) 
    {
        //500 indicates internal server error
        res.status(500).json({error: 'Error registering user'});
    }
};

export const login = async (req: Request, res: Response): Promise<void> => {
    try 
    {
        //destructures the request sent by user to extract email and password
        const { email, password } = req.body;
        //uses sequelize to find a user with the specified email
        const user = await User.findOne({ where: { email } });
        //checks if no user was found or if the password does not match
        //uses return to end the code there and not continue on after
        if (!user || !(await bcrypt.compare(password, user.password))) {
            res.status(401).json({ error: 'Invalid credentials' });
            return;
        }

        const token = generateToken(user.id);

        res.cookie('accessToken', token, {
            httpOnly: true,
            secure: process.env.NODE_ENV === 'production',
            sameSite: process.env.NODE_ENV === 'production' ? 'strict' : 'lax',
            maxAge: 2 * 60 * 60 * 1000,
        });



        // const token = jwt.sign(
        //     { id: user.id }, 
        //     process.env.JWT_SECRET!, 
        //     { expiresIn: '1h' }
        // );
        res.status(200).json({ message: 'Login successful' });
    } 
    catch (err) 
    {
        res.status(500).json({ error: 'Error logging in' });
    }
};

export const authLogout = (req: Request, res: Response): void => {
    res.clearCookie('accessToken', { httpOnly: true, secure: process.env.NODE_ENV === 'production' });

    res.status(200).json({ message: 'Successfully logged out' });
}