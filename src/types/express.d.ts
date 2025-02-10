import * as express from 'express';
import { IncomingMessage } from 'http';

declare global {
  namespace Express {
     export interface Request {
      userId: number;
    }
  }
}

declare module 'http' {
  interface IncomingMessage {
    userId: number;
  }
}