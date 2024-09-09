import { validationResult } from 'express-validator';
import type { Request, Response } from 'express';

export const checkHasValidationError = (req: Request, res: Response) => {
  const errors = validationResult(req).array();
  if (errors.length > 0) {
    res.status(400).send(errors[0].msg);
    return true;
  }
  return false;
};
