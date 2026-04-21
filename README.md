# getouch.my
Production infrastructure, deployment, monitoring, and backup for getouch.my
Target VPS:
- Host: getouch.my
- Provider: Hostinger
- OS: Ubuntu 24.04 LTS
- Public IP: 72.62.254.86

Access method:
- SSH as root for initial bootstrap
- Temporary password exists and will be rotated after bootstrap
- Final setup must create a deploy sudo user, migrate SSH access, and disable root/password login afterward

Important:
- Do not hardcode secrets into repo files
- Use .env.example only
- Real secrets must be injected manually or stored outside git
## Purpose

This repository is the source of truth for the new `getouch.my` production VPS bootstrap and platform operations.

It exists to make the stack:

- repeatable
- recoverable
- portable to another VPS/provider later
- easier to maintain with clear phases and runbooks

This repo is for infrastructure and platform operations, not for application feature code.

---

## Current target

- **Primary host:** `getouch.my`
- **Target OS:** Ubuntu 24.04 LTS
- **Primary role:** production platform VPS
- **Goal:** replace the older primary stack gradually, with rollback and restore capability

---

## Core principles

1. **Keep the server portable**  
   We should be able to move to another VPS/provider later without rebuilding from zero.

2. **Backups must be restorable**  
   Backup without restore testing is not enough.

3. **Minimize blast radius**  
   Roll out the platform in waves, not everything at once.

4. **Prefer stable, proven components**  
   Use mature tools with strong operational value.

5. **Protect control plane access**  
   Admin panels and internal services should not be openly exposed unless necessary.

---

## Planned stack

### Control plane
- Coolify
- Homepage

### Monitoring
- Uptime Kuma
- Netdata

### Data layer
- Self-hosted Supabase
- Redis

### Communication
- Evolution API
- Telegram service

### AI
- Open WebUI
- Remote AI backend on `getouch.co`
- Optional lightweight local fallback only

### Backup
- Offsite backup pipeline
- Restore scripts and runbooks

---

## Architecture direction

### Public-facing services
Examples:
- main websites
- selected app frontends
- public webhook/API endpoints where required

### Protected/internal services
Examples:
- Coolify
- Supabase admin/studio
- database admin tools
- internal dashboards
- AI admin endpoints
- backup/admin utilities

These should be protected using stricter access controls.

---

## Rollout phases

### Wave 1
- OS hardening
- Docker
- Tailscale
- Coolify
- Homepage
- Uptime Kuma
- backup scaffold

### Wave 2
- Redis
- Supabase
- Evolution API
- Open WebUI

### Wave 3
- Dify
- n8n
- LiteLLM
- advanced logging
- optional local AI fallback

---

## Repository structure

Planned structure:

```text
docs/
bootstrap/
stacks/
scripts/
env/
