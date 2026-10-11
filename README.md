# BOMTS

BOMTS is a bootstrapped, early-stage AI-assisted decision-support project founded
in April 2026 in South Korea by Sungbeom Ahn. Development began with private
prototypes in March 2026. This public repository was intentionally started with a
new, sanitized history on October 9, 2026; that public release date is not the
beginning of the project.

- Website: [https://www.bomts.net/](https://www.bomts.net/)
- Founder: Sungbeom Ahn (안숭범)
- Public contact: [founder@bomts.net](mailto:founder@bomts.net)

This repository contains the public static website, product documentation, logical
architecture, local development configuration, and non-secret examples. Production
credentials, host inventory, routing details, backup locations, recovery procedures,
and raw operational evidence are maintained outside the public repository.

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
- `docs/google-search-console.md`: sitemap submission and indexing procedure
- `docs/bomts-decision-public-readiness.md`: read-only public-release security audit
- `docs/manual/`: public product and contributor manual
- `docs/mail-operations.md`: mailbox user settings and public service status
- `scripts/check.sh`: local repository validation

## Development standard

Development follows the pinned `dev-process-framework` submodule and
`project.policy.yaml`. The framework and shared glossary are read-only dependencies.

## Security boundary

Never commit live credentials, private keys, database files, production addresses, or
host-specific operational output. See `docs/public-repository-security.md` before a
public release.
