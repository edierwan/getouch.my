# Wave 1 — Coolify

## Objective

Prepare Coolify as the deployment control plane for the new platform host.

## Scope

This phase covers Coolify installation, access path planning, and initial environment preparation only.

## Prerequisites

- Docker baseline completed
- DNS draft reviewed for coolify.getouch.my
- protected access approach chosen

## Implementation Outline

1. install Coolify using the supported deployment approach
2. bind it to the intended host and access path
3. confirm the admin interface is reachable through the chosen route
4. document the initial project or environment structure to be used later

## Validation Checklist

- Coolify is reachable through coolify.getouch.my via the Coolify-managed Traefik proxy
- admin access is confirmed
- deployment control-plane role is documented

## Rollback Or Caution Notes

- keep Coolify protected unless there is a reviewed reason for broader exposure
- document any bootstrap-specific assumptions for future rebuilds

## Execution Note

On this host, the initial Coolify localhost server record was installed with a
stale root-based self-management path. After Wave 1 SSH hardening, the approved
proxy path still remained `TRAEFIK`, but the `coolify-proxy` container was not
running until the canonical instance FQDN and proxy files were aligned to the
final Wave 1 domains.
