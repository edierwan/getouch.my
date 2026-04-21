# Redis

## Status

Active. Redis is deployed as an internal Wave 2 service.

## Intended Role

- cache
- queue or broker support where justified
- shared state for selected platform services

## Deployment Intent

- keep persistence, backup, and access requirements explicit before deployment
- avoid exposing Redis directly to the public internet

## Notes

- deployed container: `wave2-redis`
- current role: shared internal cache/state service for Evolution API and other Wave 2 workloads
- no public hostname is assigned
