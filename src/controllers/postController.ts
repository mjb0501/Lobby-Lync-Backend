import { Request, Response } from 'express';
import Post from '../models/post';
import User from '../models/user';
import Platform from '../models/platform';
import Game from '../models/game';

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

export const getPosts = async (req: Request, res: Response) => {
    try 
    {
        //try and grab all posts ordered by createdAt from most recent to least
        const posts = await Post.findAll({
            include: [
                //Make sure to always include as '...' otherwise will not work
                { model: User, attributes: ['id', 'username'], as: 'User' },
                { model: Platform, attributes: ['id', 'name'], as: 'Platform' },
                { model: Game, attributes: ['id', 'name'], as: 'Game' },
            ],
            order: [['createdAt', 'DESC']],
            raw: false,
            nest: true,
        });

        const formattedPosts = posts.map(post => ({
            id: post.id,
            description: post.description,
            createdAt: post.createdAt,
            user: post.User?.username, // Access the user username
            platform: post.Platform?.name, // Access the platform name
            game: post.Game?.name, // Access the game name
          }));

        res.status(200).json(formattedPosts);
    }
    catch (err)
    {
        console.error('Error fetching posts: ', err);
        res.status(500).json({message: 'Failed to fetch posts'});
    }
};