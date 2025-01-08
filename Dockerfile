# Install latest version of node
FROM node:22.12.0-alpine as builder

#change to the directory we will be running the application in
WORKDIR /app

#copy package file
COPY package*.json ./

#run the npm install command to install all dependencies
RUN npm install

#copy the projects files
COPY . .

RUN npm run build

FROM node:22.12.0-alpine as production

ENV NODE_ENV=production

WORKDIR /app

COPY --from=builder /app/package*.json ./
COPY --from=builder /app/dist ./dist

RUN npm install --production

#exposes the port (needs to be the same port mentioned in the compose.yaml file)
EXPOSE 3001

#will run the command node index.ts
CMD ["node", "dist/index.js"]