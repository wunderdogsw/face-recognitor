const fs = require('fs');
const faceRecognition = require('face-recognition');
const path = require('path');

const fr = faceRecognition;
const detector = fr.FaceDetector();

const modelPath = './server/face-recognitor/model.json';

const model = JSON.parse(fs.readFileSync(modelPath));

const recognizer = fr.FaceRecognizer();
recognizer.load(model);

const faceSizePixels = 150;

const whoIsIt = (imagePath) => {
  const image = fr.loadImage(path.resolve(imagePath));

  const rects = detector.locateFaces(image, faceSizePixels).map(mrect => mrect.rect);
  if (!rects.length) return [];

  const faces = detector.getFacesFromLocations(image, rects, faceSizePixels);

  const players = faces
    .map(face => recognizer.predictBest(face))
    .map((face, i) => ({
      ...face,
      ...rects[i],
    }))
    .sort((a, b) => b.right - a.right)
    .map(player => ({
      ...player,
      name: player.className,
    }));

  return players;
};

module.exports = {
  whoIsIt,
};
