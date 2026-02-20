# Using node:18.18.0 intentionally — known to have CVEs for Trivy/Copa to catch
FROM node:18.18.0-slim

WORKDIR /app

COPY package*.json ./

RUN npm ci --ignore-scripts --omit=dev 2>/dev/null || true

COPY . .

RUN groupadd -r appuser && useradd -r -g appuser appuser
USER appuser

EXPOSE 3000
ENTRYPOINT ["node", "index.js"]
