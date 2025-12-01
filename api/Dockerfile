FROM node:22-alpine AS builder

WORKDIR /usr/src/app

# On copie uniquement les fichiers nécessaires pour installer les deps
COPY package*.json ./

# Install classique (on ne s'embête plus avec npm ci)
RUN npm install --omit=dev

# Puis le reste du code
COPY . .

# Image finale
FROM node:22-alpine

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /usr/src/app

COPY --from=builder /usr/src/app /usr/src/app

RUN chown -R appuser:appgroup /usr/src/app

USER appuser

ENV NODE_ENV=production

EXPOSE 3000

CMD ["node", "src/index.js"]
