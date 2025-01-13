import { getPlatformIdByName } from '../../src/models/platform';
import pool from '../../src/config/database';

jest.mock('../../src/config/database');

describe('Platform Model - Unit Tests', () => {
    afterEach(() => {
        jest.clearAllMocks();
    })

    describe('getPlatformIdByName', () => {
        it('should return the id of the platform name provided', async () => {
            (pool.query as jest.Mock).mockResolvedValueOnce({
                rows: [{ id: 1 }],
            });

            const platformId = await getPlatformIdByName('Nintendo Switch');
            expect(pool.query).toHaveBeenCalledWith(
            `
        SELECT id
        FROM platform
        WHERE name = $1
    `,
            ['Nintendo Switch']
            );
            expect(platformId).toBe(1);
        });

        it('should throw an error when the database query fails', async () => {
            const mockError = new Error('Database error');
            (pool.query as jest.Mock).mockRejectedValueOnce(mockError);
    
            await expect(getPlatformIdByName('Nintendo Switch')).rejects.toThrow(
                'Failed to find platform Id'
            );
            expect(pool.query).toHaveBeenCalledWith(
                `
        SELECT id
        FROM platform
        WHERE name = $1
    `,
                ['Nintendo Switch']
            );
        });
    });
});