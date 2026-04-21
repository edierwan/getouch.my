# Wave 1 — OS Hardening

## Objective

Harden the base Ubuntu host so administration moves from temporary root bootstrap access to a deploy sudo user with SSH key-only access.

## Scope

This phase covers user access, SSH policy, firewall posture, baseline packages, and host hygiene required before platform services are installed.

## Prerequisites

- temporary root access is available
- deploy operator SSH public key is ready
- a second SSH session can be kept open for validation during hardening

## Implementation Outline

1. update package indexes and install baseline packages required for operations
2. create the deploy sudo user
3. install the approved SSH public key for the deploy user
4. validate deploy user sudo access from a second session
5. update SSH daemon policy for key-based authentication only
6. disable root SSH login after deploy access is proven
7. disable password authentication after deploy access is proven
8. enable firewall rules needed for SSH and planned Wave 1 services
9. install and enable fail2ban if used in the final hardening profile
10. confirm timezone and other basic host settings

## Validation Checklist

- deploy user exists and can use sudo
- SSH key login works for deploy user
- root SSH login is disabled after validation
- password authentication is disabled after validation
- firewall is enabled with expected allow rules
- fail2ban is active if enabled

## Rollback Or Caution Notes

- keep the original root session open until deploy SSH access is verified end to end
- apply SSH daemon changes carefully and test before disconnecting

## Known Issue: Ubuntu 24.04 cloud-init drop-in

Ubuntu 24.04 Hostinger images ship `/etc/ssh/sshd_config.d/50-cloud-init.conf`
with `PasswordAuthentication yes`. Because OpenSSH processes drop-in files
alphabetically and the first matching directive wins, this file overrides any
later drop-in (e.g. `99-hardening.conf`) that sets `PasswordAuthentication no`.

Fix: overwrite that file during hardening:

```bash
echo "PasswordAuthentication no" | sudo tee /etc/ssh/sshd_config.d/50-cloud-init.conf
sudo sshd -t && sudo systemctl restart ssh
```

Verify with: `sudo sshd -T | grep passwordauth` — must show `no`.
