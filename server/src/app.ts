import express, { Application, Request, Response, NextFunction } from "express";
import * as admin from "firebase-admin";
import { errorHandler } from "./middlewares/error_handler";
import { body, validationResult } from "express-validator";
import { checkIfAuthenticated } from "./middlewares/auth";

admin.initializeApp({
  //   credential: admin.credential.cert(serviceAccount as admin.ServiceAccount),
  credential: admin.credential.applicationDefault(),
  databaseAuthVariableOverride: {
    uid: "the-server",
  },
});

const app: Application = express();

app.use(express.json());
app.use(checkIfAuthenticated);

const checkHasValidationError = (req: Request, res: Response) => {
  const errors = validationResult(req).array();
  if (errors.length > 0) {
    res.status(400).send(errors[0].msg);
    return true;
  }
  return false;
};

//#region Endpoints
app.post(
  "/friends/request",
  body("email").trim().isEmail().withMessage("Invalid email"),
  async (req: Request, res: Response, next: NextFunction) => {
    if (checkHasValidationError(req, res)) {
      return;
    }
    const userId = req.app.locals.auth.user_id;
    const targetUserEmail = req.body.email;
    console.log(
      `request add friends start. userId: ${userId}, targetUserId: ${targetUserEmail}`
    );

    try {
      const targetUserData = await admin
        .firestore()
        .collection("users")
        .where("email", "==", targetUserEmail)
        .get()
        .catch((err) => {
          console.error(err);
          throw new ApiError("get user failed", 500);
        });
      const targetUser = targetUserData.docs[0];
      if (!targetUser || !targetUser.exists) {
        throw new ApiError("target user not found", 404);
      }
      await targetUser.ref
        .collection("requests")
        .doc(userId)
        .set({ requestTime: admin.firestore.FieldValue.serverTimestamp() })
        .catch((err) => {
          console.error(err);
          throw new ApiError("update requests failed", 500);
        });
      console.log(`request add friends end`);
      res.status(200).send(`ok`);
    } catch (err) {
      next(err);
    }
  }
);

//#endregion endpoints

app.use(errorHandler);

export { app };
