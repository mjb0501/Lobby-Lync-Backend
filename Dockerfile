FROM node:22.12.0-alpine

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

EXPOSE 3001

CMD ["node", "dist/index.js"]
# # Install latest version of node
# FROM node:22.12.0-alpine as builder

# #change to the directory we will be running the application in
# WORKDIR /app

# #copy package file
# COPY package*.json ./

# #run the npm install command to install all dependencies
# RUN npm install

# #copy the projects files
# COPY . .

# RUN apk add --no-cache postgresql-client

# RUN npm run build

# FROM node:22.12.0-alpine as production

# ENV NODE_ENV=production

# WORKDIR /app

# COPY --from=builder /app/package*.json ./
# COPY --from=builder /app/.sequelizerc ./
# COPY --from=builder /app/dist ./dist


# RUN apk add --no-cache postgresql-client

# RUN npm install --production

# #exposes the port (needs to be the same port mentioned in the compose.yaml file)
# EXPOSE 3001

# #will run the command node index.ts
# CMD ["node", "dist/index.js"]
# #CMD ["sh", "-c", "until pg_isready -h db -p 5432; do echo waiting for db; sleep 2; done && npx sequelize-cli db:migrate && npx sequelize-cli db:seed:all && node dist/index.js"]