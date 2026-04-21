# Evolution API

## Status

Active. Evolution API is deployed for Wave 2.

## Intended Role

- messaging or WhatsApp integration layer
- controlled API or webhook surface where required

## Deployment Intent

- decide whether public ingress is required for webhook flows
- review data handling and credential storage before deployment

## Notes

- runtime stack path: `/opt/stacks/evolution-api`
- public route: `https://wa.getouch.my`
- first operational step after deployment is creating and pairing a WhatsApp instance
