# Install latest version of node
FROM node:latest

#change to the directory we will be running the application in
WORKDIR /app

#copy package file
COPY package*.json ./

#run the npm install command to install all dependencies
RUN npm install

#copy the projects files
COPY . .

#exposes the port (needs to be the same port mentioned in the compose.yaml file)
EXPOSE 3001

#will run the command node index.ts
CMD ["npm", "run", "dev"]