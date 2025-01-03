import * as express from 'express';
import { User } from '../models/user'; // Adjust this import to where your User type is defined

//This file adds a User to type request that is necessary for passing user information
export {}

declare global {
  namespace Express {
     export interface Request {
      userId: number;
    }
  }
}