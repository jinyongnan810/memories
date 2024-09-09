import type { Request, Response } from 'express';
import { NextFunction, Router } from 'express';
import { body, param } from 'express-validator';
import * as admin from 'firebase-admin';
import { ApiError } from '../types/api_error';
import { checkHasValidationError } from './shared';
const router = Router({ mergeParams: true });
router.post(
  '/request',
  body('email').trim().isEmail().withMessage('Invalid email'),
  async (req: Request, res: Response, next: NextFunction) => {
    if (checkHasValidationError(req, res)) {
      console.error('validation error');
      return;
    }
    const userId = req.app.locals.auth.user_id;
    const targetUserEmail = req.body.email;
    console.log(
      `request add friend start. userId: ${userId}, targetUserEmail: ${targetUserEmail}`,
    );

    try {
      const targetUserData = await admin
        .firestore()
        .collection('users')
        .where('email', '==', targetUserEmail)
        .get()
        .catch((err) => {
          console.error(err);
          throw new ApiError('get user failed', 500);
        });
      const targetUser = targetUserData.docs[0];
      if (!targetUser || !targetUser.exists) {
        throw new ApiError('target user not found', 404);
      }
      if (targetUser.id === userId) {
        throw new ApiError('cannot add yourself', 400);
      }
      await targetUser.ref
        .collection('requests')
        .doc(userId)
        .set({ requestTime: admin.firestore.FieldValue.serverTimestamp() })
        .catch((err) => {
          console.error(err);
          throw new ApiError('update requests failed', 500);
        });
      console.log(`request add friend end`);
      res.status(200).send(`ok`);
    } catch (err) {
      next(err);
    }
  },
);

router.delete(
  '/request/:userId',
  param('userId')
    .matches(/^\w{28}$/)
    .withMessage('Invalid userId'),
  async (req: Request, res: Response, next: NextFunction) => {
    if (checkHasValidationError(req, res)) {
      console.error('validation error');
      return;
    }
    const userId = req.app.locals.auth.user_id;
    const targetUserId = req.params.userId;
    console.log(
      `request delete friend start. userId: ${userId}, targetUserId: ${targetUserId}`,
    );

    try {
      await admin
        .firestore()
        .collection('users')
        .doc(userId)
        .collection('requests')
        .doc(targetUserId)
        .delete()
        .catch((err) => {
          console.error(err);
          throw new ApiError('delete request failed', 500);
        });
      console.log(`request delete friend end`);
      res.status(200).send(`ok`);
    } catch (err) {
      next(err);
    }
  },
);

router.post(
  '/',
  body('userId')
    .matches(/^\w{28}$/)
    .withMessage('Invalid userId'),
  async (req: Request, res: Response, next: NextFunction) => {
    if (checkHasValidationError(req, res)) {
      console.error('validation error');
      return;
    }
    const userId = req.app.locals.auth.user_id;
    const targetUserId = req.body.userId;
    console.log(
      `accept friend request start. userId: ${userId}, targetUserId: ${targetUserId}`,
    );

    try {
      const targetRequestData = await admin
        .firestore()
        .collection('users')
        .doc(userId)
        .collection('requests')
        .doc(targetUserId)
        .get()
        .catch((err) => {
          console.error(err);
          throw new ApiError('get user request failed', 500);
        });
      if (!targetRequestData.exists) {
        console.log(`target user request not found`);
        throw new ApiError('target user request not found', 404);
      }
      await targetRequestData.ref.delete().catch((err) => {
        console.error(err);
        throw new ApiError('delete user request failed', 500);
      });
      await Promise.all([
        admin
          .firestore()
          .collection('users')
          .doc(userId)
          .collection('friends')
          .doc(targetUserId)
          .set({ acceptTime: admin.firestore.FieldValue.serverTimestamp() })
          .catch((err) => {
            console.error(err);
            throw new ApiError(`update friends failed(${userId})`, 500);
          }),
        admin
          .firestore()
          .collection('users')
          .doc(targetUserId)
          .collection('friends')
          .doc(userId)
          .set({ acceptTime: admin.firestore.FieldValue.serverTimestamp() })
          .catch((err) => {
            console.error(err);
            throw new ApiError(`update friends failed(${targetUserId})`, 500);
          }),
      ]);
      console.log(`hello3`);
      console.log(`accept friend request end`);
      res.status(200).send(`ok`);
    } catch (err) {
      next(err);
    }
  },
);

router.delete(
  '/',
  body('userId')
    .matches(/^\w{28}$/)
    .withMessage('Invalid userId'),
  async (req: Request, res: Response, next: NextFunction) => {
    if (checkHasValidationError(req, res)) {
      console.error('validation error');
      return;
    }
    const userId = req.app.locals.auth.user_id;
    const targetUserId = req.body.userId;
    console.log(
      `delete friend start. userId: ${userId}, targetUserId: ${targetUserId}`,
    );

    try {
      await Promise.all([
        admin
          .firestore()
          .collection('users')
          .doc(userId)
          .collection('friends')
          .doc(targetUserId)
          .delete()
          .catch((err) => {
            console.error(err);
            throw new ApiError(`delete friend failed(${userId})`, 500);
          }),
        admin
          .firestore()
          .collection('users')
          .doc(targetUserId)
          .collection('friends')
          .doc(userId)
          .delete()
          .catch((err) => {
            console.error(err);
            throw new ApiError(`delete friend failed(${targetUserId})`, 500);
          }),
      ]);
      console.log(`delete friend request end`);
      res.status(200).send(`ok`);
    } catch (err) {
      next(err);
    }
  },
);

export default router;
