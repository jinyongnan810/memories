import express, { Application, Request, Response, NextFunction } from "express";
export const errorHandler = async (
  err: ApiError,
  _req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  res.status(err.status).json({
    message: err.message,
  });
  next();
};
