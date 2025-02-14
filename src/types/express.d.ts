import * as express from 'express';
import { IncomingMessage } from 'http';

declare global {
  namespace Express {
     export interface Request {
      userUuid: string;
    }
  }
}

declare module 'http' {
  interface IncomingMessage {
    userUuid: string | null;
  }
}