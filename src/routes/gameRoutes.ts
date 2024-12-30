import { Router } from 'express';
import { getGames } from '../controllers/gameController';

const router = Router();

router.get('/autocomplete', getGames);

export default router;