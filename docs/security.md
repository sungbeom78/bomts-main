# Security baseline

## Public repository

- Commit placeholders and public identifiers only.
- Keep `.env`, credentials, private keys, database files, dumps, and infrastructure
  state outside Git.
- Scan the current tree and all reachable commits before publication.
- Treat any committed reusable credential as compromised and rotate it.

## Website

- Serve immutable static assets from a read-only container filesystem.
- Apply browser security headers in the web-server configuration.
- Keep the origin bind address private to the deployment environment.
- Do not add login, upload, or server-side form handling without a separate security
  and data-model review.

## Operations boundary

Production topology, deployment procedures, edge configuration, mail, firewall policy,
backup, monitoring, and incident recovery belong in the private infrastructure
repository.
