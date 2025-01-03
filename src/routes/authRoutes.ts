import { Router } from 'express';
import { register, login, authLogout } from '../controllers/authController';
import { authenticate } from '../middlewares/authMiddleware';

const router = Router();

router.post('/register', register);
router.post('/login', login);
router.get('/check', authenticate, (req, res) => {
    res.json({message: 'This is a protected route.', loggedIn: true});
});
router.post('/logout', authLogout);

export default router;