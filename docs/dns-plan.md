# DNS Draft Plan

## Objective

Define the final Wave 1 subdomain plan and document later-wave names as placeholders only.

## Scope

This is a planning document only. It does not imply that every listed service should be deployed now.

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
| supabase-prd-serapod.getouch.my | Supabase Studio | Wave 2 | Protected/internal candidate | Studio and admin surface for the self-hosted Supabase stack; keep protected and avoid storing secrets in git |
| supabase-prd-serapod-kong.getouch.my | Supabase Kong / API gateway | Wave 2 | Tightly controlled edge candidate | Public API gateway only if required; initial Supabase deployment still uses the bundled PostgreSQL stack |
| wa.getouch.my | Evolution API | Wave 2 | Public or tightly controlled edge candidate | Exposure depends on webhook and API requirements |
| chat.getouch.my | Open WebUI | Wave 2 | Protected/internal candidate | Keep private unless a public chat surface is explicitly required |
| dify.getouch.my | Dify | Wave 3 | Protected/internal candidate | Defer until workflow and model routing requirements are clear |
| llm.getouch.my | LiteLLM optional | Wave 3 | Protected/internal candidate | Optional only; keep private unless a strong external access case exists |

## Validation Checklist

- all required draft subdomains are listed
- Wave 1 services are separated from later-wave services
- final Wave 1 names are coolify.getouch.my, portal.getouch.my, and kuma.getouch.my
- Supabase Studio and Supabase Kong domains are documented separately for Wave 2
- DNS-only records are the preferred initial validation posture
- no separate edge proxy is introduced outside Coolify for Wave 1
- the three final Wave 1 hostnames have been validated against the VPS on 2026-04-21

## Rollback Or Caution Notes

- do not publish DNS records for later-wave services before their access model is reviewed
- keep DNS naming stable where possible to reduce migration churn
