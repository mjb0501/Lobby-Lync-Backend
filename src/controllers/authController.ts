import { Request, Response } from "express";
import bcrypt from "bcrypt";
import { v4 as uuidv4} from 'uuid';
import { generateToken } from "../services/authService";
import { createUser, getUserByEmail, getUserByUuid } from '../models/user';
import { updateUserPlatform } from "../models/user_platforms";

export const register = async (req: Request, res: Response): Promise<void> => {
    try {
        const { username, email, password } = req.body;

        const hashedPassword = await bcrypt.hash(password, 12);

        const userUuid = uuidv4();

        const user = await createUser({ username, email, password: hashedPassword, uuid: userUuid });

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

        const token = generateToken(user.uuid);

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
    if (!req.userUuid) {
        res.status(200).json({ message: 'User is not authenticated' });
        return;
    }
    
    try {
        const userInfo = await getUserByUuid(req.userUuid);

        if (!userInfo) throw Error;

        const formattedUser = userInfo.reduce((acc: any[], row: any) => {
            let user = acc.find(u => u.id == row.id);

            if (!user) {
                user = {
                    id: row.id,
                    username: row.username,
                    email: row.email,
                    platforms: {}
                }
                acc.push(user);
            }

            //create a map between platforms and their respsective usernames
            if (row.platformName && !user.platforms[row.platforms]) {
                user.platforms[row.platformName] = row.platformUsername;
            }

            return acc;
        }, []);

        res.status(201).json(formattedUser)
    } catch (error) {
        console.log(error);
    }
} 

export const authLogout = (req: Request, res: Response): void => {
    res.clearCookie("accessToken", { httpOnly: true, secure: process.env.NODE_ENV === "production"});
    res.status(200).json({ message: "Successfully logged out" });
}

export const editPlatforms = async (req: Request, res: Response): Promise<void> => {
    if(!req.userUuid) {
        res.status(400).json({ error: 'User is not authenticated' });
        return;
    }

    try {

        const { Xbox, Playstation, Steam, Switch } = req.body
        const userUuid = req.userUuid;
        await updateUserPlatform({ userUuid, Xbox, Playstation, Steam, Switch })
        res.status(201).json({ status: 'ok' });
    } catch (error) {
        console.log(error);
    }
}
