# Wave 1 — Uptime Kuma

## Objective

Establish a baseline uptime monitoring surface for the new platform.

## Scope

This phase covers Uptime Kuma deployment and a minimal monitor set for Wave 1 services.

## Prerequisites

- Docker baseline completed
- intended access path for kuma.getouch.my reviewed
- list of initial monitors agreed

## Implementation Outline

1. deploy Uptime Kuma
2. expose it through kuma.getouch.my
3. create baseline monitors for the primary Wave 1 endpoints
4. document future alerting as a later improvement rather than part of initial completion

Suggested initial checks:

- main domain or core endpoint
- Coolify
- Homepage

## Validation Checklist

- Uptime Kuma is reachable through kuma.getouch.my
- Uptime Kuma is routed by the Coolify-managed Traefik proxy
- monitors can be created and tested
- baseline endpoints are represented

## Rollback Or Caution Notes

- do not overexpose monitoring dashboards without an explicit reason
- alerting configuration can follow after baseline service reachability is proven
