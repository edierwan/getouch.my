# Open WebUI

## Status

Deferred. Open WebUI is planned for Wave 2 and is not part of the current execution scope.

## Intended Role

- operator or internal chat UI
- front end for remote AI backends hosted primarily on getouch.co

## Deployment Intent

- keep the service protected by default
- use remote inference on getouch.co rather than heavy local inference on getouch.my
- consider only a lightweight local fallback later if justified

## Notes

- do not treat chat.getouch.my as active deployment scope yet
- keep future model routing secrets outside git
