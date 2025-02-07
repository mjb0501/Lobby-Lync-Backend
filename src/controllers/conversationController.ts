import { Request, Response } from 'express';
import { createMessage, readMessages } from '../models/message';

export const sendMessage = async (req: Request, res: Response): Promise<void> => {
    try {
        if (!req.userId) {
            res.status(400).json({ error: 'User is not authenticated' });
            return;
        }

        const { conversationId, content } = req.body;

        const senderId = req.userId;
        const message = await createMessage(conversationId, senderId, content);

        res.status(201).json({ message });
    } catch (error) {
        console.error('Error sending message:', error);
        res.status(400).json({ error: 'Error sending message' });
    }
}

export const getMessages = async (req: Request, res: Response): Promise<void> => {
    try {
        if (!req.userId) {
            res.status(400).json({ error: 'User is not authenticated' });
            return;
        }

        const { conversationId } = req.query;

        if (!conversationId) {
            res.status(400).json({ error: "Conversation ID is required" });
            return;
        }

        const messages = await readMessages(Number(conversationId));

        res.status(201).json({ messages });
    } catch (error) {
        console.error('Error getting messages:', error);
        res.status(400).json({ error: 'Error sending message' });
    }
}