import { Request, Response } from 'express';
import { createPost, readAllPosts, readUserCreatedPost } from '../models/post';
import { createPostPlatform } from '../models/post_platforms';
import { getPlatformIdByName } from '../models/platform';
import { createPostAccept } from '../models/post_acceptance';

export const insertPost = async (req: Request, res: Response): Promise<void> => {
    try {

        if (!req.userId) {
            res.status(400).json({ error: 'User is not authenticated' });
            return;
        }

        const { platformIds, gameId, description } = req.body;
        const userId = req.userId;

        const result = await createPost({ userId, gameId, description });

        const postId = result.id;
        
        if (platformIds && Array.isArray(platformIds) && typeof postId == 'number') {
            for (const platformName of platformIds) {
                const platformId = await getPlatformIdByName(platformName);

                if (platformId) {
                    await createPostPlatform(platformId, postId);
                } else {
                    console.error(`Platform name "${platformName}" not found`);
                    res.status(400).json({ error: `Platform name "${platformName}" not found` });
                    return;
                }
            }
        }

        res.status(201).json({ message: 'Post created successfully', postId });
    } catch (error) {
        console.error('Error creating post:', error);
        res.status(500).json({ error: 'Error creating post' });
    }
}

export const getPosts = async (req: Request, res: Response): Promise<void> => {
    try {
        let posts: any;

        const gameName = req.query.gameName as string;

        posts = await readAllPosts(req.userId, gameName);

        const formattedPosts = posts.reduce((acc: any[], row: any) => {
            let post = acc.find(p => p.postId == row.postId);
        
            if (!post) {
                post = {
                    postId: row.postId,
                    user: row.user,
                    game: row.gameName,
                    description: row.description,
                    createdAt: row.createdAt,
                    platforms: []
                };
                acc.push(post);
            }

            if (row.platformName && !post.platforms.includes(row.platformName)) {
                post.platforms.push(row.platformName);
            }

            return acc;
        }, []);

        res.status(200).json(formattedPosts);
    } catch (error) {
        console.error('Error fetching posts:', error);
        res.status(500).json({ error: 'Server error' });
    }
};

export const getPostById = async (req: Request, res: Response): Promise<void> => {
    try {
        if (!req.userId) {
            console.error('Error fetching post by id');
            res.status(400).json({ message: 'user is not authenticated'});
            return;
        }

        const post = await readUserCreatedPost(req.userId);

        let formattedPost: any = {
            postId: post[0].postId,
            user: post[0].user,
            game: post[0].gameName,
            description: post[0].description,
            createdAt: post[0].createdAt,
            platforms: [],
        };

        post.forEach((row: any) => {
            formattedPost.platforms.push(row.platformName);
        })

        res.status(200).json(formattedPost);
    } catch (error) {
        console.error('Error fetching post by id:', error);
        res.status(500).json({ error: 'Server Error' });
    }
}

export const acceptPost = async (req: Request, res: Response): Promise<void> => {
    try {
        if (!req.userId) {
            res.status(400).json({ error: 'User is not authenticated' });
            return;
        }

        const { postId, description } = req.body;
        const userId = req.userId;

        await createPostAccept({ postId, userId, description });

        res.status(201).json({ message: 'Post accepted successfully' });
    } catch (error) {
        console.error('Error accepting post:', error);
        res.status(500).json({ error: 'Error accepting post' });
    }
}
