# Backup And Restore Strategy

## Objective

Define a restore-focused backup strategy for the getouch.my platform without storing any real offsite credentials or destination details in git.

## Scope

Wave 1 covers planning and script scaffolding only. Full backup automation and retention tuning can expand in later waves.

## Prerequisites

- target host directories standardized
- service data locations documented before production use
- offsite destination selected outside git

## Implementation Outline

### Database Backups

- use logical dumps for PostgreSQL-based services where appropriate
- keep backup naming timestamped and host-aware
- do not store database credentials in scripts; pass them through environment variables or a secret source at runtime

### Config Backups

- back up deployment manifests, compose files, and service configuration that is not itself secret
- keep redacted templates in git and actual runtime values outside git

### Critical Volume Backups

- capture named Docker volumes or mounted data directories for stateful services
- compress volume archives when practical
- exclude transient caches that can be rebuilt

### Offsite Copy

- replicate backups to an offsite destination
- do not store bucket names, access keys, or tokens in this repository
- validate transfer success and log outcomes in an operator-visible location

### Restore Verification

- schedule restore drills, not just backup generation
- verify that at least one database dump and one volume archive can be restored on a non-production target
- keep a short restore checklist with expected inputs and outputs

## Validation Checklist

- database, config, and critical volume backup categories are defined
- offsite copy is planned without real destination secrets in git
- restore verification is explicitly required
- Wave 1 remains scaffold-only, not full automation

## Rollback Or Caution Notes

- backup success is not equivalent to restore success
- do not rely on a single backup destination
- review retention and encryption choices before enabling automated offsite sync
