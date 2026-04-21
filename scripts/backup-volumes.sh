#!/usr/bin/env bash
set -euo pipefail

timestamp="$(date -u +%Y%m%dT%H%M%SZ)"
backup_root="${BACKUP_ROOT:-./backups/volumes}"
source_path="${SOURCE_PATH:-}"
host_label="${HOST_LABEL:-getouch-my}"

usage() {
	cat <<'EOF'
Usage:
	BACKUP_ROOT=/absolute/path \
	SOURCE_PATH=/var/lib/docker/volumes/example/_data \
	./scripts/backup-volumes.sh

Notes:
	- This script is a safe scaffold for archiving a named data path.
	- Pass the real source path at runtime.
	- Review excludes before using it for production data.
EOF
}

if [[ "${1:-}" == "--help" ]]; then
	usage
	exit 0
fi

if [[ -z "$source_path" ]]; then
	printf 'Missing required environment variable: SOURCE_PATH\n' >&2
	exit 1
fi

if [[ ! -d "$source_path" ]]; then
	printf 'Source path not found: %s\n' "$source_path" >&2
	exit 1
fi

mkdir -p "$backup_root"

source_name="$(basename "$source_path")"
archive_file="$backup_root/${host_label}-${source_name}-${timestamp}.tar.gz"

printf 'Creating volume backup scaffold output at %s\n' "$archive_file"

tar \
	--exclude='.cache' \
	--exclude='tmp' \
	-C "$(dirname "$source_path")" \
	-czf "$archive_file" \
	"$source_name"

printf 'Backup complete: %s\n' "$archive_file"
