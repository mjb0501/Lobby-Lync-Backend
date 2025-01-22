import { Request, Response } from "express";
import bcrypt from "bcrypt";
import { generateToken } from "../services/authService";
import { createUser, getUserByEmail, getUserById } from '../models/user';

export const register = async (req: Request, res: Response): Promise<void> => {
    try {
        const { username, email, password } = req.body;

        const hashedPassword = await bcrypt.hash(password, 10);

        const user = await createUser({ username, email, password: hashedPassword });

        res.status(201).json({ status: 'ok' });
    } catch (error) {
        console.error("Error registering user:", error);
        res.status(500).json({ error: "Error registering user" });
    }
};

export const login = async (req: Request, res: Response): Promise<void> => {
    try {
        const { email, password } = req.body;

        const user = await getUserByEmail(email);

        if (!user || typeof user.id !== 'number' || !(await bcrypt.compare(password, user.password))) {
            res.status(401).json({ error: "Invalid credentials" });
            return;
        }

        const token = generateToken(user.id);

        res.cookie("accessToken", token, {
            httpOnly: true,
            secure: process.env.NODE_ENV === "production",
            sameSite: process.env.NODE_ENV === "production" ? "strict" : "lax",
            maxAge: 2 * 60 * 60 * 1000,
        });

        res.status(200).json({ message: "Login successful" })
    } catch (error) {
        console.error("Error logging in:", error);
        res.status(500).json({ error: "Error logging in" });
    }
};

export const getUser = async (req: Request, res: Response): Promise<void> => {
    if (!req.userId) {
        res.status(400).json({ error: 'User is not authenticated' });
        return;
    }
    
    try {
        const user = await getUserById(req.userId);
        console.log(user);

        if (!user) throw Error;

        res.status(201).json(user)
    } catch (error) {
        console.log(error);
    }
} 

export const authLogout = (req: Request, res: Response): void => {
    res.clearCookie("accessToken", { httpOnly: true, secure: process.env.NODE_ENV === "production"});
    res.status(200).json({ message: "Successfully logged out" });
}
