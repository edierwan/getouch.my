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
- [x] Homepage deployed (127.0.0.1:3000, internal only)
- [x] Uptime Kuma deployed (127.0.0.1:3001, internal only)
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

## Remaining Manual Steps

These cannot be fully automated and require operator action:

- [ ] Complete Coolify first-run admin setup at http://72.62.254.86:8000
- [ ] In Coolify: configure domains (home.getouch.my, status.getouch.my, coolify.getouch.my) with TLS
- [ ] Add monitors in Uptime Kuma for Wave 1 endpoints
- [ ] Configure Homepage tiles in /opt/stacks/homepage/config/services.yaml
- [ ] Backup Coolify env file (/data/coolify/source/.env) to a secure external location
- [ ] Point DNS records for Wave 1 subdomains to 72.62.254.86

## Rollback Or Caution Notes

- if any hardening step breaks operator access, recover before proceeding
- do not mark Wave 1 complete while later-wave services remain implied as active work
- Coolify env file contains auto-generated secrets — back it up externally before Wave 2
