# Wave 1 — Tailscale

## Objective

Establish a protected network path for administration and future private service traffic.

## Scope

This phase covers Tailscale installation, network join, and verification of protected reachability.

## Prerequisites

- OS hardening completed
- outbound network access available
- Tailnet approval method prepared outside git

## Implementation Outline

1. install Tailscale from a supported source
2. join the host to the approved Tailnet
3. verify the node is healthy and receives the expected private address
4. verify reachability to getouch.co or other approved private peers
5. reserve Tailscale as an access path for protected admin services where practical

## Validation Checklist

- tailscale status is healthy
- private tailnet IP is assigned
- approved private peers are reachable
- intended admin access path is documented

## Rollback Or Caution Notes

- do not assume Tailscale replaces all public access controls
- keep join tokens and auth material outside git
