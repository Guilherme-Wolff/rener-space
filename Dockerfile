
# Use uma versão específica do Node
FROM node:20-alpine

# Crie e defina o diretório de trabalho
WORKDIR /usr/src/app

# Copie os arquivos de dependências primeiro
COPY package*.json ./

# Instale as dependências (corrigi o comando duplicado 'npm npm')
RUN npm install node-fetch@2

RUN npm install --save-dev @types/node-fetch@2

RUN npm install


# Crie o usuário node e mude a propriedade do diretório
USER node
COPY --chown=node:node . .

# Exponha a porta que sua aplicação usa
EXPOSE 3000
# Comando para iniciar a aplicação
CMD ["node", "index.js"]
