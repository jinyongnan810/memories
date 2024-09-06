import express, { Application, Request, Response } from "express";

const app: Application = express();
const port = process.env.PORT || 3000;

// Middleware to parse JSON
app.use(express.json());

app.get("/", (req: Request, res: Response) => {
  res.send("Hello, World!");
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
