import express, { Request, Response } from "express";
import cors from 'cors';

const app = express();
const port = 3000;

app.use(cors());
//app.use(cors({ origin: 'http://localhost:30000' }));

app.get("/", async (req: Request, res: Response) => {
  try {
    const response = await fetch('http://pieces-game-renderer-service:3001/rendered_game');
    const data = await response.json();
    res.json(data);
  } catch (error) {
    res.status(500).json({ message: 'Error fetching data' });
  }
  //const data = {
  //  commands: ["DrawImage;DefaultSceneBackground;0.0;0.0;1.0;1.0;false;"]
  //};

  //res.json(data);
});

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});

