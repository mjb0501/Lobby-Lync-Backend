/*
WARNING: This should only be utilized on a test database (Will Delete Data)
Currently it is setup to work on the actual database not a test database
*/
//supertest allows request for testing express applications
import request from 'supertest';
import app from '../../src/index'
import { sequelize } from '../../src/configs/database';

//starts a jest suite
describe('Auth Routes', () => {
    //runs before any of the tests in the suite run
    beforeAll(async () => {
        await sequelize.sync({ force: true });
    });

    //runs after all of the tests in the suite have ran
    afterAll(async () => {
        await sequelize.close();
    });

    //defines a test case that attempts to register a new user
    it('should register a new user', async () => {
        //makes a request to the app using the following information
        const response = await request(app)
            .post('/auth/register')
            .send({
                username: 'testuser4',
                email: 'testuser@example.com',
                password: 'password123',
            });

        //defines what the response from the app should be
        expect(response.status).toBe(201);
        expect(response.body).toHaveProperty('id');
        expect(response.body).toHaveProperty('email', 'testuser@example.com');
    });

    it('should login a preexisting user', async () => {
        const response = await request(app)
            .post('/auth/login')
            .send({
                email: 'testuser@example.com',
                password: 'password123',
            });

            expect(response.body).toHaveProperty('token');
    })
})