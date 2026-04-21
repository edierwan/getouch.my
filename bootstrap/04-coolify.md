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

- Coolify is reachable through the intended URL or protected path
- admin access is confirmed
- deployment control-plane role is documented

## Rollback Or Caution Notes

- keep Coolify protected unless there is a reviewed reason for broader exposure
- document any bootstrap-specific assumptions for future rebuilds
