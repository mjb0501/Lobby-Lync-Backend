import { Request, Response } from 'express';
import { insertPost, getPosts, acceptPost } from '../../src/controllers/postController';
import { createPost, readAllPosts } from '../../src/models/post';
import { createPostPlatform } from '../../src/models/post_platforms';
import { getPlatformIdByName } from '../../src/models/platform';
import { createPostAccept } from '../../src/models/post_acceptance';

jest.mock('../../src/models/post');
jest.mock('../../src/models/post_platforms');
jest.mock('../../src/models/platform');
jest.mock('../../src/models/post_acceptance');

describe('PostController - Unit Tests', () => {
    let req: Partial<Request>;
    let res: Partial<Response>;
    let jsonMock: jest.Mock;
    let statusMock: jest.Mock;

    beforeEach(() => {
        jsonMock = jest.fn();
        statusMock = jest.fn().mockReturnValue({ json: jsonMock });
        res = {
            status: statusMock,
            json: jsonMock,
        };
    });

    afterEach(() => {
        jest.clearAllMocks();
    });

    describe('insertPost', () => {
        it('should return 400 if user is not authenticated', async () => {
            req = { body: {}, userId: undefined };

            await insertPost(req as Request, res as Response);

            expect(res.status).toHaveBeenCalledWith(400);
            expect(res.json).toHaveBeenCalledWith({ error: 'User is not authenticated' });
        });

        it('should create a post and return 201 with postId', async () => {
            req = {
                body: {
                    platformIds: ['Platform1', 'Platform2'],
                    gameId: 1,
                    description: 'Test description',
                },
                userId: 123,
            };

            (createPost as jest.Mock).mockResolvedValueOnce({ id: 456 });
            (getPlatformIdByName as jest.Mock).mockResolvedValueOnce(1).mockResolvedValueOnce(2);

            await insertPost(req as Request, res as Response);

            expect(createPost).toHaveBeenCalledWith({
                userId: 123,
                gameId: 1,
                description: 'Test description',
            });
            expect(createPostPlatform).toHaveBeenCalledWith(1, 456);
            expect(createPostPlatform).toHaveBeenCalledWith(2, 456);
            expect(res.status).toHaveBeenCalledWith(201);
            expect(res.json).toHaveBeenCalledWith({ message: 'Post created successfully', postId: 456 });
        });

        it('should return 400 if a platform name is not found', async () => {
            req = {
                body: {
                    platformIds: ['Platform1'],
                    gameId: 1,
                    description: 'Test description',
                },
                userId: 123,
            };

            (createPost as jest.Mock).mockResolvedValueOnce({ id: 456 });
            (getPlatformIdByName as jest.Mock).mockResolvedValueOnce(null);

            await insertPost(req as Request, res as Response);

            expect(res.status).toHaveBeenCalledWith(400);
            expect(res.json).toHaveBeenCalledWith({ error: 'Platform name "Platform1" not found' });
        });

        it('should return 500 on unexpected error', async () => {
            req = { body: {}, userId: 123 };

            (createPost as jest.Mock).mockRejectedValueOnce(new Error('Database error'));

            await insertPost(req as Request, res as Response);

            expect(res.status).toHaveBeenCalledWith(500);
            expect(res.json).toHaveBeenCalledWith({ error: 'Error creating post' });
        });
    });

    describe('getPosts', () => {
        it('should return 200 with formatted posts', async () => {
            req = { userId: 123 };
            const mockPosts = [
                {
                    postId: 1,
                    user: 'User1',
                    gameName: 'Game1',
                    description: 'Description1',
                    createdAt: '2025-01-01',
                    platformName: 'Platform1',
                },
                {
                    postId: 1,
                    user: 'User1',
                    gameName: 'Game1',
                    description: 'Description1',
                    createdAt: '2025-01-01',
                    platformName: 'Platform2',
                },
            ];

            (readAllPosts as jest.Mock).mockResolvedValueOnce(mockPosts);

            await getPosts(req as Request, res as Response);

            expect(res.status).toHaveBeenCalledWith(200);
            expect(res.json).toHaveBeenCalledWith([
                {
                    postId: 1,
                    user: 'User1',
                    game: 'Game1',
                    description: 'Description1',
                    createdAt: '2025-01-01',
                    platforms: ['Platform1', 'Platform2'],
                },
            ]);
        });

        it('should return 500 on error', async () => {
            req = { userId: 123 };

            (readAllPosts as jest.Mock).mockRejectedValueOnce(new Error('Database error'));

            await getPosts(req as Request, res as Response);

            expect(res.status).toHaveBeenCalledWith(500);
            expect(res.json).toHaveBeenCalledWith({ error: 'Server error' });
        });
    });

    describe('acceptPost', () => {
        it('should return 400 if user is not authenticated', async () => {
            req = { body: {}, userId: undefined };

            await acceptPost(req as Request, res as Response);

            expect(res.status).toHaveBeenCalledWith(400);
            expect(res.json).toHaveBeenCalledWith({ error: 'User is not authenticated' });
        });

        it('should accept a post and return 201', async () => {
            req = {
                body: { postId: 1, description: 'Test acceptance' },
                userId: 123,
            };

            await acceptPost(req as Request, res as Response);

            expect(createPostAccept).toHaveBeenCalledWith({
                postId: 1,
                userId: 123,
                description: 'Test acceptance',
            });
            expect(res.status).toHaveBeenCalledWith(201);
            expect(res.json).toHaveBeenCalledWith({ message: 'Post accepted successfully' });
        });

        it('should return 500 on unexpected error', async () => {
            req = { body: { postId: 1, description: 'Test acceptance' }, userId: 123 };

            (createPostAccept as jest.Mock).mockRejectedValueOnce(new Error('Database error'));

            await acceptPost(req as Request, res as Response);

            expect(res.status).toHaveBeenCalledWith(500);
            expect(res.json).toHaveBeenCalledWith({ error: 'Error accepting post' });
        });
    });
});
