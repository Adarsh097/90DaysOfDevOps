FROM node:20-slim AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

FROM node:20-alpine

WORKDIR /app

COPY --from=build /app .

USER node

EXPOSE 4000

CMD ["node","server.js"]
