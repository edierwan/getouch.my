#!/usr/bin/env bash

set -Eeuo pipefail

REMOTE_USER="${WAVE2_USER:-deploy}"
REMOTE_HOST="${WAVE2_HOST:-72.62.254.86}"
SSH_KEY="${WAVE2_SSH_KEY:-$HOME/.ssh/id_ed25519}"

ssh_opts=(
  -i "$SSH_KEY"
  -o ServerAliveInterval=60
  -o ServerAliveCountMax=30
)

ssh "${ssh_opts[@]}" "${REMOTE_USER}@${REMOTE_HOST}" 'bash -s' <<'REMOTE'
set -Eeuo pipefail

ensure_dir() {
  sudo mkdir -p "$1"
}

upsert_env() {
  local file="$1"
  local key="$2"
  local value="$3"
  sudo touch "$file"
  if sudo grep -q "^${key}=" "$file"; then
    sudo sed -i.bak "s|^${key}=.*$|${key}=${value}|" "$file"
  else
    printf '%s=%s\n' "$key" "$value" | sudo tee -a "$file" >/dev/null
  fi
}

ensure_dir /opt/stacks/redis/data
ensure_dir /opt/stacks/open-webui/data
ensure_dir /opt/stacks/evolution-api/store
ensure_dir /opt/stacks/evolution-api/postgres
ensure_dir /opt/stacks/supabase

if [ -f /opt/stacks/wave2-placeholders/docker-compose.yml ]; then
  cd /opt/stacks/wave2-placeholders
  sudo docker compose down || true
fi

sudo tee /opt/stacks/redis/docker-compose.yml >/dev/null <<'YAML'
services:
  wave2-redis:
    image: redis:7-alpine
    container_name: wave2-redis
    restart: unless-stopped
    command: redis-server --appendonly yes
    volumes:
      - /opt/stacks/redis/data:/data
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 5s
      retries: 5
    networks:
      - coolify

networks:
  coolify:
    external: true
YAML

sudo tee /opt/stacks/open-webui/docker-compose.yml >/dev/null <<'YAML'
services:
  open-webui:
    image: ghcr.io/open-webui/open-webui:main
    container_name: open-webui
    restart: unless-stopped
    volumes:
      - /opt/stacks/open-webui/data:/app/backend/data
    environment:
      WEBUI_URL: https://chat.getouch.my
      ENABLE_SIGNUP: "true"
    labels:
      - "traefik.enable=true"
      - "traefik.docker.network=coolify"
      - "traefik.http.routers.open-webui-http.rule=Host(`chat.getouch.my`)"
      - "traefik.http.routers.open-webui-http.entrypoints=http"
      - "traefik.http.routers.open-webui-http.middlewares=redirect-to-https@file"
      - "traefik.http.routers.open-webui-https.rule=Host(`chat.getouch.my`)"
      - "traefik.http.routers.open-webui-https.entrypoints=https"
      - "traefik.http.routers.open-webui-https.tls=true"
      - "traefik.http.routers.open-webui-https.tls.certresolver=letsencrypt"
      - "traefik.http.services.open-webui.loadbalancer.server.port=8080"
    networks:
      - coolify

networks:
  coolify:
    external: true
YAML

EVOLUTION_POSTGRES_PASSWORD=$(openssl rand -hex 18)
EVOLUTION_API_KEY=$(openssl rand -hex 24)

if [ -f /opt/stacks/evolution-api/.env ]; then
  EVOLUTION_POSTGRES_PASSWORD=$(sudo awk -F= '/^EVOLUTION_POSTGRES_PASSWORD=/{print $2}' /opt/stacks/evolution-api/.env | head -n 1)
  EVOLUTION_API_KEY=$(sudo awk -F= '/^AUTHENTICATION_API_KEY=/{print $2}' /opt/stacks/evolution-api/.env | head -n 1)
fi

