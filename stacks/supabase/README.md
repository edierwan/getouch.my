# Supabase

## Status

Deferred. Supabase is planned for Wave 2 and is not implemented in this baseline.

## Intended Role

- self-hosted data platform
- PostgreSQL-backed application services
- admin and studio surfaces kept protected

## Deployment Intent

- review resource usage and storage requirements first
- use the supported self-hosted Supabase stack, including its PostgreSQL component, for the initial Wave 2 rollout
- keep admin interfaces protected
- reserve `supabase-prd-serapod.getouch.my` for Supabase Studio and admin access
- reserve `supabase-prd-serapod-kong.getouch.my` for Supabase Kong and API gateway traffic
- treat a separate PostgreSQL deployment as a later option only if scaling or architecture needs justify it
- align backup and restore procedures before production use

## Notes

- document only deployment intent for now
- do not commit real service secrets, JWT material, or runtime env files
