FROM node:14

WORKDIR /app

RUN npm install

COPY . .

EXPOSE 3000


CMD [ "node" ,"MicroServiços/Barramento.js"] 
#####CMD ["node","MicroServiços/Fechadura.js"]
#####CMD ["node", "MicroServiços/Cadastros.js"] 

