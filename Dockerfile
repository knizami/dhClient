FROM node:6.9.5
COPY dhclientappType/dhClient/code /usr/src/app
USER node
WORKDIR /usr/src/app
RUN npm install
RUN npm start
