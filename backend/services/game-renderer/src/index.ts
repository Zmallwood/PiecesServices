import express, { Request, Response } from "express";
import cors from 'cors';

const app = express();
const port = 3001;

//app.use(cors());
//app.use(cors({ origin: 'http://localhost:31001' }));

app.get("/rendered_game", (req: Request, res: Response) => {
  const data = {
    commands: ["DrawImage;DefaultSceneBackground;0.0;0.0;1.0;1.0;false;"]
  };

  res.json(data);
});

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});


