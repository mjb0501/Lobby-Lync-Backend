import { createPostPlatform } from '../../src/models/post_platforms';
import pool from '../../src/config/database';

jest.mock('../../src/config/database'); // Mock the database module

describe('Post Platform Model - Unit Tests', () => {
  describe('createPostPlatform', () => {
    it('should call the database with the correct query', async () => {
      const platformId = 1;
      const postId = 42;

      // Mock the database query
      (pool.query as jest.Mock).mockResolvedValueOnce({ rows: [] });

      await createPostPlatform(platformId, postId);

      expect(pool.query).toHaveBeenCalledWith(
        `
    INSERT INTO post_platform ("platformId", "postId")
    VALUES ($1, $2)
  `,
        [1, 42]
      );
    });

    it('should throw an error when the database query fails', async () => {
      const platformId = -1;
      const postId = 42;
      const mockError = new Error('Database error');

      // Mock the database query to reject
      (pool.query as jest.Mock).mockRejectedValueOnce(mockError);

      await expect(createPostPlatform(platformId, postId)).rejects.toThrow(
        'Failed to assign platforms to post'
      );
      expect(pool.query).toHaveBeenCalledWith(
        `
    INSERT INTO post_platform ("platformId", "postId")
    VALUES ($1, $2)
  `,
        [-1, 42]
      );
    });
    
  });
});