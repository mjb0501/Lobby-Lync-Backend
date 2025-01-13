import { getPlatformIdByName } from '../../src/models/platform';

describe('Platform Model - Integration Tests', () => {
    describe('getPlatformIdByName', () => {
        it('should return the id of the platformname provided', async () => {
            const result = await getPlatformIdByName('Nintendo Switch');
            expect(result).toBe(1);
        });

        it('should throw an error if the query fails', async () => {
            await expect(getPlatformIdByName('Nintendo 64')).rejects.toThrow(
                'Failed to find platform Id'
            );
        });
    });
});