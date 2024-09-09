import express, { Application } from 'express';
import * as admin from 'firebase-admin';
import cors from 'cors';
import { errorHandler } from './middlewares/error_handler';
import { checkIfAuthenticated } from './middlewares/auth';
import friendRouter from './routers/friends';

admin.initializeApp({
  //   credential: admin.credential.cert(serviceAccount as admin.ServiceAccount),
  credential: admin.credential.applicationDefault(),
  databaseAuthVariableOverride: {
    uid: 'the-server',
  },
});

const app: Application = express();
app.use(cors());
app.use(express.json());
app.use(checkIfAuthenticated);

app.use('/friends', friendRouter);

app.use(errorHandler);

export { app };
