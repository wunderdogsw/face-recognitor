const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const httpServer = require('http').Server;
const { whoIsIt } = require('./face-recognitor/face-recognitor');
const { saveImage, removeImage } = require('./utils/image-utils');

const PORT = process.env.PORT || 3000;
const app = express();
const server = httpServer(app);

app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false, limit: '10mb' }));

app.get('/', async (req, res) => {
  res.send('Server is running');
});

app.post('/whoisit', async (req, res) => {
  console.log('POST /api/whoisit');

  const { image } = req.body;
  if (!image) return res.sendStatus(400);

  try {
    const imagePath = await saveImage(Buffer.from(image.split(',')[1], 'base64'));

    let players;
    try {
      players = whoIsIt(imagePath);
    } catch (error) {
      console.error('[ERROR]', error);
      return res.sendStatus(500);
    }

    removeImage(imagePath);
    return res.json({ players });
  } catch (err) {
    return res.status(500).send(err);
  }
});

server.listen(PORT, () => {
  console.log(`Face recognitor service listening port -> ${PORT}`);
});
