import { createPostAccept } from "../../src/models/post_acceptance";

describe('Post Accept Model - Integration Tets', () => {
    describe('searchGames', () => {
        it('should create post acceptance', async () => {
            const result = await createPostAccept({ postId: 1, userId: 1, description: 'test accept'});
            expect(result).toEqual({
                postId: 1,
                userId: 1,
                description: 'test accept',
            });
        });
    });
});