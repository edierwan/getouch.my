# Wave 1 — Docker

## Objective

Install a production-safe Docker runtime baseline for Wave 1 services.

## Scope

This phase covers Docker Engine, the Docker Compose plugin, service enablement, and basic filesystem conventions for containerized workloads.

## Prerequisites

- OS hardening completed
- deploy user sudo access verified
- package repositories reachable

## Implementation Outline

1. install the official Docker Engine packages from the supported source
2. install the Docker Compose plugin
3. enable and start the Docker service
4. create standard directories for platform data, compose manifests, and backups
5. review logging and disk usage defaults before production workloads are added

## Validation Checklist

- docker version returns successfully
- docker compose version returns successfully
- Docker service is enabled and active
- standard server directories exist
- a basic container test can run successfully

## Rollback Or Caution Notes

- confirm package source trust before installation
- keep disk growth under review once stateful services are introduced
