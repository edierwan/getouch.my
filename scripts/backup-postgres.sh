#!/usr/bin/env bash
set -euo pipefail

timestamp="$(date -u +%Y%m%dT%H%M%SZ)"
backup_root="${BACKUP_ROOT:-./backups/postgres}"
host_label="${HOST_LABEL:-getouch-my}"
database_name="${POSTGRES_DB:-}"
database_user="${POSTGRES_USER:-}"
database_host="${POSTGRES_HOST:-localhost}"
database_port="${POSTGRES_PORT:-5432}"

usage() {
	cat <<'EOF'
Usage:
	BACKUP_ROOT=/absolute/path \
	POSTGRES_DB=appdb \
	POSTGRES_USER=appuser \
	POSTGRES_PASSWORD=... \
	./scripts/backup-postgres.sh

Notes:
	- This script is a safe scaffold. It expects runtime environment variables.
	- Do not store real credentials in this file or commit a real .env file.
	- pg_dump must already be installed on the host that runs this script.
EOF
}

require_env() {
	local name="$1"
	if [[ -z "${!name:-}" ]]; then
		printf 'Missing required environment variable: %s\n' "$name" >&2
		exit 1
	fi
}

if [[ "${1:-}" == "--help" ]]; then
	usage
	exit 0
fi

require_env POSTGRES_DB
require_env POSTGRES_USER
require_env POSTGRES_PASSWORD

mkdir -p "$backup_root"

output_file="$backup_root/${host_label}-${database_name}-${timestamp}.sql.gz"

printf 'Creating PostgreSQL backup scaffold output at %s\n' "$output_file"

PGPASSWORD="$POSTGRES_PASSWORD" pg_dump \
	--host "$database_host" \
	--port "$database_port" \
	--username "$database_user" \
	--dbname "$database_name" \
	--no-owner \
	--no-privileges | gzip > "$output_file"

printf 'Backup complete: %s\n' "$output_file"