sudo tee /opt/stacks/evolution-api/.env >/dev/null <<EOFENV
EVOLUTION_POSTGRES_PASSWORD=${EVOLUTION_POSTGRES_PASSWORD}
EVOLUTION_DATABASE_URL=postgresql://evolution:${EVOLUTION_POSTGRES_PASSWORD}@evolution-db:5432/evolution
DATABASE_PROVIDER=postgresql
DATABASE_CONNECTION_URI=postgresql://evolution:${EVOLUTION_POSTGRES_PASSWORD}@evolution-db:5432/evolution
DATABASE_URL=postgresql://evolution:${EVOLUTION_POSTGRES_PASSWORD}@evolution-db:5432/evolution
DATABASE_CONNECTION_CLIENT_NAME=evolution
DATABASE_SAVE_DATA_INSTANCE=true
DATABASE_SAVE_DATA_NEW_MESSAGE=true
DATABASE_SAVE_DATA_CONTACTS=true
DATABASE_SAVE_DATA_CHATS=true
DATABASE_SAVE_MESSAGE_UPDATE=true
CACHE_REDIS_ENABLED=true
CACHE_REDIS_URI=redis://wave2-redis:6379/0
CACHE_REDIS_SAVE_INSTANCES=true
CACHE_LOCAL_ENABLED=false
AUTHENTICATION_API_KEY=${EVOLUTION_API_KEY}
SERVER_URL=https://wa.getouch.my
SERVER_PORT=8080
SERVER_TYPE=http
SERVER_NAME=evolution
CORS_ORIGIN=*
CORS_METHODS=GET,POST,PUT,DELETE
CORS_CREDENTIALS=true
TELEMETRY_ENABLED=false
LOG_LEVEL=ERROR,WARN,INFO,LOG
EOFENV
sudo chmod 600 /opt/stacks/evolution-api/.env

sudo tee /opt/stacks/evolution-api/docker-compose.yml >/dev/null <<'YAML'
services:
  evolution-db:
    image: postgres:16-alpine
    container_name: evolution-db
    restart: unless-stopped
    environment:
      POSTGRES_DB: evolution
      POSTGRES_USER: evolution
      POSTGRES_PASSWORD: ${EVOLUTION_POSTGRES_PASSWORD}
    volumes:
      - /opt/stacks/evolution-api/postgres:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U evolution -d evolution"]
      interval: 10s
      timeout: 5s
      retries: 5

  evolution-api:
    image: evoapicloud/evolution-api:latest
    container_name: evolution-api
    restart: unless-stopped
    env_file:
      - .env
    depends_on:
      evolution-db:
        condition: service_healthy
    volumes:
      - /opt/stacks/evolution-api/store:/evolution/store
    labels:
      - "traefik.enable=true"
      - "traefik.docker.network=coolify"
      - "traefik.http.routers.evolution-api-http.rule=Host(`wa.getouch.my`)"
      - "traefik.http.routers.evolution-api-http.entrypoints=http"
      - "traefik.http.routers.evolution-api-http.middlewares=redirect-to-https@file"
      - "traefik.http.routers.evolution-api-https.rule=Host(`wa.getouch.my`)"
      - "traefik.http.routers.evolution-api-https.entrypoints=https"
      - "traefik.http.routers.evolution-api-https.tls=true"
      - "traefik.http.routers.evolution-api-https.tls.certresolver=letsencrypt"
      - "traefik.http.services.evolution-api.loadbalancer.server.port=8080"
    networks:
      - default
      - coolify

networks:
  coolify:
    external: true
YAML

rm -rf /tmp/supabase-src
mkdir -p /tmp/supabase-src
cd /tmp/supabase-src
git init -q
if git remote get-url origin >/dev/null 2>&1; then
  git remote remove origin
fi
git remote add origin https://github.com/supabase/supabase.git
git config core.sparseCheckout true
echo docker/ > .git/info/sparse-checkout
git fetch --depth 1 origin master -q
git checkout FETCH_HEAD -q
sudo rsync -a --delete /tmp/supabase-src/docker/ /opt/stacks/supabase/

cd /opt/stacks/supabase
if [ ! -f .env ]; then
  sudo cp .env.example .env
fi
sudo chmod 600 .env

if sudo grep -q '^JWT_SECRET=your-super-secret' .env; then
  sudo sh ./utils/generate-keys.sh --update-env >/tmp/supabase-generate-keys.log 2>&1
fi

