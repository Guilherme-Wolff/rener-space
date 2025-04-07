# Etapa 1: Build
FROM node:alpine
WORKDIR /usr/src/app


COPY package*.json ./

RUN npm install

# Define o usuário para rodar o contêiner (não root)
USER node

# Copia o restante dos arquivos da aplicação para o contêiner com as permissões corretas
COPY --chown=node:node . .

USER node

EXPOSE 3000

CMD ["node", "index.js"]
