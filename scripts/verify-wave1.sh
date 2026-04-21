#!/usr/bin/env bash
set -euo pipefail

failures=0

check_command() {
	local label="$1"
	local command_name="$2"
	if command -v "$command_name" >/dev/null 2>&1; then
		printf '[OK] %s\n' "$label"
	else
		printf '[FAIL] %s\n' "$label"
		failures=$((failures + 1))
	fi
}

check_systemd_unit() {
	local label="$1"
	local unit_name="$2"
	if command -v systemctl >/dev/null 2>&1 && systemctl is-active --quiet "$unit_name"; then
		printf '[OK] %s\n' "$label"
	else
		printf '[WARN] %s\n' "$label"
		failures=$((failures + 1))
	fi
}

check_path() {
	local label="$1"
	local path_name="$2"
	if [[ -e "$path_name" ]]; then
		printf '[OK] %s\n' "$label"
	else
		printf '[WARN] %s\n' "$label"
		failures=$((failures + 1))
	fi
}

printf 'Verifying Wave 1 baseline on %s\n' "$(hostname 2>/dev/null || echo unknown-host)"

check_command 'docker command available' docker
check_command 'docker compose plugin available' docker

if command -v docker >/dev/null 2>&1; then
	if docker compose version >/dev/null 2>&1; then
		printf '[OK] docker compose version returned successfully\n'
	else
		printf '[WARN] docker compose version failed\n'
		failures=$((failures + 1))
	fi
fi

check_command 'tailscale command available' tailscale
check_systemd_unit 'Docker service active' docker
check_systemd_unit 'Tailscale service active' tailscaled
check_path 'Backup scripts directory present' "$(cd "$(dirname "$0")" && pwd)"

printf '\nManual checks still required:\n'
printf ' - deploy user sudo access\n'
printf ' - SSH key login only\n'
printf ' - root SSH login disabled\n'
printf ' - password authentication disabled\n'
printf ' - Coolify, Homepage, and Uptime Kuma reachability\n'

if [[ "$failures" -gt 0 ]]; then
	printf '\nWave 1 verification found %d issue(s) or missing prerequisites.\n' "$failures" >&2
	exit 1
fi

printf '\nWave 1 automated checks passed. Complete the manual checks before sign-off.\n'
