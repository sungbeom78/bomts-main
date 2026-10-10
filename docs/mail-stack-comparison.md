# Mail stack comparison

Decision date: 2026-10-10. The deployment target is a small self-hosted environment that also runs other BOMTS workloads.

| Option | Resource and operations | Required features | Decision |
|---|---|---|---|
| Mailu 2024.06 | About 1 GiB without ClamAV or 3 GiB with it; integrated Compose and admin UI | Roundcube, IMAP, POP3, Submission, quotas, multiple domains, Fetchmail | **Selected**: best balance for the current host and one operating surface |
| mailcow | At least 6 GiB RAM plus swap is recommended; broader groupware and operating surface | Integrated administration and IMAP sync | Capable but unnecessarily heavy for the initial mailbox count |
| Stalwart | Light server footprint and modern all-in-one mail protocols | Multi-domain and administration; comparable Webmail needs a separate product | Good server option, but adds Webmail integration work |

## Result

Mailu is deployed as the self-hosted mailbox layer. External TCP 25 reaches `mail.bomts.net`, and an actual Gmail message was received in `founder@bomts.net`. The mailbox layer, account database, Webmail, IMAP, POP3, Submission, spam filtering, and persistent data all remain self-hosted.

Direct outbound delivery passed SPF, DKIM, and DMARC but a Gmail test was classified as spam. The public address has no PTR, so normal outbound mail will use an authenticated SMTP relay after provider onboarding. The relay handles transport only and does not own mailbox data.
