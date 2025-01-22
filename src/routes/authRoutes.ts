import { Router } from 'express';
import { register, login, authLogout, getUser } from '../controllers/authController';
import { authenticate } from '../middlewares/authMiddleware';

const router = Router();

router.post('/register', register);
router.post('/login', login);
router.get('/check', authenticate, getUser);
router.post('/logout', authLogout);

export default router;