FROM node:18-alpine

WORKDIR app/learn-jenkin

COPY . .

RUN npm i

CMD ["npm", "start"]

