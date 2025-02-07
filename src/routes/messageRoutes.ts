import { Router } from "express";
import { generalRateLimit } from "../middlewares/rateLimiter";
import { authenticate } from "../middlewares/authMiddleware";
import { getMessages, sendMessage } from "../controllers/conversationController";

const router = Router();

router.get('/getMessages', generalRateLimit, authenticate, getMessages);
router.post('/sendMessage', generalRateLimit, authenticate, sendMessage);

export default router