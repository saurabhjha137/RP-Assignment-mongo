# First stage: Build stage
FROM node:latest AS builder

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to leverage Docker cache
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of your application code
COPY . .




# Second stage: Production stage
FROM node:20-slim AS production

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the built application from the builder stage
COPY --from=builder /usr/src/app .

# Expose the port your app runs on
EXPOSE 3000

# Run app.js when the container launches
CMD ["node", "app.js"]
