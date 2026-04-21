# getouch.my Infrastructure

This repository is the source of truth for the new getouch.my production VPS bootstrap, deployment baseline, monitoring baseline, backup planning, and operational documentation.

## Purpose

This repo exists to keep the platform:

- repeatable
- reviewable
- recoverable
- portable to another provider later
- safe to operate in controlled rollout waves

It is an infrastructure and operations repository, not an application feature repository.

## Target Host

- Hostname: getouch.my
- Public IP: 72.62.254.86
- Provider: Hostinger
- OS: Ubuntu 24.04 LTS
- Role: new primary production platform VPS
- Bootstrap access: temporary root access for first bootstrap only

Final access policy:

- dedicated deploy sudo user
- SSH key authentication only
- root SSH login disabled after deploy access is verified
- password authentication disabled after SSH key access is verified

## Secrets Rules

- never commit real secrets, passwords, tokens, private keys, or certificates
- never commit real .env files
- commit redacted templates and .env.example only
- inject production values manually or from an external secret store

## Architecture Direction

- this VPS is the new primary production platform host
- Wave 1 is base platform only
- heavy AI inference belongs on getouch.co, not on this VPS
- future migration to another provider must remain straightforward
- admin and control-plane services should stay protected unless public exposure is explicitly required

## Rollout Waves

### Wave 1

Active execution scope:

- OS hardening
- deploy user strategy
- SSH hardening policy
- Docker Engine and Compose plugin
- Tailscale
- Coolify
- Homepage
- Uptime Kuma
- backup scaffold only

### Wave 2

Documented but not active yet:

- Redis
- Supabase
- Evolution API
- Open WebUI

### Wave 3

Documented but not active yet:

- Dify
- n8n
- LiteLLM
- advanced monitoring/logging expansion
- optional lightweight local AI fallback only if justified

## First Milestone

The first milestone is a production-safe Wave 1 baseline where:

- host access is hardened
- Docker is installed and standardized
- Tailscale is available for protected access paths
- Coolify is ready as the deployment control plane
- Homepage and Uptime Kuma provide basic operational visibility
- backup scripts and restore planning exist, without storing real credentials

## Current Status

- repository structure is normalized for docs, bootstrap, stacks, scripts, and env
- Wave 1 is the only active execution scope
- later services are placeholders with deployment intent only
- repo content is designed to be safe for manual review, commit, and GitHub sync

## Repository Structure

```text
README.md
bootstrap/
docs/
env/
scripts/
stacks/
```

## Key Documents

- docs/phases.md: wave-by-wave execution scope
- docs/architecture.md: platform constraints and hosting direction
- docs/host-inventory.md: safe host inventory
- docs/dns-plan.md: subdomain and exposure draft
- docs/backup-restore.md: backup and restore strategy
- docs/runbooks.md: operational procedures for Wave 1 and readiness checks

## Execution Rule

Do not treat later-wave services as active implementation work until explicitly scheduled.
