# DNS Draft Plan

## Objective

Define the active Wave 1 and Wave 2 subdomain plan and record any remaining DNS corrections.

## Scope

This document reflects the current production routing state for deployed services and the remaining draft names for later waves.

## Prerequisites

- public IP confirmed for getouch.my
- reverse proxy or ingress strategy understood at a high level
- protected versus public exposure policy agreed

## Implementation Outline

| Subdomain | Intended Service | Wave | Exposure Intent | Notes |
| --- | --- | --- | --- | --- |
| coolify.getouch.my | Coolify | Wave 1 | Public hostname, DNS-only initially | Served by the Coolify-managed Traefik proxy |
| portal.getouch.my | Homepage | Wave 1 | Public hostname, DNS-only initially | Exposed through the Coolify-managed Traefik proxy |
| kuma.getouch.my | Uptime Kuma | Wave 1 | Public hostname, DNS-only initially | Exposed through the Coolify-managed Traefik proxy |
| supabase-prd-serapod.getouch.my | Supabase Studio | Wave 2 | Public hostname | Live through the Coolify-managed Traefik proxy |
| supabase-prd-serapod-kong.getouch.my | Supabase Kong / API gateway | Wave 2 | Public hostname | Live at the origin through Traefik; current public DNS/proxy record still needs correction because the hostname returns Cloudflare 522 |
| wa.getouch.my | Evolution API | Wave 2 | Public hostname | Live through the Coolify-managed Traefik proxy |
| chat.getouch.my | Open WebUI | Wave 2 | Protected/internal candidate | Live through the Coolify-managed Traefik proxy; first-user bootstrap still required |
| dify.getouch.my | Dify | Wave 3 | Protected/internal candidate | Defer until workflow and model routing requirements are clear |
| llm.getouch.my | LiteLLM optional | Wave 3 | Protected/internal candidate | Optional only; keep private unless a strong external access case exists |

## Validation Checklist

- all required draft subdomains are listed
- Wave 1 services are separated from later-wave services
- final Wave 1 names are coolify.getouch.my, portal.getouch.my, and kuma.getouch.my
- Supabase Studio and Supabase Kong domains are documented separately for Wave 2
- Wave 2 live domains now reflect the deployed runtime state
- no separate edge proxy is introduced outside Coolify for Wave 1
- the three final Wave 1 hostnames have been validated against the VPS on 2026-04-21

## Rollback Or Caution Notes

- correct `supabase-prd-serapod-kong.getouch.my` to a DNS-only A record pointing to `72.62.254.86` or an equivalent Cloudflare proxy configuration that can complete origin TLS successfully
- keep DNS naming stable where possible to reduce migration churn
