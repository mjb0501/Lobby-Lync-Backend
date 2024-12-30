import { Request, Response } from 'express';
import { Op } from 'sequelize';
import Game from '../models/game';

export const getGames = async (req: Request, res: Response): Promise<void> => {
    //tells typescript that query will either be a string or undefined
    const query = req.query.query as string | undefined;

    if (!query || query.length < 3) {
        res.status(400).json({ message: 'Search query must be at least 3 characters long'});
        return;
    }

    try {
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