# Homepage

## Status

Wave 1 live. Homepage is the operations portal at portal.getouch.my.

## Intended Role

- primary operations dashboard for getouch.my
- landing page for live Wave 1 control-plane services
- safe placeholder landing surface for planned Wave 2 services

## Config Source

The tracked templates in `config/` are the repo source of truth for the current portal layout.

Tracked config files:

- settings.yaml
- services.yaml
- widgets.yaml
- bookmarks.yaml
- docker.yaml
- custom.css
- custom.js

## Deployment Intent

- keep the portal clean, minimal, and production-friendly
- remove all sample groups and sample links
- include live Wave 1 services and clearly labeled Wave 2 placeholders
- do not commit secrets, tokens, API keys, or runtime-only env files

## Notes

- Homepage is exposed at `portal.getouch.my`
- planned Wave 2 cards may link to distinct placeholder pages, but must never share a wrong fallback target
- current placeholder destinations are `supabase-prd-serapod.getouch.my`, `wa.getouch.my`, and `chat.getouch.my`
