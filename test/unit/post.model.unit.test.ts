import { createPost, readAllPosts, deleteOldPosts } from '../../src/models/post';
import pool from '../../src/config/database';

//jest mocks the pool object to prevent real database queries
jest.mock('../../src/config/database');

//describe groups related tests under a common label 'Post Model - Unit Tests'
describe('Post Model - Unit Tests', () => {
  afterEach(() => {
    jest.clearAllMocks(); // Clears mock data after each test
  });

  // Tests for createPost function
  describe('createPost', () => {
    it('should insert a post into the database and return the created post', async () => {
      const mockPost = { userId: 1, gameId: 1, description: 'Test Post' };
      const mockResult = {
        rows: [{ id: 1, userId: 1, gameId: 1, description: 'Test Post', createdAt: new Date() }],
      };

      (pool.query as jest.Mock).mockResolvedValueOnce(mockResult);

      const result = await createPost(mockPost);

      expect(pool.query).toHaveBeenCalledWith(
        expect.stringContaining('INSERT INTO post'),
        [mockPost.userId, mockPost.gameId, mockPost.description]
      );
      expect(result).toEqual(mockResult.rows[0]);
    });

    it('should throw an error when the database query fails', async () => {
      const mockError = new Error('Database error');
      (pool.query as jest.Mock).mockRejectedValueOnce(mockError);

      await expect(createPost({ userId: 1, gameId: 1, description: 'Test Post' })).rejects.toThrow(
        'Failed to create post'
      );
    });
  });

  // Tests for readAllPosts function
  describe('readAllPosts', () => {
    it('should return posts for a user if userId is provided', async () => {
      const mockUserId = 1;
      const mockResult = {
        rows: [
          { postId: 1, user: 'testuser', gameName: 'Zelda', description: 'Test', createdAt: new Date(), platformName: 'Nintendo Switch' },
        ],
      };

      (pool.query as jest.Mock).mockResolvedValueOnce(mockResult);

      const result = await readAllPosts(mockUserId);

      expect(pool.query).toHaveBeenCalledWith(expect.stringContaining('SELECT p.id AS "postId"'), [mockUserId]);
      expect(result).toEqual(mockResult.rows);
    });

    it('should return all posts if no userId is provided', async () => {
      const mockResult = {
        rows: [
          { postId: 1, user: 'testuser', gameName: 'Zelda', description: 'Test', createdAt: new Date(), platformName: 'Nintendo Switch' },
        ],
      };

      (pool.query as jest.Mock).mockResolvedValueOnce(mockResult);

      const result = await readAllPosts();

      expect(pool.query).toHaveBeenCalledWith(expect.stringContaining('SELECT p.id AS "postId"'), [null]);
      expect(result).toEqual(mockResult.rows);
    });

    it('should throw an error when the database query fails', async () => {
      const mockError = new Error('Database error');
      (pool.query as jest.Mock).mockRejectedValueOnce(mockError);

      await expect(readAllPosts()).rejects.toThrow('Failed to fetch posts');
    });
  });

  // Tests for deleteOldPosts function
  describe('deleteOldPosts', () => {
    it('should delete old posts and return the number of posts deleted', async () => {
      const mockTime = '2023-01-01';
      const mockResult = { rowCount: 2 };

      (pool.query as jest.Mock).mockResolvedValueOnce(mockResult);

      const result = await deleteOldPosts(mockTime);

      expect(pool.query).toHaveBeenCalledWith(expect.stringContaining('DELETE FROM post'), [mockTime]);
      expect(result).toBe(2);
    });

    it('should throw an error when the database query fails', async () => {
      const mockError = new Error('Database error');
      (pool.query as jest.Mock).mockRejectedValueOnce(mockError);

      await expect(deleteOldPosts('2023-01-01')).rejects.toThrow('Failed to delete old posts');
    });
  });
});