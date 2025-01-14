import request from 'supertest';
import express from 'express';
import { authenticate, optionalAuthenticate } from '../../src/middlewares/authMiddleware';
import { generateToken } from '../../src/services/authService';
import cookieParser from 'cookie-parser';

const app = express();
app.use(cookieParser());
app.use(express.json());

// Setup routes for testing
app.post('/secure-endpoint', authenticate, (req, res) => {
    res.status(200).json({ message: 'Authenticated' });
});

app.post('/optional-endpoint', optionalAuthenticate, (req, res) => {
    res.status(200).json({ message: 'Optional authentication successful' });
});

describe('Integration Tests for Authentication Middlewares', () => {
    it('should return 401 if no token is provided for secure endpoint', async () => {
        const response = await request(app).post('/secure-endpoint');
        expect(response.status).toBe(401);
        expect(response.body.error).toBe('No token provided');
    });

    it('should return 401 if token is invalid for secure endpoint', async () => {
        const response = await request(app)
            .post('/secure-endpoint')
            .set('Cookie', 'accessToken=invalid-token');

        expect(response.status).toBe(401);
        expect(response.body.error).toBe('Invalid token');
    });

    it('should return success for valid token for secure endpoint', async () => {
        const validToken = generateToken(1);

        const response = await request(app)
            .post('/secure-endpoint')
            .set('Cookie', `accessToken=${validToken}`);

        expect(response.status).toBe(200);
        expect(response.body.message).toBe('Authenticated');
    });

    it('should return success for optional authentication endpoint', async () => {
        const validToken = generateToken(1);

        const response = await request(app)
            .post('/optional-endpoint')
            .set('Cookie', `accessToken=${validToken}`);

        expect(response.status).toBe(200);
        expect(response.body.message).toBe('Optional authentication successful');
    });

    it('should return success even without a token for optional authentication endpoint', async () => {
        const response = await request(app).post('/optional-endpoint');
        expect(response.status).toBe(200);
        expect(response.body.message).toBe('Optional authentication successful');
    });
});