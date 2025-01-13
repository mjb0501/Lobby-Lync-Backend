import { authenticate, optionalAuthenticate } from '../../src/middlewares/authMiddleware';
import { Request, Response, NextFunction } from 'express';
import jwt from 'jsonwebtoken';

jest.mock('jsonwebtoken');

describe('Authenticate Middleware - Unit Tests', () => {
    const mockNext = jest.fn();
    const mockResponse = {} as Response;

    let mockRequest: Partial<Request>;

    beforeEach(() => {
        mockRequest = {
            cookies: {
                accessToken: 'valid-token'
            }
        };
    });

    afterEach(() => {
        jest.clearAllMocks();
    });

    describe('authenticate', () => {
        it('should call next() if token is valid', () => {
            const mockDecodedToken = { userId: 1 };
            (jwt.verify as jest.Mock).mockReturnValue(mockDecodedToken);
    
            const mockRes = mockResponse as Response;
            mockRes.status = jest.fn().mockReturnValue(mockRes);
            mockRes.json = jest.fn();
    
            authenticate(mockRequest as Request, mockRes, mockNext);
    
            expect(mockNext).toHaveBeenCalled();
            expect(mockRequest.userId).toBe(1);
        });
    
        it('should return 401 if no token is provided', () => {
            mockRequest.cookies = {};  // No token in cookies
    
            const mockRes = mockResponse as Response;
            mockRes.status = jest.fn().mockReturnValue(mockRes);  // Mock status function
            mockRes.json = jest.fn();  // Mock json function
    
            authenticate(mockRequest as Request, mockRes, mockNext);
    
            expect(mockRes.status).toHaveBeenCalledWith(401);
            expect(mockRes.json).toHaveBeenCalledWith({
                error: 'No token provided',
                loggedIn: false
            });
        });
    
        it('should return 401 if token is invalid', () => {
            (jwt.verify as jest.Mock).mockImplementation(() => {
                throw new Error('Invalid token');
            });
    
            const mockRes = mockResponse as Response;
            mockRes.status = jest.fn().mockReturnValue(mockRes);  // Mock status function
            mockRes.json = jest.fn();  // Mock json function
    
            authenticate(mockRequest as Request, mockRes, mockNext);
    
            expect(mockRes.status).toHaveBeenCalledWith(401);
            expect(mockRes.json).toHaveBeenCalledWith({
                error: 'Invalid token'
            });
        });
    });

    describe('optionalAuthenticate', () => {
        it('should call next() if token is valid', () => {
            const mockDecodedToken = { userId: 1 };
            (jwt.decode as jest.Mock).mockReturnValue(mockDecodedToken);
    
            const mockRes = mockResponse as Response;
            mockRes.status = jest.fn().mockReturnValue(mockRes);  // Mock status function
            mockRes.json = jest.fn();  // Mock json function
    
            optionalAuthenticate(mockRequest as Request, mockRes, mockNext);
    
            expect(mockNext).toHaveBeenCalled();
            expect(mockRequest.userId).toBe(1);
        });

        it('should call next() if no token is provided', () => {
            mockRequest.cookies = {};  // No token in cookies
    
            const mockRes = mockResponse as Response;
            mockRes.status = jest.fn().mockReturnValue(mockRes);  // Mock status function
            mockRes.json = jest.fn();  // Mock json function
    
            optionalAuthenticate(mockRequest as Request, mockRes, mockNext);
    
            expect(mockNext).toHaveBeenCalled();
            expect(mockRequest.userId).toBeUndefined();
        });

        it('should handle invalid token format', () => {
            (jwt.decode as jest.Mock).mockReturnValue(null); // Invalid token format
    
            const mockRes = mockResponse as Response;
            mockRes.status = jest.fn().mockReturnValue(mockRes);  // Mock status function
            mockRes.json = jest.fn();  // Mock json function
    
            optionalAuthenticate(mockRequest as Request, mockRes, mockNext);
    
            expect(mockNext).toHaveBeenCalled();
            expect(mockRequest.userId).toBeUndefined();
        });
    })
})