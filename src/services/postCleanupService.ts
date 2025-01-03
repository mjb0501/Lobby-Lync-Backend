import cron from 'node-cron';
import { Op } from 'sequelize';
import Post from '../models/post';

let cleanupTask: cron.ScheduledTask | null = null;
let isPostCleanupRunning: boolean = false;

export const startPostCleanupJob = () => {
    if (isPostCleanupRunning) return;
    isPostCleanupRunning = true;

    cleanupTask = cron.schedule('*/5 * * * *', async () => {
        try {
            const twoHoursAgo = new Date(Date.now() - 2 * 60 * 60 * 1000);
            const deletedPosts = await Post.destroy({
                where: {
                    createdAt: {
                        [Op.lt]: twoHoursAgo,
                    },
                },
            });
            console.log(`Deleted ${deletedPosts} old posts.`);
        } catch (error) {
            console.error('Error deleteing old posts:', error);
        }
    })
}

export const stopPostCleanupJob = () => {
    if (cleanupTask) {
        cleanupTask.stop();
        console.log('Cron job stopped.');
    }
}

