import { Router } from 'express';
import { getGames, getGamePlatforms } from '../controllers/gameController';
import { generalRateLimit } from '../middlewares/rateLimiter';

const router = Router();

router.get('/autocomplete', generalRateLimit, getGames);
router.get('/gamePlatforms', generalRateLimit, getGamePlatforms);

export default router;