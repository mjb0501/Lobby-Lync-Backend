import { Router } from 'express';
import { insertPost, getPosts, acceptPost, getPostById, deletePost } from '../controllers/postController';
import { authenticate, optionalAuthenticate } from '../middlewares/authMiddleware';

const router = Router();

router.post('/createPost', authenticate, insertPost);
router.get('/getPosts', optionalAuthenticate, getPosts);
router.post('/acceptPost', authenticate, acceptPost);
router.get('/getPostById', authenticate, getPostById);
router.get('/deletePost', authenticate, deletePost)
export default router;