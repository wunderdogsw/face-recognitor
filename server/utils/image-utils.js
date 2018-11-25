const fs = require('fs');

const UPLOADS_DIR = './uploads/';

const createUploadsDir = () => {
  if (!fs.existsSync(UPLOADS_DIR)) {
    fs.mkdirSync(UPLOADS_DIR);
  }
};

const saveImage = async (imageBuffer) => {
  createUploadsDir();
  const imageName = `screenshot_${Date.now()}.jpg`;
  const imagePath = `${UPLOADS_DIR}${imageName}`;
  await fs.writeFileSync(imagePath, imageBuffer);
  return imagePath;
};

const removeImage = (imagePath) => {
  if (!fs.existsSync(UPLOADS_DIR)) return;

  fs.unlinkSync(imagePath);
};

module.exports = {
  saveImage,
  removeImage,
};
