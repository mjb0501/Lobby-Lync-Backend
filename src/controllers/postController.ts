import { Request, Response } from 'express';
import Post from '../models/post';

export const createPost = async (req: Request, res: Response): Promise<void> => {
    try 
    {
        const { platformId, gameId, description } = req.body;
        const userId = (req as any).user.id;
        const post = await Post.create({ userId, platformId, gameId, description });
        res.status(201).json(post);
    }
    catch (err)
    {
        res.status(500).json({ error: 'Error creating post' });
    }
};