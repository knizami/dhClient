FROM node:6.9.5
EXPOSE 8081
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY dhclientappType/dhClient/code/package.json .
RUN npm install
COPY dhclientappType/dhClient/code .
CMD ["npm", "start"]
