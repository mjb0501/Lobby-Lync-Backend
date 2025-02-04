import { Request, Response } from 'express';
import { createPost, readAllPosts, readUserCreatedPost, deletePostById, updatePost } from '../models/post';
import { createPostPlatform, deletePostPlatforms } from '../models/post_platforms';
import { getPlatformIdByName } from '../models/platform';
import { createPostAccept, deletePostAcceptanceById, deletePostAcceptanceByUsername, readAcceptedPosts } from '../models/post_acceptance';
import { createConversation } from '../models/conversation';

export const insertPost = async (req: Request, res: Response): Promise<void> => {
    try {

        if (!req.userId) {
            res.status(400).json({ error: 'User is not authenticated' });
            return;
        }

        //this portion of code checks and ensures that a user does not already have an uploaded post
        const response = await readUserCreatedPost(req.userId);
        if (response.length > 0) {
            res.status(201).json({ message: 'Already have an uploaded post', postId: null});
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

export const editPost = async (req: Request, res: Response): Promise<void> => {
    try {

        if (!req.userId) {
            res.status(400).json({ error: 'User is not authenticated' });
            return;
        }

        const { postId, platformIds, gameId, description } = req.body;
        const userId = req.userId;

        const existingPost = await readUserCreatedPost(userId);
        if (!existingPost) {
            res.status(404).json({ error: 'Post not found' });
            return;
        }

        await updatePost(postId, userId, gameId, description);


        if (platformIds && Array.isArray(platformIds) && typeof postId == 'number') {

            await deletePostPlatforms(postId);

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
        
        res.status(200).json({ message: 'Post updated Successfully' });
    } catch (error) {
        console.error('Error editing post:', error);
        res.status(500).json({ error: 'Error editing post'});
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
                    userId: row.userId,
                    user: row.user,
                    gameId: row.gameId,
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
            res.status(400).json({ error: 'user is not authenticated'});
            return;
        }

        const post = await readUserCreatedPost(req.userId);

        console.log(post);

        //runs if no posts were found
        if (post.length == 0) {
            res.status(200).json(null);
            return;
        }

        let userPostInformation: any = {
            postId: post[0].postId,
            game: post[0].gameName,
            gameId: post[0].gameId,
            description: post[0].description,
            createdAt: post[0].createdAt,
            platforms: [],
            acceptances: [],
        };

        post.forEach((row: any) => {
            if (row.platformName && !userPostInformation.platforms.includes(row.platformName)) {
                userPostInformation.platforms.push(row.platformName);
            }

            if (row.username && !userPostInformation.acceptances.some((item: any) => item.username === row.username && item.description === row.acceptDescription)) {
                userPostInformation.acceptances.push({ 
                    username: row.username, description: row.acceptDescription, 
                    platform: row.acceptPlatform, platformUsername: row.acceptedPlatformUsername, 
                    conversationId: row.conversationId
                });
            }
        })

        res.status(200).json(userPostInformation);
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

        const { postId, description, platform, platformUsername, creatorId } = req.body;
        const userId = req.userId;

        await createPostAccept({ postId, userId, description, platform, platformUsername });

        console.log('creatorid', creatorId);

        await createConversation(postId, creatorId, userId);

        res.status(201).json({ message: 'Post accepted successfully' });
    } catch (error) {
        console.error('Error accepting post:', error);
        res.status(500).json({ error: 'Error accepting post' });
    }
}

export const deletePost = async (req: Request, res: Response): Promise<void> => {
    try {
        if (!req.userId) {
            res.status(400).json({ error: 'user is not authenticated'});
            return;
        }

        await deletePostById(req.userId);

        res.status(200).json({ message: 'Post deleted successfully'});
    } catch (error) {
        console.error('Error deleting post:', error);
        res.status(500).json({ error: 'Server Error' });
    }
}

export const deletePostAcceptance = async (req: Request, res: Response): Promise<void> => {
    try {
        if (!req.userId) {
            res.status(400).json({ error: 'user is not authenticated'});
            return;
        }

        //console.log("delete hit");

        const postId = req.params.postId || req.query.postId;

        if (!postId) {
            res.status(400).json({ error: 'Missing acceptId'});
            return;
        }

        console.log("delete hit");
        
        await deletePostAcceptanceById(req.userId, Number(postId));

        res.status(200).json({ message: 'Post acceptance deleted successfully'});
    } catch (error) {
        console.error('Error deleting post acceptance', error);
        res.status(500).json({ error: 'Server Error' });
    }
}

export const rejectPostAcceptance = async (req: Request, res: Response): Promise<void> => {
    try {
        if (!req.userId) {
            res.status(400).json({ error: 'user is not authenticated'});
            return;
        }

        const {username, postId } = req.body;

        if (!postId || !username) {
            res.status(400).json({ error: 'Missing Information for Reject'});
            return;
        }

        await deletePostAcceptanceByUsername(username, postId);

        res.status(200).json({ message: 'Post acceptance succesfully rejected' });
    } catch (error) {
        console.error('Error rejecting post acceptnace', error);
        res.status(500).json({ error: 'Server Error' });
    }
}

export const getAcceptedPosts = async (req: Request, res: Response): Promise<void> => {
    try {
        if (!req.userId) {
            res.status(400).json({ error: 'user is not authenticated'});
            return;
        }

        const posts = await readAcceptedPosts(req.userId);

        const formattedPosts = posts.reduce((acc: any[], row: any) => {
            let post = acc.find(p => p.postId == row.postId);

            if (!post) {
                post = {
                    postId: row.postId,
                    creator: row.postCreator,
                    game: row.gameName,
                    description: row.description,
                    createdAt: row.createdAt,
                    platforms: []
                }
                acc.push(post);
            }

            if (row.platformName && !post.platforms.includes(row.platformName)) {
                post.platforms.push(row.platformName);
            }

            return acc;
        }, []);

        res.status(200).json(formattedPosts);
    } catch (error) {
        console.log(error);
    }
}