SUPABASE_DASHBOARD_PASSWORD=$(sudo awk -F= '/^DASHBOARD_PASSWORD=/{print $2}' .env | head -n 1)
if [ -z "$SUPABASE_DASHBOARD_PASSWORD" ] || [ "$SUPABASE_DASHBOARD_PASSWORD" = 'this_password_is_insecure_and_should_be_updated' ]; then
  SUPABASE_DASHBOARD_PASSWORD=$(openssl rand -base64 18 | tr -d '=+/')
fi

upsert_env /opt/stacks/supabase/.env POSTGRES_HOST db
upsert_env /opt/stacks/supabase/.env POSTGRES_PORT 5432
upsert_env /opt/stacks/supabase/.env POSTGRES_DB postgres
upsert_env /opt/stacks/supabase/.env KONG_HTTP_PORT 18000
upsert_env /opt/stacks/supabase/.env KONG_HTTPS_PORT 18443
upsert_env /opt/stacks/supabase/.env SITE_URL https://supabase-prd-serapod.getouch.my
upsert_env /opt/stacks/supabase/.env SUPABASE_PUBLIC_URL https://supabase-prd-serapod-kong.getouch.my
upsert_env /opt/stacks/supabase/.env API_EXTERNAL_URL https://supabase-prd-serapod-kong.getouch.my
upsert_env /opt/stacks/supabase/.env ADDITIONAL_REDIRECT_URLS 'https://supabase-prd-serapod.getouch.my/**'
upsert_env /opt/stacks/supabase/.env STUDIO_DEFAULT_ORGANIZATION Serapod
upsert_env /opt/stacks/supabase/.env STUDIO_DEFAULT_PROJECT Production
upsert_env /opt/stacks/supabase/.env DASHBOARD_USERNAME admin
upsert_env /opt/stacks/supabase/.env DASHBOARD_PASSWORD "$SUPABASE_DASHBOARD_PASSWORD"

sudo tee /opt/stacks/supabase/docker-compose.override.yml >/dev/null <<'YAML'
services:
  studio:
    networks:
      - default
      - coolify
    labels:
      - "traefik.enable=true"
      - "traefik.docker.network=coolify"
      - "traefik.http.routers.supabase-studio-http.rule=Host(`supabase-prd-serapod.getouch.my`)"
      - "traefik.http.routers.supabase-studio-http.entrypoints=http"
      - "traefik.http.routers.supabase-studio-http.middlewares=redirect-to-https@file"
      - "traefik.http.routers.supabase-studio-https.rule=Host(`supabase-prd-serapod.getouch.my`)"
      - "traefik.http.routers.supabase-studio-https.entrypoints=https"
      - "traefik.http.routers.supabase-studio-https.tls=true"
      - "traefik.http.routers.supabase-studio-https.tls.certresolver=letsencrypt"
      - "traefik.http.services.supabase-studio.loadbalancer.server.port=3000"
  kong:
    networks:
      - default
      - coolify
    labels:
      - "traefik.enable=true"
      - "traefik.docker.network=coolify"
      - "traefik.http.routers.supabase-kong-http.rule=Host(`supabase-prd-serapod-kong.getouch.my`)"
      - "traefik.http.routers.supabase-kong-http.entrypoints=http"
      - "traefik.http.routers.supabase-kong-http.middlewares=redirect-to-https@file"
      - "traefik.http.routers.supabase-kong-https.rule=Host(`supabase-prd-serapod-kong.getouch.my`)"
      - "traefik.http.routers.supabase-kong-https.entrypoints=https"
      - "traefik.http.routers.supabase-kong-https.tls=true"
      - "traefik.http.routers.supabase-kong-https.tls.certresolver=letsencrypt"
      - "traefik.http.services.supabase-kong.loadbalancer.server.port=8000"

networks:
  coolify:
    external: true
YAML

cd /opt/stacks/redis
sudo docker compose up -d
cd /opt/stacks/open-webui
sudo docker compose up -d
cd /opt/stacks/evolution-api
sudo docker compose up -d
cd /opt/stacks/supabase
sudo docker compose up -d

printf '\n== active wave2 containers ==\n'
sudo docker ps --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}' | grep -E 'wave2-redis|open-webui|evolution|supabase-' || true
REMOTE