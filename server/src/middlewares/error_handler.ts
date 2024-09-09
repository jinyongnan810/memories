import { Request, Response, NextFunction } from 'express';
import { ApiError } from '../types/api_error';
export const errorHandler = async (
  err: ApiError,
  _req: Request,
  res: Response,
  next: NextFunction,
): Promise<void> => {
  res.status(err.status).json({
    message: err.message,
  });
  next();
};
