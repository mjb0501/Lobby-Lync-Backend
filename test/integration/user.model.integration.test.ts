/* 
Tests the user model functions using a mock database
*/
import { createUser, getUserByEmail } from '../../src/models/user';
import pool from '../../src/config/database';

describe('User Model - Integration Tests', () => {
    afterEach(async () => {
        await pool.query('DELETE FROM "user";');
    });

    it('should insert a user into the database and retrieve it by email', async () => {
        const newUser = {
            username: 'testuser',
            email: 'test@example.com',
            password: 'hashedpassword',
        };

        const createdUser = await createUser(newUser);

        const fetchedUser = await getUserByEmail(newUser.email);

        expect(fetchedUser).toEqual({
            id: createdUser.id,
            username: newUser.username,
            email: newUser.email,
            password: newUser.password,
        });
    });

    it('should return null if the email does not exist in the database', async () => {
        const nonExistantEmail = 'nonexistant@example.com';

        const fetchedUser = await getUserByEmail(nonExistantEmail);

        expect(fetchedUser).toBeNull();
    });
});