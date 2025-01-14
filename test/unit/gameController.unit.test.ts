import { Request, Response } from "express";
import { getGames, getGamePlatforms } from "../../src/controllers/gameController";
import { searchGames, readGamePlatforms } from "../../src/models/game";

//mock is used so that database isnt invoked during test
jest.mock("../../src/models/game");

describe("GameController - Unit Tests", () => {
    //a partial mock of a Request and Response
    let req: Partial<Request>;
    let res: Partial<Response>;
    //simulates the res.json method
    let jsonMock: jest.Mock;
    //simulates the res.status method
    let statusMock: jest.Mock;

    beforeEach(() => {
        //ensures a fresh mock function for jsonMock and StatusMock
        jsonMock = jest.fn();
        statusMock = jest.fn().mockReturnValue({ json: jsonMock });
        res = {
            status: statusMock,
            json: jsonMock,
        };
    });

    afterEach(() => {
        //clears all mock call data to ensure no overlap between tests
        jest.clearAllMocks();
    });

    describe("getGames", () => {
        it("should return status 400 if query is missing or less than 3 characters", async () => {
            req = { query: { query: "ab" } };
            //invoke getGames with the req described above and the res mock functions
            await getGames(req as Request, res as Response);

            expect(res.status).toHaveBeenCalledWith(400);
            expect(res.json).toHaveBeenCalledWith({ message: "Search query must be at least 3 characters long" });
        });

        it("should return status 200 with a list of game names", async () => {
            req = { query: { query: "game" } };
            const mockGames = [{ name: "Game A" }, { name: "Game B" }];
            (searchGames as jest.Mock).mockResolvedValueOnce(mockGames);

            await getGames(req as Request, res as Response);

            expect(searchGames).toHaveBeenCalledWith("game");
            expect(res.status).toHaveBeenCalledWith(200);
            expect(res.json).toHaveBeenCalledWith(["Game A", "Game B"]);
        });

        it("should return status 500 if searchGames throws an error", async () => {
            req = { query: { query: "game" } };
            (searchGames as jest.Mock).mockRejectedValueOnce(new Error("Database error"));

            await getGames(req as Request, res as Response);

            expect(res.status).toHaveBeenCalledWith(500);
            expect(res.json).toHaveBeenCalledWith({ message: "Failed to search for games" });
        });
    });

    describe("getGamePlatforms", () => {
        it("should return status 400 if gameName is missing", async () => {
            req = { query: {} };
            await getGamePlatforms(req as Request, res as Response);

            expect(res.status).toHaveBeenCalledWith(400);
            expect(res.json).toHaveBeenCalledWith({ message: "Game name is required" });
        });

        it("should return status 404 if no platforms are found", async () => {
            req = { query: { gameName: "Unknown Game" } };
            (readGamePlatforms as jest.Mock).mockResolvedValueOnce([]);

            await getGamePlatforms(req as Request, res as Response);

            expect(readGamePlatforms).toHaveBeenCalledWith("Unknown Game");
            expect(res.status).toHaveBeenCalledWith(404);
            expect(res.json).toHaveBeenCalledWith({ message: "No platforms found for game: Unknown Game" });
        });

        it("should return status 200 with formatted platforms", async () => {
            req = { query: { gameName: "Game A" } };
            const mockPlatforms = [
                { gameId: 1, platformName: "Platform A" },
                { gameId: 1, platformName: "Platform B" },
            ];
            (readGamePlatforms as jest.Mock).mockResolvedValueOnce(mockPlatforms);

            await getGamePlatforms(req as Request, res as Response);

            expect(readGamePlatforms).toHaveBeenCalledWith("Game A");
            expect(res.status).toHaveBeenCalledWith(200);
            expect(res.json).toHaveBeenCalledWith({
                gameId: 1,
                platforms: ["Platform A", "Platform B"],
            });
        });

        it("should return status 500 if readGamePlatforms throws an error", async () => {
            req = { query: { gameName: "Game A" } };
            (readGamePlatforms as jest.Mock).mockRejectedValueOnce(new Error("Database error"));

            await getGamePlatforms(req as Request, res as Response);

            expect(res.status).toHaveBeenCalledWith(500);
            expect(res.json).toHaveBeenCalledWith({ message: "Failed to fetch platforms" });
        });
    });
});