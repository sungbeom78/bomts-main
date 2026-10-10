# DNS records and change plan

The active DNS values are managed in Cloudflare. Credentials and raw zone exports remain outside this public repository.

## Active mail records

- `mail.bomts.net` is a DNS-only host for the self-hosted SMTP endpoint.
- The `bomts.net` MX points to `mail.bomts.net`.
- A single apex SPF record authorizes the current direct server during relay onboarding.
- Mailu DKIM is published at `dkim._domainkey.bomts.net`; the private key is not in Git.
- DMARC is in monitoring mode (`p=none`) while delivery behavior is measured.

Public DNS resolution, external SMTP banner reachability, and an actual Gmail-to-founder delivery were verified on 2026-10-10.

## Outbound relay transition

When an SMTP relay is enabled:

1. Publish the provider's DKIM record.
2. Merge its SPF authorization into the existing SPF policy; never publish two SPF records.
3. Send controlled messages to Gmail, Naver, and Outlook.
4. Confirm expected SPF/DKIM alignment and DMARC pass in received headers.
5. Raise DMARC from monitoring only after normal traffic and reports are clean.

The home address has no PTR. The absence does not stop inbound SMTP, but it makes direct outbound delivery unsuitable for normal operations; a Gmail trial was classified as spam despite SPF, DKIM, and DMARC passing.

## Additional domains

For `edubeom.com`, `ahnda.com`, or another domain, create the domain in Mailu and publish its own MX, SPF, DKIM, and DMARC records. Do not reuse the `bomts.net` DKIM private key or assume one domain's verification covers another.
