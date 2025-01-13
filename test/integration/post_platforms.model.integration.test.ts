import { createPostPlatform } from '../../src/models/post_platforms';
import pool from '../../src/config/database';

describe('Post Platform Model - Integration Tests', () => {
  afterEach(async () => {
    await pool.query('DELETE FROM post_platform'); // Clean up the test table
  });

  it('should insert a record into the post_platform table', async () => {
    const platformId = 1;
    const postId = 1;

    await createPostPlatform(platformId, postId);

    const result = await pool.query('SELECT * FROM post_platform WHERE "platformId" = $1 AND "postId" = $2', [platformId, postId]);
    expect(result.rows).toHaveLength(1);
    expect(result.rows[0]).toEqual(expect.objectContaining({ platformId, postId }));
  });

  it('should throw an error if the query fails (e.g., duplicate entries)', async () => {
    const platformId = 1;
    const postId = 1;

    await createPostPlatform(platformId, postId);

    // Attempting to insert the same data should fail due to a constraint (if one exists)
    await expect(createPostPlatform(platformId, postId)).rejects.toThrow();

    const result = await pool.query('SELECT * FROM post_platform WHERE "platformId" = $1 AND "postId" = $2', [platformId, postId]);
    expect(result.rows).toHaveLength(1); // Ensure only one row exists
  });
});