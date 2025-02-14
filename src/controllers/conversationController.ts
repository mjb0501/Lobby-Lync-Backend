import { Request, Response } from 'express';
import { createMessage, readMessages } from '../models/message';
import { deleteConversation } from '../models/conversation';

export const sendMessage = async (req: Request, res: Response): Promise<void> => {
    try {
        if (!req.userUuid) {
            res.status(400).json({ error: 'User is not authenticated' });
            return;
        }

        const { conversationId, content } = req.body;

        const senderId = req.userUuid;
        const message = await createMessage(conversationId, senderId, content);

        res.status(201).json({ message });
    } catch (error) {
        console.error('Error sending message:', error);
        res.status(400).json({ error: 'Error sending message' });
    }
}

export const getMessages = async (req: Request, res: Response): Promise<void> => {
    try {
        if (!req.userUuid) {
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

export const removeConversation = async (req: Request, res: Response): Promise<void> => {
    try {
        if (!req.userUuid) {
            res.status(400).json({ error: 'user is not authenticated'});
            console.log('test1');
            return;
        }

        const conversationId = req.params.conversationId || req.query.conversationId;

        if (!conversationId) {
            res.status(400).json({ error: 'Missing conversationId'});
            console.log('test2');
            return;
        }

        await deleteConversation(Number(conversationId));

        res.status(200).json({ message: 'Conversation successfullly deleted'});
    } catch (error) {
        console.error('Error deleting conversation:', error);
        res.status(500).json({ error: 'Server error' });
    }
}