# Supabase

## Status

Active. The self-hosted Supabase stack is deployed for Wave 2.

## Intended Role

- self-hosted data platform
- PostgreSQL-backed application services
- admin and studio surfaces kept protected

## Deployment Intent

- use the supported self-hosted Supabase stack, including its PostgreSQL component, for the initial Wave 2 rollout
- keep admin interfaces protected
- serve `supabase-prd-serapod.getouch.my` as the live Supabase Studio surface
- serve `supabase-prd-serapod-kong.getouch.my` as the live Supabase Kong and API gateway surface
- treat a separate PostgreSQL deployment as a later option only if scaling or architecture needs justify it
- align backup and restore procedures before production use

## Notes

- runtime stack path: `/opt/stacks/supabase`
- Studio is publicly reachable through Traefik at `supabase-prd-serapod.getouch.my`
- Kong is routed correctly at the origin but the current public DNS/proxy record for `supabase-prd-serapod-kong.getouch.my` still needs correction
- do not commit real service secrets, JWT material, or runtime env files
