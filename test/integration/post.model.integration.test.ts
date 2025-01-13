import { createPost, readAllPosts, deleteOldPosts } from '../../src/models/post';
import pool from '../../src/config/database';

describe('Post Model - Integration Tests', () => {

  afterEach(async () => {
    // Clean up the database after each test (optional)
    await pool.query('DELETE FROM post');
  });

  it('should create a post and then read it', async () => {
    const post = { userId: 1, gameId: 1, description: 'Test post' };
    const createdPost = await createPost(post);

    const posts = await readAllPosts();
    expect(posts.length).toBeGreaterThan(0);
    expect(posts[0].postId).toBe(createdPost.id);
  });

  it('should delete old posts', async () => {
    const post = { userId: 1, gameId: 1, description: 'Test post' };
    const posts = await createPost(post);
    console.log(posts);
    const time = new Date().toISOString();
    const deleteCount = await deleteOldPosts(time);
    expect(deleteCount).toBeGreaterThan(0);
  });
});