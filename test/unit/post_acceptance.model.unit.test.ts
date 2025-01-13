import { createPostAccept } from '../../src/models/post_acceptance';
import pool from '../../src/config/database';

jest.mock('../../src/config/database');

describe('Post Acceptance Model - Unit Tests', () => {

    describe('createPostAccept', () => {
        it('should call the database with the correct query', async () => {
            const mockPostAcceptance = { postId: 1, userId: 1, description: 'test' };

            (pool.query as jest.Mock).mockResolvedValueOnce({ rows: [] });
            
            await createPostAccept(mockPostAcceptance);

            expect(pool.query).toHaveBeenCalledWith(
                `
    INSERT INTO post_acceptance ("postId", "userId", description)
    VALUES ($1, $2, $3)
    RETURNING "postId", "userId", description;
  `,
                [1, 1, 'test']
            );
        });

        it('should throw an error when the database query fails', async () => {
            const mockError = new Error('Database error');
            const mockPostAcceptance = { postId: -50, userId: 1, description: 'test'};
            (pool.query as jest.Mock).mockRejectedValueOnce(mockError);

            await expect(createPostAccept(mockPostAcceptance)).rejects.toThrow(
                'Failed to accept post'
            );
            expect(pool.query).toHaveBeenCalledWith(
                `
    INSERT INTO post_acceptance ("postId", "userId", description)
    VALUES ($1, $2, $3)
    RETURNING "postId", "userId", description;
  `,
                [-50, 1, 'test']
            );
        });
        
    });
});