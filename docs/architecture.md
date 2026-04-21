# Architecture Summary

## Objective

Document the intended role of the getouch.my VPS and the constraints that shape the platform design.

## Scope

This is a high-level architecture summary for the production platform host, access model, service exposure strategy, and portability requirements.

## Prerequisites

- host inventory confirmed
- Wave 1 scope agreed
- control-plane components selected

## Implementation Outline

### Platform Role

The getouch.my VPS is the new primary production platform host. It is intended to run the base control plane, monitoring baseline, and later selected platform services.

### Wave 1 Boundary

Wave 1 is base platform only. It prepares the host, network access, deployment control plane, dashboard, uptime monitoring, and backup scaffolding. It does not attempt to fully deploy later data, messaging, or AI services.

### AI Placement

Heavy AI inference belongs on getouch.co, not on this VPS. The getouch.my host may later expose lightweight AI-facing control surfaces or a small fallback path, but it should not become the primary inference node.

### Exposure Model

- public candidates: selected application frontends and approved public endpoints
- protected candidates: Coolify, Homepage, Uptime Kuma, Supabase admin surfaces, operational dashboards, and backup tooling
- Tailscale should remain available as a protected access path for administrative traffic where practical

### Wave 2 Supabase Direction

Wave 2 Supabase should start with the supported self-hosted Supabase stack, including its PostgreSQL component, rather than introducing a separate PostgreSQL deployment first. Initial DNS planning separates the admin plane and API plane:

- `supabase-prd-serapod.getouch.my` for Supabase Studio and admin access
- `supabase-prd-serapod-kong.getouch.my` for Supabase Kong and API gateway traffic

A separate PostgreSQL tier can still be evaluated later if scaling, operational isolation, or data-platform ownership justify it, but that is a future architecture option rather than an initial dependency.

### Portability Requirement

Future portability to another provider is a hard requirement. Configuration, runbooks, and backups must support rebuilding the base platform without provider lock-in.

## Validation Checklist

- architecture names getouch.my as the primary production platform host
- Wave 1 remains limited to base platform services
- heavy AI inference is assigned to getouch.co
- portability is treated as a hard requirement
- access strategy distinguishes public and protected surfaces

## Rollback Or Caution Notes

- avoid provider-specific assumptions unless they are documented and replaceable
- do not expand the host into a heavy inference role without a separate capacity and security review
