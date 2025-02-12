import { Router } from 'express';
import { insertPost, getPosts, acceptPost, getPostById, deletePost, getAcceptedPosts, deletePostAcceptance, editPost, rejectPostAcceptance } from '../controllers/postController';
import { authenticate, optionalAuthenticate } from '../middlewares/authMiddleware';
import { acceptPostRateLimit, createPostRateLimit, editPostRateLimit, generalRateLimit } from '../middlewares/rateLimiter';

const router = Router();

router.post('/createPost', createPostRateLimit, authenticate, insertPost);
router.get('/getPosts', generalRateLimit, authenticate, getPosts);
router.post('/acceptPost', acceptPostRateLimit, authenticate, acceptPost);
router.get('/getPostById', generalRateLimit, authenticate, getPostById);
router.delete('/deletePost', generalRateLimit, authenticate, deletePost);
router.get('/getAcceptedPosts', generalRateLimit, authenticate, getAcceptedPosts);
router.delete('/deletePostAcceptance', generalRateLimit, authenticate, deletePostAcceptance);
router.put('/updatePost', editPostRateLimit, authenticate, editPost);
router.delete('/rejectPostAcceptance', generalRateLimit, authenticate, rejectPostAcceptance);
export default router;