FROM node:20-alpine

WORKDIR /app

COPY package.json ./
COPY yarn.lock ./
COPY tsconfig.json ./
COPY src ./src

RUN corepack enable

#This one give error
RUN --mount=type=cache,target=/root/.yarn YARN_CACHE_FOLDER=/root/.yarn \
      yarn --immutable

#This one is correct
#RUN yarn --immutable

CMD sh -c " yarn $EXEC_COMMAND"