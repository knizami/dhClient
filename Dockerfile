FROM node:6.9.5
EXPOSE 8081
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
RUN npm install
COPY dhclientappType/dhClient/code /usr/src/app
CMD ["npm", "start"]
