# Etapa 1: Build
FROM node:20-alpine AS build
WORKDIR /app

COPY package*.json ./
RUN npm install --omit=dev

COPY . .

# Etapa 2: Final (mais leve)
FROM node:20-alpine
WORKDIR /usr/src/app

COPY --from=build /app ./

RUN npm install -g pm2

USER node

EXPOSE 3000
CMD ["node", "index.js"]
