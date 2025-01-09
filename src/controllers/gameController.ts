import { Request, Response } from 'express';
import { searchGames, readGamePlatforms } from '../models/game';

export const getGames = async (req: Request, res: Response): Promise<void> => {
    const query = req.query.query as string;

    if (!query || query.length < 3) {
        res.status(400).json({ message: 'Search query must be at least 3 characters long' });
        return;
    }

    try {
        const games = await searchGames(query);

        const gameNames = games.map(game => game.name);
        res.status(200).json(gameNames);
    } catch (error) {
        console.error('Error searching for games:', error);
        res.status(500).json({ message: 'Failed to search for games' });
    }
};

export const getGamePlatforms = async (req: Request, res: Response): Promise<void> => {
    try {
        const gameName = req.query.gameName as string;

        if (!gameName) {
            res.status(400).json({ message: 'Game name is required' });
            return;
        }

        const platforms = await readGamePlatforms(gameName);

        if (platforms.length === 0) {
            res.status(404).json({ message: `No platforms found for game: ${gameName}` });
            return;
        }

        //.reduce processes each element (row) of the platforms array and accumulates a result in acc
        const formatted = platforms.reduce((acc: any[], row: any) => {
            //searches the acc array to check if there is an object (g) with a gameId matching gameId in row
            let game = acc.find(g => g.gameId === row.gameId);

            //if game is not yet in acc then create new game object and add it to acc
            if (!game) {
                game = {
                    gameId: row.gameId,
                    platforms: []
                };
                acc.push(game);
            }

            //if the platform exists and is not in game.platforms then add it to the acc.game.platforms array
            if (row.platformName && !game.platforms.includes(row.platformName)) {
                game.platforms.push(row.platformName);
            }

            return acc;
        }, []);

        res.status(200).json(formatted[0]);
    } catch (error) {
        console.error('Error fetching platforms: ', error);
        res.status(500).json({ message: 'Failed to fetch platforms' });
    }
}