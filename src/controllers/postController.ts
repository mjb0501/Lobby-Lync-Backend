import { Request, Response } from 'express';
import Post from '../models/post';
import User from '../models/user';
import Platform from '../models/platform';
import Game from '../models/game';

export const createPost = async (req: Request, res: Response): Promise<void> => {
    try 
    {
        const { platformIds, gameId, description } = req.body;
        const userId = (req as any).user.id;

        const post = await Post.create({ userId, gameId, description });

        if (platformIds && Array.isArray(platformIds)) 
        {
            //fetches platforms from database
            const platforms = await Platform.findAll({
                where: { id: platformIds },
            });

            //establishes many to many relationship
            await post.addPlatforms(platforms);
        };

        const createdPost = await Post.findOne({
            where: { id: post.id},
            include: {
                model: Platform,
                attributes: ['id', 'name'],
                through: { attributes: [] },
            },
        });

        res.status(201).json(createdPost);
    }
    catch (err)
    {
        res.status(500).json({ error: `Error creating post ${err}` });
    }
};

export const getPosts = async (req: Request, res: Response) => {
    try 
    {
        //allows the user to filter by gameName and platformName
        const { gameName, platformName } = req.query;

        const whereConditions: any = {};
        const includeConditions: any[] = [
            {
                model: User,
                attributes: ['id', 'username'],
                as: 'User'
            },
            {
                model: Platform,
                attributes: ['id', 'name'],
                as: 'Platforms',
                through: { attributes: [] },
                ...(platformName && { where: { name: platformName } }),
            },
            {
                model: Game,
                attributes: ['id', 'name'],
                as: 'Game',
                ...(gameName && { where: { name: gameName } }),
            }
        ]

        //try and grab all posts ordered by createdAt from most recent to least
        const posts = await Post.findAll({
            where: whereConditions,
            include: includeConditions,
            order: [['createdAt', 'DESC']],
        });

        const formattedPosts = posts.map(post => ({
            id: post.id,
            description: post.description,
            createdAt: post.createdAt,
            user: post.User?.username, // Access the user username
            platforms: post.Platforms?.map(platform => platform.name),
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