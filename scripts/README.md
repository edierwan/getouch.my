# Scripts

This directory contains safe-to-commit operational script scaffolds.

## Rules

- all scripts use bash strict mode
- no real secrets belong in these files
- runtime secrets must come from environment variables or an external secret source
- review each script before production use

## Current Scripts

- backup-postgres.sh: scaffold for timestamped PostgreSQL logical dumps
- backup-volumes.sh: scaffold for Docker volume or data directory archives
- verify-wave1.sh: host verification helper for the Wave 1 baseline
