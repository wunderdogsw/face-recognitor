FROM node:10
WORKDIR /usr/src/face-recognitor
RUN apt-get update && apt-get install -y cmake libx11-dev libpng-dev libopenblas-dev
COPY package.json package-lock.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "start"]