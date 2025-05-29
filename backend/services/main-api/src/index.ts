import express, { Request, Response } from "express";
import cors from 'cors';

const app = express();
const port = 3000;

// Enable CORS for all origins
app.use(cors());

app.get("/", (req: Request, res: Response) => {
  //res.send("Hello from TypeScript backend!");
  //const data = {
  //  commands: ["Clear;0;150;255;"]
  //};

  const data = {
    commands: ["DrawImage;DefaultSceneBackground;0.0;0.0;1.0;1.0;false;"]
  };

  res.json(data); // Respond with JSON
//  res.send({\"commands\": "
//              "[\"DrawImage;GroundGrass;0.0;0.0;0.2;0.2;false;\"]})
});

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});

