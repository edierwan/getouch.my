# Homepage

## Status

Wave 1 live. Homepage is the operations portal at portal.getouch.my.

## Intended Role

- primary operations dashboard for getouch.my
- landing page for live Wave 1 control-plane services
- landing page for live Wave 2 service entrypoints

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
- include live Wave 1 services and live Wave 2 entrypoints
- do not commit secrets, tokens, API keys, or runtime-only env files

## Notes

- Homepage is exposed at `portal.getouch.my`
- current live Wave 2 card targets are `supabase-prd-serapod.getouch.my`, `wa.getouch.my`, and `chat.getouch.my`
- `supabase-prd-serapod-kong.getouch.my` is live at the origin but still needs a public DNS/proxy correction before it is added back as a browser-facing portal entry
