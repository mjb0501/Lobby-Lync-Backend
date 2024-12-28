import { Router } from 'express';
import { createPost, getPosts } from '../controllers/postController';
import { authenticate } from '../middlewares/authMiddleware';

const router = Router();

router.post('/', authenticate, createPost);
router.get('/getPosts', getPosts);

export default router;