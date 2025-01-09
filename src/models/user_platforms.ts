import pool from '../config/database';

export interface UserPlatform {
  id?: number;
  userId: number;
  platformId: number;
  platformUsername: string;
}
