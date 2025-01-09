import { Router } from 'express';
import { insertPost, getPosts, acceptPost } from '../controllers/postController';
import { authenticate, optionalAuthenticate } from '../middlewares/authMiddleware';

const router = Router();

router.post('/createPost', authenticate, insertPost);
router.get('/getPosts', optionalAuthenticate, getPosts);
router.post('/acceptPost', authenticate, acceptPost);

export default router;