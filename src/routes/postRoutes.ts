import { Router } from 'express';
import { insertPost, getPosts, acceptPost, getPostById } from '../controllers/postController';
import { authenticate, optionalAuthenticate } from '../middlewares/authMiddleware';

const router = Router();

router.post('/createPost', authenticate, insertPost);
router.get('/getPosts', optionalAuthenticate, getPosts);
router.post('/acceptPost', authenticate, acceptPost);
router.get('/getPostById', authenticate, getPostById);

export default router;