# node:20-slim (current LTS) — fewer CVEs than 18.x
# Copa handles any remaining OS-level CVEs in the pipeline
FROM node:20-slim

WORKDIR /app

COPY package*.json ./

RUN npm ci --ignore-scripts --omit=dev 2>/dev/null || true

COPY . .

RUN groupadd -r appuser && useradd -r -g appuser appuser
USER appuser

EXPOSE 3000
ENTRYPOINT ["node", "index.js"]
