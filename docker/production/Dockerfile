# syntax=docker.io/docker/dockerfile:1

FROM node:24-alpine AS base
RUN apk add --no-cache gcompat

FROM base AS deps
WORKDIR /app
COPY package.json package-lock.json* ./
RUN npm ci

FROM base AS prod-deps
WORKDIR /app
COPY package.json package-lock.json* ./
RUN npm ci --omit=dev

FROM base AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
# prisma.config.ts requires DATABASE_URL just to load
ENV DATABASE_URL="postgresql://user:pass@localhost:5432/db?schema=public"
RUN npx prisma generate
RUN npm run build

FROM base AS runner
WORKDIR /app
ENV NODE_ENV=production
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nestjs -u 1001
COPY --from=prod-deps --chown=nestjs:nodejs /app/node_modules ./node_modules
COPY --from=builder --chown=nestjs:nodejs /app/dist ./dist
COPY --from=builder --chown=nestjs:nodejs /app/package.json ./package.json
USER nestjs
EXPOSE 3000
CMD ["node", "dist/main.js"]

FROM base AS migrator
WORKDIR /app
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nestjs -u 1001
COPY --from=deps --chown=nestjs:nodejs /app/node_modules ./node_modules
COPY --from=builder --chown=nestjs:nodejs /app/prisma ./prisma
COPY --from=builder --chown=nestjs:nodejs /app/prisma.config.ts ./prisma.config.ts
COPY --from=builder --chown=nestjs:nodejs /app/package.json ./package.json
USER nestjs
CMD ["npx", "prisma", "migrate", "deploy"]
