import { Router } from 'express';
import { register, login, authLogout, getUser, editPlatforms } from '../controllers/authController';
import { authenticate } from '../middlewares/authMiddleware';
import { generalRateLimit, loginRateLimit, signupRateLimit } from '../middlewares/rateLimiter';

const router = Router();

router.post('/register', signupRateLimit, register);
router.post('/login', loginRateLimit, login);
router.get('/check', generalRateLimit, authenticate, getUser);
router.post('/logout', generalRateLimit, authLogout);
router.put('/editPlatforms', generalRateLimit, authenticate, editPlatforms)

export default router;