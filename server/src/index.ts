import * as functions from "firebase-functions";
import { app } from "./app";

export const api = functions
  .runWith({
    timeoutSeconds: 60,
    memory: "1GB",
    maxInstances: 1,
  })
  .region("asia-northeast1")
  .https.onRequest(app);
