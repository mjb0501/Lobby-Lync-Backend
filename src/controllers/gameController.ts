import { Request, Response } from 'express';
import { Op } from 'sequelize';
import Game from '../models/game';
import Platform from '../models/platform';

export const getGames = async (req: Request, res: Response): Promise<void> => {
    //tells typescript that query will either be a string or undefined
    const query = req.query.query as string;

    //if there is no query or query is less than 3 characters
    if (!query || query.length < 3) {
        res.status(400).json({ message: 'Search query must be at least 3 characters long'});
        return;
    }

    try {
        //games = all entries in games table that match the provided query limits it to 10
        const games = await Game.findAll({
            where: {
                name: {
                    [Op.iLike]: `%${query}%`,
                },
            },
            limit: 10,
        });

        const gameNames = games.map(game => game.name);
        res.status(200).json(gameNames);
    } catch (err) {
        console.error('Error searching for games:', err);
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

        const game = await Game.findOne({
            where: { name: gameName },
            include: [
                {
                    model: Platform,
                    attributes: ['id', 'name'],
                    as: 'platforms',
                    through: { attributes: [] },
                }
            ]
        });

        if (!game) {
            res.status(404).json({ message: `No platforms found for game: ${gameName}`});
            return;
        }

        const formatted = {
            gameId: game.id,
            platforms: game.platforms?.map(platform => platform.name)
        };

        const platforms = game.platforms?.map(platform => platform.name);

        res.status(200).json(formatted);
    } catch (error) {
        console.error('Error fetching platforms: ', error);
        res.status(500).json({ message: 'Failed to fetch platforms' });
    }
}