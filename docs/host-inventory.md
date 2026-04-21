# Host Inventory

## Objective

Keep a safe, non-secret inventory of the hosts relevant to the getouch.my platform rollout.

## Scope

This document records hostname, role, provider, and operational notes only. No passwords, keys, tokens, or recovery codes belong here.

## Prerequisites

- hostnames confirmed
- provider and role confirmed
- access policy agreed for the primary VPS

## Implementation Outline

### Primary Host

#### getouch.my

- Hostname: getouch.my
- Public IP: 72.62.254.86
- Provider: Hostinger
- OS: Ubuntu 24.04 LTS
- Role: new primary production platform VPS
- Bootstrap note: initial bootstrap starts with temporary root access
- Final access state: dedicated deploy sudo user, SSH key authentication only, root SSH login disabled, password authentication disabled

### Related Hosts

#### getouch.co

- Role: AI and GPU host
- Usage note: preferred location for heavy inference workloads and remote AI backends

#### getouch.cloud

- Role: legacy or migration reference environment
- Usage note: keep as comparison or fallback context during migration planning

## Validation Checklist

- only non-secret inventory data is included
- primary host role and access target state are clear
- related hosts are described at a high level only

## Rollback Or Caution Notes

- update this file if the provider, IP, or host role changes
- do not expand this inventory into a secret register
