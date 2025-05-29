# Use official Node.js runtime as base image (use a specific version for stability)
FROM node:18

# Set working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json first (for better caching)
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy the rest of the application source code
COPY . .

# Expose the port the app runs on (adjust if your app uses a different port)
EXPOSE 3000

# Define the command to run the app
CMD ["node", "src/app.js"]

