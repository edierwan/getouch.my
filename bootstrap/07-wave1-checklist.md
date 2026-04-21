# Wave 1 Checklist

## Objective

Provide a concise completion checklist for the Wave 1 platform baseline.

## Scope

This checklist is for execution verification only. It does not authorize Wave 2 or Wave 3 work.

## Prerequisites

- bootstrap phases 00 through 06 reviewed
- operator has access to the host for verification

## Implementation Outline

Use this checklist after completing the Wave 1 tasks and again before promoting the baseline for manual review or commit.

## Validation Checklist

- [ ] deploy user created
- [ ] deploy user sudo access verified
- [ ] SSH key login verified
- [ ] root SSH login disabled after validation
- [ ] password authentication disabled after validation
- [ ] firewall enabled with expected allow rules
- [ ] fail2ban enabled if part of the final hardening profile
- [ ] timezone and baseline host settings confirmed
- [ ] Docker installed
- [ ] Docker Compose plugin installed
- [ ] Docker service active
- [ ] Tailscale connected and healthy
- [ ] Coolify installed and reachable
- [ ] Homepage deployed and reachable
- [ ] Uptime Kuma deployed and reachable
- [ ] backup scaffold prepared
- [ ] verify-wave1.sh reviewed or executed as appropriate

## Rollback Or Caution Notes

- if any hardening step breaks operator access, recover before proceeding
- do not mark Wave 1 complete while later-wave services remain implied as active work
