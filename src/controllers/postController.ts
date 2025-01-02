import { Request, Response } from 'express';
import Post from '../models/post';
import User from '../models/user';
import Platform from '../models/platform';
import Game from '../models/game';

export const createPost = async (req: Request, res: Response): Promise<void> => {
    try 
    {
        const { platformIds, gameId, description } = req.body;
        //req has to be case as any since user is not explicitly defined in type for req
        const userId = (req as any).user.id;

        const post = await Post.create({ userId, gameId, description });

        //if platforms were provided and they are an array
        if (platformIds && Array.isArray(platformIds)) 
        {
            //finds all platform entries where id = platformIds
            const platforms = await Platform.findAll({
                where: { name: platformIds },
            });

            //establishes many to many relationship between post and platform
            //updates the post_platforms table
            await post.addPlatforms(platforms);
        };

        const createdPost = await Post.findOne({
            where: { id: post.id},
            include: {
                model: Platform,
                attributes: ['id', 'name'],
                through: { attributes: [] },
                as: 'platforms',
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
                //specifies the model User to be included
                model: User,
                //specifies the columns to be grabbed from the user table
                attributes: ['id', 'username'],
                //alias so that the relationship can be referred to as User
                as: 'User'
            },
            {
                model: Platform,
                attributes: ['id', 'name'],
                as: 'platforms',
                /*through is used with many to many relationships that require a relation table
                for this one post can have many platforms and one platform can have many posts
                This through specifies that none of the attributes from the post_platforms table
                will be used*/
                through: { attributes: [] },
                //Adds a where clause if platform name exists that specifies the post must have a specific platformName
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
            platforms: post.platforms?.map(platform => platform.name),
            game: post.Game?.name, // Access the game name
          }));

        res.status(200).json(formattedPosts);
    }
    catch (error)
    {
        console.error('Error fetching posts: ', error);
        res.status(500).json({message: 'Failed to fetch posts'});
    }
};