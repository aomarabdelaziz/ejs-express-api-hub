FROM node:16-alpine

WORKDIR /app

COPY *.json .

RUN npm install --production --silent

COPY . .

EXPOSE 300

ENTRYPOINT [ "npm" , "start" ]