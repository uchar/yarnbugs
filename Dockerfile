# Use node alpine as the base image
FROM node:20-alpine

# Set the working directory to /app
WORKDIR /app

# Copy the necessary files for dependency installation
COPY package.json ./
COPY yarn.lock ./
COPY tsconfig.json ./

# Copy the source code into the container
COPY src ./src

# Enable production env for node
ENV NODE_ENV=production

# Install dependencies using Yarn 4
RUN corepack enable

#This one give error
RUN --mount=type=cache,target=/root/.yarn YARN_CACHE_FOLDER=/root/.yarn \
      yarn --immutable

#This one is correct
#RUN yarn --immutable

# Use a dynamic command to run the yarn initialization script defined by EXEC_COMMAND
CMD sh -c " yarn $EXEC_COMMAND"