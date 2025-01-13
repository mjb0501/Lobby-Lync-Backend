import { searchGames, readGamePlatforms } from '../../src/models/game';
import pool from '../../src/config/database';

jest.mock('../../src/config/database');

describe('Game Model - Unit Tests', () => {
    afterEach(() => {
        jest.clearAllMocks();
    });

    describe('searchGames', () => {
        it('should return a list of games matching the search query', async () => {
            const mockQuery = 'Zelda';
            const mockResult = {
                rows: [
                    { name: 'The Legend of Zelda' },
                    { name: 'Zelda: Breath of the Wild' },
                ],
            };

            (pool.query as jest.Mock).mockResolvedValueOnce(mockResult);

            const result = await searchGames(mockQuery);

            expect(pool.query).toHaveBeenCalledWith(
                expect.stringContaining(`
    SELECT name
    FROM game
    WHERE name ILIKE $1
    LIMIT 10;
  `),
                [`%${mockQuery}%`]
            );
            expect(result).toEqual(mockResult.rows);
        });

        it('should throw an error when the database query fails', async () => {
            const mockError = new Error('Database error');

            await expect(searchGames('mockQuery')).rejects.toThrow(
                'Failed to search for games'
            );
            expect(pool.query).toHaveBeenCalledWith(
                `
    SELECT name
    FROM game
    WHERE name ILIKE $1
    LIMIT 10;
  `,
                [`%mockQuery%`]
            );
        })
        
    });

    describe('readGamePlatforms', () => {
        it('should return a list of platforms for a given game', async () => {
            const mockGameName = 'The Legend of Zelda';
            const mockResult = {
                rows: [
                    { gameId: 1, platformName: 'Nintendo Switch' },
                    { gameId: 1, platformName: 'Wii U' },
                ],
            };

            (pool.query as jest.Mock).mockResolvedValueOnce(mockResult);

            const result = await readGamePlatforms(mockGameName);

            expect(pool.query).toHaveBeenCalledWith(
                expect.stringContaining(`
    SELECT g.id AS "gameId", p.name AS "platformName"
    FROM game g
    LEFT JOIN game_platform gp ON g.id = gp."gameId"
    LEFT JOIN platform p ON gp."platformId" = p.id
    WHERE g.name = $1;
  `),
                [mockGameName]
            );
            expect(result).toEqual(mockResult.rows);
        });

        it('should throw an error if the database query fails', async () => {
            const mockGameName = 'The Legend of Zelda';
            const mockError = new Error('Failed to fetch platforms');
            (pool.query as jest.Mock).mockRejectedValueOnce(mockError);

            await expect(readGamePlatforms(mockGameName)).rejects.toThrow('Failed to fetch platforms');
        });
    });
});