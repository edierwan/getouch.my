# Open WebUI

## Status

Active. Open WebUI is deployed for Wave 2.

## Intended Role

- operator or internal chat UI
- front end for remote AI backends hosted primarily on getouch.co

## Deployment Intent

- keep the service protected by default
- use remote inference on getouch.co rather than heavy local inference on getouch.my
- consider only a lightweight local fallback later if justified

## Notes

- runtime stack path: `/opt/stacks/open-webui`
- public route: `https://chat.getouch.my`
- first operational step after deployment is creating the first admin user and connecting a model provider
- keep future model routing secrets outside git
