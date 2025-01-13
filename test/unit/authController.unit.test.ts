import { Request, Response } from "express";
import bcrypt from "bcrypt";
import { generateToken } from "../../src/services/authService";
import { createUser, getUserByEmail } from "../../src/models/user";
import { register, login, authLogout } from "../../src/controllers/authController";

jest.mock("../../src/models/user");
jest.mock("bcrypt");
jest.mock("../../src/services/authService");

describe("AuthController - Unit Tests", () => {
    let req: Partial<Request>;
    let res: Partial<Response>;
    let jsonMock: jest.Mock;
    let statusMock: jest.Mock;
  
    beforeEach(() => {
        jsonMock = jest.fn();
        statusMock = jest.fn().mockReturnValue({ json: jsonMock });
        res = {
            status: statusMock,
            json: jsonMock,
            cookie: jest.fn(),
            clearCookie: jest.fn(),
        };
    });
  
    afterEach(() => {
        jest.clearAllMocks();
    });

    describe("register", () => {
        it("should register a user and return status 201 with the user data", async () => {
            const mockUser = { id: 1, username: "testuser", email: "test@example.com" };
            req = { body: { username: "testuser", email: "test@example.com", password: "password" } };
            (bcrypt.hash as jest.Mock).mockResolvedValueOnce("hashedpassword");
            (createUser as jest.Mock).mockResolvedValueOnce(mockUser);
    
            await register(req as Request, res as Response);
    
            expect(bcrypt.hash).toHaveBeenCalledWith("password", 10);
            expect(createUser).toHaveBeenCalledWith({
                username: "testuser",
                email: "test@example.com",
                password: "hashedpassword",
            });
            expect(res.status).toHaveBeenCalledWith(201);
            expect(res.json).toHaveBeenCalledWith(mockUser);
        });
    
        it("should return status 500 if registration fails", async () => {
            req = { body: { username: "testuser", email: "test@example.com", password: "password" } };
            (bcrypt.hash as jest.Mock).mockRejectedValueOnce(new Error("Hashing failed"));
    
            await register(req as Request, res as Response);
    
            expect(res.status).toHaveBeenCalledWith(500);
            expect(res.json).toHaveBeenCalledWith({ error: "Error registering user" });
        });
    });
    
    describe("login", () => {
        it("should log in a user and set a cookie", async () => {
            const mockUser = { id: 1, email: "test@example.com", password: "hashedpassword" };
            req = { body: { email: "test@example.com", password: "password" } };
            (getUserByEmail as jest.Mock).mockResolvedValueOnce(mockUser);
            (bcrypt.compare as jest.Mock).mockResolvedValueOnce(true);
            (generateToken as jest.Mock).mockReturnValueOnce("mocktoken");
    
            await login(req as Request, res as Response);
    
            expect(getUserByEmail).toHaveBeenCalledWith("test@example.com");
            expect(bcrypt.compare).toHaveBeenCalledWith("password", "hashedpassword");
            expect(res.cookie).toHaveBeenCalledWith("accessToken", "mocktoken", expect.any(Object));
            expect(res.status).toHaveBeenCalledWith(200);
            expect(res.json).toHaveBeenCalledWith({ message: "Login successful" });
        });
    
        it("should return status 401 for invalid credentials", async () => {
            req = { body: { email: "test@example.com", password: "wrongpassword" } };
            (getUserByEmail as jest.Mock).mockResolvedValueOnce(null);
    
            await login(req as Request, res as Response);
    
            expect(res.status).toHaveBeenCalledWith(401);
            expect(res.json).toHaveBeenCalledWith({ error: "Invalid credentials" });
        });
    });
    
    describe("authLogout", () => {
        it("should clear the access token cookie and return status 200", () => {
            req = {};
            authLogout(req as Request, res as Response);
    
            expect(res.clearCookie).toHaveBeenCalledWith("accessToken", expect.any(Object));
            expect(res.status).toHaveBeenCalledWith(200);
            expect(res.json).toHaveBeenCalledWith({ message: "Successfully logged out" });
        });
    });
});