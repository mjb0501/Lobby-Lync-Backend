import { Router } from 'express';
import { insertPost, getPosts, acceptPost, getPostById, deletePost, getAcceptedPosts, deletePostAcceptance, editPost } from '../controllers/postController';
import { authenticate, optionalAuthenticate } from '../middlewares/authMiddleware';

const router = Router();

router.post('/createPost', authenticate, insertPost);
router.get('/getPosts', optionalAuthenticate, getPosts);
router.post('/acceptPost', authenticate, acceptPost);
router.get('/getPostById', authenticate, getPostById);
router.delete('/deletePost', authenticate, deletePost);
router.get('/getAcceptedPosts', authenticate, getAcceptedPosts);
router.delete('/deletePostAcceptance', authenticate, deletePostAcceptance);
router.put('/updatePost', authenticate, editPost);
export default router;