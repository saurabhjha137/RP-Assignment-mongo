# Base Stage
FROM node:14 AS base
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .


# Development Stage
FROM base AS development
ENV NODE_ENV=development
RUN npm install -g nodemon
CMD ["nodemon", "app.js"]


# Testing Stage
FROM base AS test
ENV NODE_ENV=test
CMD ["npm", "test"]


# Production Stage
FROM base AS production
ENV NODE_ENV=production
RUN npm prune --production
CMD ["node", "app.js"]
