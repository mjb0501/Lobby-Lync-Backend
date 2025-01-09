import pool from '../config/database';

export interface GamePlatform {
  id?: number;
  gameId: number;
  platformId: number;
}
