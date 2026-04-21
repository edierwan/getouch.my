# Environment Templates

This directory stores safe-to-commit environment templates only.

## Rules

- commit .env.example only
- never commit real .env files
- never commit production secrets
- keep placeholders descriptive and redacted

## Usage

1. copy the example into a local non-git-tracked file when needed
2. inject real values manually or from a secret store
3. keep runtime-specific secrets out of repository history
