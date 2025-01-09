import { Router } from 'express';
import { insertPost, getPosts } from '../controllers/postController';
import { authenticate } from '../middlewares/authMiddleware';

const router = Router();

router.post('/createPost', authenticate, insertPost);
router.get('/getPosts', getPosts);

export default router;