# Redis

## Status

Deferred. Redis is a later-wave service and is not part of the active Wave 1 implementation scope.

## Intended Role

- cache
- queue or broker support where justified
- shared state for selected platform services

## Deployment Intent

- evaluate in Wave 2 after the base platform is stable
- keep persistence, backup, and access requirements explicit before deployment
- avoid exposing Redis directly to the public internet

## Notes

- document final placement and retention strategy before enabling persistence
- do not add live manifests here until Wave 2 is approved
