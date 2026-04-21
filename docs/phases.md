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

### Wave 2

Objective:
Add core platform services that support data, messaging, and AI access layers.

Planned scope:

- Redis
- Supabase
- Evolution API
- Open WebUI

Gate to start:

- Wave 1 validation complete
- baseline backup scaffold reviewed
- DNS and access model confirmed

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

- Wave 1 is the only active execution scope
- deferred services are documented without implying deployment
- each later wave has explicit gate criteria
- repository language stays consistent with phased delivery

## Rollback Or Caution Notes

- do not blend Wave 2 or Wave 3 implementation into the Wave 1 baseline branch
- if any Wave 1 component creates unacceptable risk, stop promotion and revert to the previous validated checkpoint
