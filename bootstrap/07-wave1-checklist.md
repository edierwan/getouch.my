# Wave 1 Checklist

## Objective

Provide a concise completion checklist for the Wave 1 platform baseline.

## Scope

This checklist is for execution verification only. It does not authorize Wave 2 or Wave 3 work.

## Prerequisites

- bootstrap phases 00 through 06 reviewed
- operator has access to the host for verification

## Implementation Outline

Use this checklist after completing the Wave 1 tasks and again before promoting the baseline for manual review or commit.

## Validation Checklist

- [x] deploy user created (`deploy`, UID 1001)
- [x] deploy user sudo access verified (NOPASSWD)
- [x] SSH key login verified (`id_ed25519`)
- [x] root SSH login disabled (`PermitRootLogin no`)
- [x] password authentication disabled (`PasswordAuthentication no`)
- [x] `AllowUsers deploy` enforced — only deploy user can SSH
- [x] firewall enabled — UFW active: ports 22, 80, 443, 8000, 41641/udp
- [x] fail2ban enabled (SSH jail, maxretry 4, bantime 1h)
- [x] timezone set (Asia/Kuala_Lumpur)
- [x] 2 GB swap active (`/swapfile`)
- [x] Docker 29.4.1 installed
- [x] Docker Compose v5.1.3 plugin installed
- [x] Docker service active and enabled
- [x] Docker daemon config: log rotation + address pool 172.20.0.0/16
- [x] Tailscale connected and healthy (100.119.174.55)
- [x] Coolify 4.0.0-beta.473 installed and reachable at http://72.62.254.86:8000
- [x] Homepage deployed (127.0.0.1:3000, exposed via portal.getouch.my through coolify-proxy)
- [x] Uptime Kuma deployed (127.0.0.1:3001, exposed via kuma.getouch.my through coolify-proxy)
- [x] Coolify-managed Traefik proxy active on ports 80 and 443
- [x] coolify.getouch.my validated over HTTPS
- [x] portal.getouch.my validated over HTTPS
- [x] kuma.getouch.my validated over HTTPS
- [x] /opt/stacks, /opt/backups, /opt/scripts directories created
- [x] backup scaffold placed at /opt/scripts/backup-volumes.sh
- [x] verify-wave1.sh result: 24/24 PASS — 2026-04-21

## Execution Notes

- Ubuntu 24.04 cloud-init places `/etc/ssh/sshd_config.d/50-cloud-init.conf` with
  `PasswordAuthentication yes`. This override had to be replaced to ensure the
  effective sshd config reflects the intended hardening. Fix is idempotent and
  safe (file is now `PasswordAuthentication no`).
- Hostname on server resolves as `srv1606367` (Hostinger default). FQDN
  `getouch.my` is the public name. No action needed for Wave 1.
- Coolify first-run setup was completed during Wave 1 finalization. Instance
  FQDN is `https://coolify.getouch.my` and the initial admin account now exists.
- The unintended Caddy workaround was removed entirely. Wave 1 now uses only
  the Coolify-managed Traefik proxy.
- Homepage returned `Host validation failed` after first exposure through
  Traefik. Final fix: set `HOMEPAGE_ALLOWED_HOSTS=portal.getouch.my` in the
  Homepage runtime environment.

## Post-Wave-1 Operational Follow-Ups

These do not block Wave 1 completion:

- [ ] Add monitors in Uptime Kuma for Wave 1 endpoints
- [ ] Configure Homepage tiles in /opt/stacks/homepage/config/services.yaml
- [ ] Backup Coolify env file (/data/coolify/source/.env) to a secure external location
- [ ] Reconfirm Cloudflare DNS-only A records for coolify.getouch.my, portal.getouch.my, and kuma.getouch.my remain pointed to 72.62.254.86

## Rollback Or Caution Notes

- if any hardening step breaks operator access, recover before proceeding
- do not mark Wave 1 complete while later-wave services remain implied as active work
- Coolify env file contains auto-generated secrets — back it up externally before Wave 2
