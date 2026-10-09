# Public repository security

## Publication gate

The repository can be made public only when all of the following are true:

1. The complete reachable history and current tree have been scanned for credentials.
2. Confirmed secrets are zero.
3. Sensitive filenames and generated operational evidence are excluded.
4. Configuration samples contain development defaults or placeholders only.
5. Production topology and runbooks are stored in a private repository.
6. The commit intended for the first public push has no parent from the private history.

## Public/private boundary

Public content includes the static product source, generic local-development settings,
logical architecture, contribution guidance, and public product documentation.

Private content includes host inventory, production addresses and ports, edge routing,
mail infrastructure, firewall and NAT policy, backup locations, recovery procedures,
monitoring endpoints, raw command output, and operational task evidence.

Scanner versions and the final first-release result are recorded during release
verification before the public remote is created or pushed.

## Initial release candidate

The staged parent-repository snapshot was scanned before its root commit:

| Check | Result |
|---|---|
| Gitleaks 8.30.1 directory scan | 0 candidates |
| TruffleHog 3.99.2 filesystem scan | 0 findings |
| Independent credential-pattern scan | 0 candidates |
| Operational-topology review | Production details excluded; local development defaults only |

The root commit and its complete reachable history must be scanned again after commit
creation. A public remote must not be created or pushed until that final result is
reported and approved.
