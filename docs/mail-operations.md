# Mail operations

## Current state

Mailu 2024.06 runs the BOMTS mailbox service. Inbound TCP 25 is reachable from the internet and `founder@bomts.net` received an actual external Gmail message. Zoho onboarding is discontinued.

The operational Compose files, backup procedures, and physical storage map are maintained in the private `sungbeom78/bomts-infra` repository. This public document describes user-visible behavior without publishing host inventory, filesystem paths, NAT topology, or credentials.

## Accounts

| Address | Type | Quota and access |
|---|---|---|
| `founder@bomts.net` | Independent mailbox | 1 GB; founder only |
| `disney@bomts.net` | Independent mailbox | 1 GB; separate login |
| `netflix@bomts.net` | Independent mailbox | 1 GB; separate login |
| `admin@bomts.net` | Administrative mailbox | Infrastructure administration |
| `contact@bomts.net` | Alias | Delivers to founder |

Catch-all is disabled. Passwords are unique, stored outside Git, and should be changed after the first login.

## Client settings

Use the full email address as the username and `mail.bomts.net` as the server.

| Protocol | Port | Security |
|---|---:|---|
| IMAP | 993 | Implicit TLS |
| POP3 | 995 | Implicit TLS |
| SMTP Submission | 465 | Implicit TLS |
| SMTP Submission | 587 | STARTTLS |
| Webmail | 443 | HTTPS at `https://webmail.bomts.net/webmail/` |

Plaintext ports 110 and 143 are disabled. Internet clients require the corresponding ports to be forwarded through both routers and tested externally. Keep the administration path behind Cloudflare Access or a VPN.

## External account import

Mailu Fetchmail is enabled for importing external POP3 or IMAP accounts into a selected local mailbox. Store provider passwords or app passwords outside Git. Confirm the external provider's POP3/IMAP permission and two-factor authentication policy before configuring an account.

## Outbound policy

Direct delivery is diagnostic only. A controlled Gmail test was accepted and authenticated but classified as spam, and the home public address has no PTR. Configure an authenticated relay, then test Gmail, Naver, and Outlook before treating outbound delivery as ready.

## Backup

Persistent mail data, account state, filtering state, DKIM/TLS material, and host configuration are included in the private backup set. A consistent backup and non-destructive restore/hash test passed on 2026-10-10. Exact paths and commands remain in `bomts-infra`.

## Internal management portal

Open the BOMTS website through its LAN address and select **관리**. The internal-only page links to Webmail, Mailu Admin, and the operating manuals.

### Per-account forwarding

In Mailu Admin, open the target user, enable **Auto-forward**, and enter destination addresses separated by commas. Enable **Keep a copy of the emails** when the original mailbox must retain the message. Test both the retained copy and every destination after each change.

### External account import and mail clients

For Naver or another provider, enable POP3/IMAP and create an app password when required. Add it under **Fetched accounts** with TLS and the provider's documented host and port. Never put that password in Git or evidence.

External clients use mail.bomts.net with the full email address as the username: IMAP 993, POP3 995, SMTP 465 (implicit TLS) or 587 (STARTTLS). Internet access still requires the corresponding double-NAT port forwarding.
