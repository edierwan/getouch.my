# Operations Runbooks

## Objective

Provide concise operational procedures for the initial bootstrap and Wave 1 baseline management.

## Scope

These runbooks cover first bootstrap, Wave 1 validation, pre-Wave-2 readiness, and post-change verification.

## Prerequisites

- repository reviewed
- operator has approved rollout order
- SSH keys prepared for the deploy user
- maintenance window or change awareness confirmed when needed

## Implementation Outline

### First Bootstrap

1. Confirm the host inventory and public IP.
2. Log in with temporary root access only for the initial bootstrap window.
3. Create the deploy sudo user and install the approved SSH public key.
4. Verify sudo and SSH key access using a second session before changing SSH policy.
5. Apply SSH hardening, then disable root login and password authentication.
6. Install Docker Engine, Compose plugin, and baseline directories.
7. Install and join Tailscale.
8. Deploy Coolify, then deploy Homepage and Uptime Kuma.
9. Place backup scaffolding and verify that scripts are executable.
10. Run the Wave 1 verification checklist.

### Wave 1 Validation

1. Confirm deploy user access works with SSH keys only.
2. Confirm root login is disabled.
3. Confirm password authentication is disabled.
4. Confirm Docker and Docker Compose report expected versions.
5. Confirm Tailscale is connected.
6. Confirm the Coolify-managed Traefik proxy is active for coolify.getouch.my, portal.getouch.my, and kuma.getouch.my.
7. Confirm the backup scripts run in a safe, non-secret-driven manner.

Manual Coolify UI step:
Create the initial root admin account at https://coolify.getouch.my/register.

### Pre-Wave-2 Readiness

1. Review DNS exposure decisions for each planned service.
2. Confirm backup destinations and restore drill approach are defined outside git.
3. Confirm base platform stability over an observation window.
4. Confirm resource headroom before adding stateful services.
5. Confirm service ownership and rollback expectations for each Wave 2 workload.

### Post-Change Verification

1. Re-run the Wave 1 verification script after meaningful base-platform changes.
2. Check service reachability through the expected URLs or internal paths.
3. Review logs for failed containers, SSH issues, and Tailscale health warnings.
4. Confirm no secrets or local-only files were added to git status.

## Validation Checklist

- all four early runbook areas are covered
- steps are execution-oriented and ordered
- no runbook requires storing secrets in git

## Rollback Or Caution Notes

- never disable root or password login until deploy SSH access is verified from a separate session
- avoid making multiple major platform changes without an intermediate validation step
