# Rollout Phases

## Objective

Define a phased execution model so the new getouch.my VPS is built in a controlled, reversible sequence.

## Scope

This document sets active scope, deferred scope, and promotion criteria between rollout waves.

## Prerequisites

- repository reviewed and commit-safe
- target host inventory confirmed
- DNS planning drafted
- operator has SSH key ready for the deploy user

## Implementation Outline

### Wave 1

Objective:
Establish the hardened base platform on the new VPS.

Status:
Completed and validated on 2026-04-21.

In scope:

- OS hardening
- deploy sudo user creation
- SSH key-only access model
- Docker Engine and Compose plugin
- Tailscale
- Coolify
- Homepage
- Uptime Kuma
- backup scaffold only

Out of scope:

- Redis
- Supabase
- Evolution API
- Open WebUI
- Dify
- n8n
- LiteLLM
- advanced Netdata rollout

Validated Wave 1 services and domains:

- Coolify -> coolify.getouch.my
- Homepage -> portal.getouch.my
- Uptime Kuma -> kuma.getouch.my

### Wave 2

Objective:
Add core platform services that support data, messaging, and AI access layers.

Status:
Runtime deployed on 2026-04-22. Redis, Supabase Studio, Evolution API, and Open WebUI are live. Supabase Kong is deployed at the origin, but the public hostname still needs a DNS/proxy correction.

Implemented scope:

- Redis
- Supabase self-hosted stack, including its bundled PostgreSQL component for the initial deployment
- Evolution API
- Open WebUI

Wave 2 deployment notes:

- initial Supabase rollout should use the supported self-hosted Supabase stack instead of provisioning a separate standalone PostgreSQL first
- `supabase-prd-serapod.getouch.my` now serves the live Supabase Studio surface
- `supabase-prd-serapod-kong.getouch.my` is routed to the live Supabase Kong surface at the origin, but its public DNS/proxy record is still incorrect
- keep real Supabase secrets, JWT material, SMTP settings, and runtime env files out of git
- a dedicated external PostgreSQL tier may still be considered later for scaling, isolation, or operational ownership reasons, but it is not an initial Wave 2 requirement

### Wave 3

Objective:
Add workflow, orchestration, and optional local AI support only after platform stability is proven.

Planned scope:

- Dify
- n8n
- LiteLLM
- advanced monitoring/logging expansion
- optional lightweight local AI fallback

Gate to start:

- Wave 2 service ownership clarified
- restore testing practiced
- capacity and security review complete

## Validation Checklist

- Wave 1 implementation is complete and Wave 2 state is described honestly
- Wave 3 remains deferred
- each later wave has explicit gate criteria
- repository language stays consistent with phased delivery

## Rollback Or Caution Notes

- do not blend Wave 2 or Wave 3 implementation into the Wave 1 baseline branch
- if any Wave 1 component creates unacceptable risk, stop promotion and revert to the previous validated checkpoint
