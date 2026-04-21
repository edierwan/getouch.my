# Wave 1 — Homepage

## Objective

Provide a simple operational dashboard for platform operators.

## Scope

This phase covers deployment of Homepage and a minimal set of tiles for Wave 1 visibility.

## Prerequisites

- Docker baseline completed
- DNS draft reviewed for portal.getouch.my
- list of initial platform links agreed

## Implementation Outline

1. deploy Homepage as a Wave 1 utility service
2. expose it through portal.getouch.my
3. add initial tiles for Wave 1 services and later-wave placeholders as references only

Suggested initial tiles:

- Coolify
- Uptime Kuma
- future Supabase reference
- future Evolution API reference
- future Open WebUI reference

## Validation Checklist

- Homepage is reachable through portal.getouch.my
- Homepage is routed by the Coolify-managed Traefik proxy
- Homepage host validation accepts portal.getouch.my
- dashboard renders correctly
- initial tiles match the current documented platform intent

## Rollback Or Caution Notes

- avoid presenting undeployed services as live systems
- keep Homepage protected if it exposes internal management links

## Execution Note

Homepage required `HOMEPAGE_ALLOWED_HOSTS=portal.getouch.my` once it was placed
behind the Coolify-managed Traefik proxy. Without that allowlist, the app
returned `Host validation failed` for the final Wave 1 domain.
