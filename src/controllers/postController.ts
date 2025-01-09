import { Request, Response } from 'express';
import { createPost, readAllPosts } from '../models/post';
import { createPostPlatform } from '../models/post_platforms';
import { getPlatformIdByName } from '../models/platform';

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
        const posts = await readAllPosts();

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
