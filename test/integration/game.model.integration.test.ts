import { searchGames, readGamePlatforms } from '../../src/models/game';

describe('Game Model - Integration Tests', () => {
    describe('searchGames', () => {
        it('should return a list of games matching the search query', async () => {
            const result = await searchGames('Zelda');
            expect(result.length).toBeGreaterThan(0);
            expect(result[0].name).toBe('The Legend of Zelda');
        });
    });

    describe('readGamePlatforms', () => {
        it('should return a list of platforms for a given game', async () => {
            const result = await readGamePlatforms('The Legend of Zelda');
            expect(result.length).toBeGreaterThan(0);
            expect(result[0].platformName).toBe('Nintendo Switch');
        });
    });
});