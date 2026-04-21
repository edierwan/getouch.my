# DNS Draft Plan

## Objective

Define the initial subdomain plan for Wave 1 and document which later services are public candidates versus protected or internal candidates.

## Scope

This is a planning document only. It does not imply that every listed service should be deployed now.

## Prerequisites

- public IP confirmed for getouch.my
- reverse proxy or ingress strategy understood at a high level
- protected versus public exposure policy agreed

## Implementation Outline

| Subdomain | Intended Service | Wave | Exposure Intent | Notes |
| --- | --- | --- | --- | --- |
| coolify.getouch.my | Coolify | Wave 1 | Protected/internal candidate | Prefer restricted admin access, optionally via Tailscale or stricter access controls |
| home.getouch.my | Homepage | Wave 1 | Protected/internal candidate | Internal operator dashboard, not intended as a public landing page |
| status.getouch.my | Uptime Kuma | Wave 1 | Protected/internal candidate | Can stay protected at first; public status exposure should be a deliberate later choice |
| supabase.getouch.my | Supabase | Wave 2 | Protected/internal candidate | Public exposure should be limited to approved endpoints only, not the whole admin surface |
| wa.getouch.my | Evolution API | Wave 2 | Public or tightly controlled edge candidate | Exposure depends on webhook and API requirements |
| chat.getouch.my | Open WebUI | Wave 2 | Protected/internal candidate | Keep private unless a public chat surface is explicitly required |
| dify.getouch.my | Dify | Wave 3 | Protected/internal candidate | Defer until workflow and model routing requirements are clear |
| llm.getouch.my | LiteLLM optional | Wave 3 | Protected/internal candidate | Optional only; keep private unless a strong external access case exists |

## Validation Checklist

- all required draft subdomains are listed
- Wave 1 services are separated from later-wave services
- exposure intent is documented without assuming public access
- protected services remain the default posture

## Rollback Or Caution Notes

- do not publish DNS records for later-wave services before their access model is reviewed
- keep DNS naming stable where possible to reduce migration churn
