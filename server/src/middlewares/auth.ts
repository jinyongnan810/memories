import express, { Application, Request, Response, NextFunction } from "express";
import admin from "firebase-admin";
export const checkIfAuthenticated = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const idToken = req.headers.authorization?.split("Bearer ")[1];
  if (!idToken) {
    return res.status(403).send("Unauthorized");
  }
  try {
    req.app.locals.auth = await admin.auth().verifyIdToken(idToken);
    next();
  } catch (error) {
    return res.status(403).send("Unauthorized or invalid token");
  }
};
