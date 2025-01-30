import { rateLimit } from 'express-rate-limit';

export const loginRateLimit = rateLimit({
    windowMs: 10 * 60 * 1000,
    max: 6,
    message: { error: 'Too many login attempts, please try again in 10 minutes.' },
    standardHeaders: true,
    legacyHeaders: false,
    skipSuccessfulRequests: true,
});

export const signupRateLimit = rateLimit({
    windowMs: 1 * 24 * 60 * 60 * 1000,
    max: 3,
    message: { error: 'Too many signup requests, please try again later.' },
    standardHeaders: true,
    legacyHeaders: false,
    skipFailedRequests: true,
});

export const createPostRateLimit = rateLimit({
    windowMs: 60 * 1000,
    max: 5,
    message: { error: 'Too many post requests, please try again in an hour.' },
    standardHeaders: true,
    legacyHeaders: false,
    skipFailedRequests: true,
});

export const editPostRateLimit = rateLimit({
    windowMs: 10 * 60 * 1000,
    max: 10,
    message: { error: 'Too many edit requests, please try again in 10 minutes.' },
    standardHeaders: true,
    legacyHeaders: false,
    skipFailedRequests: true,
});

export const acceptPostRateLimit = rateLimit({
    windowMs: 5 * 60 * 1000,
    max: 10,
    message: { error: 'Too many post accept requests, please try again in 5 minutes.' },
    standardHeaders: true,
    legacyHeaders: false,
    skipFailedRequests: true,
});

export const generalRateLimit = rateLimit({
    windowMs: 15 * 60 * 1000,
    max: 10000,
    message: { error: 'Too many requests, please slow down.' },
    standardHeaders: true,
    legacyHeaders: true,
});