import { Router } from 'express';
import { getGames, getGamePlatforms } from '../controllers/gameController';

const router = Router();

router.get('/autocomplete', getGames);
router.get('/gamePlatforms', getGamePlatforms);

export default router;