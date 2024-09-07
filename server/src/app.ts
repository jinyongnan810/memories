import express, { Application, Request, Response } from "express";
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import * as serviceAccount from "../service_account/sa.json";

admin.initializeApp({
  //   credential: admin.credential.cert(serviceAccount as admin.ServiceAccount),
  credential: admin.credential.applicationDefault(),
  databaseAuthVariableOverride: {
    uid: "the-server",
  },
});

const app: Application = express();

// Middleware to parse JSON
app.use(express.json());

app.get("/", async (req: Request, res: Response) => {
  const idToken = req.body.token;
  console.log(`idToken: ${idToken}`);
  const count = await admin.firestore().collection("memories").count().get();
  console.log(`count: ${count.data().count}`);

  try {
    const decodedToken = await admin.auth().verifyIdToken(idToken);
    res.status(200).json(decodedToken);
  } catch (error) {
    res.status(401).send(`Error: ${error}`);
  }
});

export { app };
