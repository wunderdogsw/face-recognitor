FROM node:10
WORKDIR /usr/src/face-recognitor
RUN apt-get update && apt-get install cmake libx11-dev libpng-dev
COPY . .
RUN npm install
EXPOSE 3000
CMD ["npm", "start"]