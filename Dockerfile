FROM node:13.6.0-alpine

ARG MESSAGE
ENV MESSAGE=${MESSAGE:-}

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json /usr/src/app/
RUN npm install

COPY app/server.js /usr/src/app

USER node
CMD [ "npm", "start" ]
