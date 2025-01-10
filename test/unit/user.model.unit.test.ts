/*
This file ensures that the user model functions work as intended
*/
import { createUser, getUserByEmail } from '../../src/models/user';
import pool from '../../src/config/database';

//jest mocks the pool object to prevent real database queries
jest.mock('../../src/config/database');

//describe groups related tests under a common label 'User Model - Unit Tests'
describe('User Model - Unit Tests', () => {
    //ensures that mocks are cleared after each test
    afterEach(() => {
        jest.clearAllMocks();
    })

    //groups tests testing the createUser function
    describe('createUser', () => {
        it('should insert a user into the database and return the created user', async () => {
            //mocks the input data for the function
            const mockUser = { username: 'testuser', email: 'test@example.com', password: 'hashedpassword' };
            //mocks the database response simulating what pool.query would return for a succesful insert.
            const mockResult = {
                rows: [{ id: 1, username: 'testuser', email: 'test@example.com' }]
            };

            //Simulates the database returning mockResult
            (pool.query as jest.Mock).mockResolvedValueOnce(mockResult);

            //calls the createUser with the mock data
            const result = await createUser(mockUser);

            //expects pool.query to have been called with the described data
            expect(pool.query).toHaveBeenCalledWith(
                expect.stringContaining('INSERT INTO "user"'),
                [mockUser.username, mockUser.email, mockUser.password]
            );
            //verifies that the returned result matches the mock data
            expect(result).toEqual(mockResult.rows[0]);
        });
    });

    describe('getUserByEmail', () => {
        it('should return a user if the email exists in the database', async () => {
            const mockEmail = 'test@example.com';
            const mockResult = {
                rows: [{ id: 1, username: 'testuser', email: 'test@example.com', password: 'hashedpassword' }]
            };

            (pool.query as jest.Mock).mockResolvedValueOnce(mockResult);

            const result = await getUserByEmail(mockEmail);

            expect(pool.query).toHaveBeenCalledWith(
                expect.stringContaining('SELECT id, username, email, password'),
                [mockEmail]
            );
            expect(result).toEqual(mockResult.rows[0]);
        });

        it('should return null if the email does not exist in the database', async () => {
            const mockEmail = 'nonexistant@example.com';

            (pool.query as jest.Mock).mockResolvedValueOnce({ rows: [] });

            const result = await getUserByEmail(mockEmail);

            expect(pool.query).toHaveBeenCalledWith(
                expect.stringContaining('SELECT id, username, email, password'),
                [mockEmail]
            );
            expect(result).toBeNull();
        });
    });
});