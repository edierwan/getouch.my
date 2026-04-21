# Scope and Rules

## Objective

Bootstrap the new getouch.my VPS in controlled waves until it becomes the new primary production platform host.

## Scope

Wave 1 is the completed baseline in this repository. Wave 2 and Wave 3 remain deferred.

In scope now:

- OS hardening
- deploy sudo user strategy
- SSH key-only access model
- Docker Engine and Compose plugin
- Tailscale
- Coolify
- Homepage
- Uptime Kuma
- backup scaffold only

Out of scope now:

- full production workload migration
- Redis
- Supabase
- Evolution API
- Open WebUI
- Dify
- n8n
- LiteLLM
- advanced Netdata rollout

## Prerequisites

- host inventory confirmed
- SSH public key prepared for the deploy user
- operator understands that initial root access is temporary only

## Implementation Outline

1. execute work wave by wave
2. validate after each major step
3. keep changes production-safe and reversible where practical
4. keep secrets out of git
5. use templates and redacted examples only
6. do not treat placeholders as deployed services

## Validation Checklist

- Wave 1 scope is clear and bounded
- later services are deferred explicitly
- no step requires storing secrets in git
- final target state removes dependency on root login and password authentication

## Rollback Or Caution Notes

- never disable root or password authentication until deploy user access is verified
- stop the rollout if a validation step fails and return to the last known-good state
