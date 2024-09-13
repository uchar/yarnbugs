FROM node:20-alpine AS dependencies
RUN corepack enable
WORKDIR /app
COPY package.json ./
COPY yarn.lock ./
RUN yarn --immutable

FROM node:20-alpine AS builder
RUN corepack enable
WORKDIR /app
COPY --from=dependencies /app/package.json ./
COPY --from=dependencies /app/.pnp.cjs ./
COPY --from=dependencies /app/.yarn ./.yarn
COPY --from=dependencies /app/yarn.lock ./yarn.lock
COPY ./src ./src
RUN yarn build


FROM node:20-alpine AS runner
RUN corepack enable
WORKDIR /app
COPY --from=builder /app/build ./
COPY --from=builder /app/.env ./
COPY --from=dependencies /app/.pnp.cjs ./
COPY --from=dependencies /app/.yarn ./.yarn
ENTRYPOINT ["node", "src/testCode.js"]