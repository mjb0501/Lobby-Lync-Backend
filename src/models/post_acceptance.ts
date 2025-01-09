import pool from '../config/database';

export interface PostAcceptance {
  id?: number;
  postId: number;
  userId: number;
}
