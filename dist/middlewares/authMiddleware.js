"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.authenticate = void 0;
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const authenticate = (req, res, next) => {
    var _a;
    //this splits the authorization header so that the token in the header is assigned to token
    //header is formatted like: "Bearer <token>" this splits that string and grabs the token.
    const token = (_a = req.headers.authorization) === null || _a === void 0 ? void 0 : _a.split(' ')[1];
    if (!token) {
        res.status(401).json({ error: 'No token provided' });
        return;
    }
    try {
        //validates the token with the secret key
        const decoded = jsonwebtoken_1.default.verify(token, process.env.JWT_SECRET);
        //attaches the decoded token to the req object as a user cast as any to pass typescript check
        req.user = decoded;
        //tells express to move onto next function
        next();
    }
    catch (err) {
        res.status(401).json({ error: 'Invalid token' });
    }
};
exports.authenticate = authenticate;
