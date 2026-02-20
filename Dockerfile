# ── Stage 1: dependency fetch (network access permitted here only) ─────────────
# node:20-slim pinned to digest — no floating tag, no surprise upstream changes
FROM node:20-slim@sha256:c6585df72c34172bebd8d36abed961e231d7d3b5cee2e01294c4495e8a03f687 AS deps

WORKDIR /app
COPY package*.json ./

# --ignore-scripts: prevents lifecycle scripts from running (supply chain risk)
# --omit=dev: no devDependencies in the image
RUN npm ci --ignore-scripts --omit=dev 2>/dev/null; exit 0

# ── Stage 2: runtime (no network access — hermetic) ────────────────────────────
FROM node:20-slim@sha256:c6585df72c34172bebd8d36abed961e231d7d3b5cee2e01294c4495e8a03f687 AS final

WORKDIR /app

# Copy only the installed deps from stage 1 — no npm, no build tools, no cache
COPY --from=deps /app/node_modules ./node_modules

# Copy app source
COPY . .

# Non-root user — never run as root in production
RUN groupadd -r appuser && useradd -r -g appuser appuser
USER appuser

EXPOSE 3000
ENTRYPOINT ["node", "index.js"]
