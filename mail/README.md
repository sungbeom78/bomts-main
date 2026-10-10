# BOMTS mail target state

This directory contains provider-neutral desired state and the onboarding runbook. It contains no live password, token, verification value, or DKIM private key.

## Interim provider decision

Use Zoho Mail as the interim hosted mailbox service for the Claude Startups application. It supports custom domains, separate users, aliases, and administrative verification of MX, SPF, DKIM, and DMARC. Choose a current plan that supports at least two independent users and the required client access; do not assume a free plan is available in every region.

The mailbox addresses remain provider-neutral so they can later migrate to a public SMTP edge plus self-hosted storage.

See `provider-onboarding.md` and `address-policy.yaml`.
