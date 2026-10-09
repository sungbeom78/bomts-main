# BOMTS public website

This repository contains the static website for BOMTS. It includes public product
content, a logical architecture description, local development configuration, and
non-secret examples.

Production infrastructure, host inventory, edge routing, mail systems, firewall rules,
backup locations, recovery procedures, and raw operational evidence are maintained in
the private `bomts-infra` repository.

## Local development

```bash
cp .env.example .env
docker compose up --build
curl -fsS http://127.0.0.1:8080/healthz
```

Change `BOMTS_HTTP_PORT` in the ignored `.env` file when the default development port
is already in use.

## Repository contents

- `site/`: Korean and English public pages
- `nginx/`: generic static-site server configuration
- `docs/architecture.md`: logical product architecture
- `docs/manual/`: public product and contributor manual
- `scripts/check.sh`: local repository validation

## Development standard

Development follows the pinned `dev-process-framework` submodule and
`project.policy.yaml`. The framework and shared glossary are read-only dependencies.

## Security boundary

Never commit live credentials, private keys, database files, production addresses, or
host-specific operational output. See `docs/public-repository-security.md` before a
public release.
