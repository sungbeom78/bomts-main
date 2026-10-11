# Architecture

## Public website

```text
Browser
  -> Cloudflare DNS / HTTPS
  -> existing Cloudflare Tunnel
  -> public http://127.0.0.1:3001
  -> internal http://<LAN_IP>:3001
  -> bomts_public_website (nginx, static files)
```

The site is static and has no application database. Public tunnel traffic binds to loopback, while a host-only `.env` value adds the LAN binding used for internal manuals. TLS terminates at Cloudflare. Nginx adds baseline browser security headers and exposes `/healthz` for local and external monitoring.

## Mail target

```text
Internet SMTP
  -> mail.bomts.net:25
  -> Mailu on the Mini PC
  -> seven independent bomts.net Mailboxes
```

Mailu directly receives inbound SMTP and stores account state and Maildir data on the Mini PC. The independent users are founder, admin, ai.claude, ai.openai, ott.disney, ott.netflix, and infra.cloudflare. Outbound delivery can use an external SMTP relay without moving the Mailboxes. Cloudflare Tunnel is not an SMTP MX endpoint.

The design keeps mail domains separate from mailboxes so `edubeom.com` and `ahnda.com` can be added later without merging access rights.

## Internal mail management path

The public website and Mailu remain separate Compose projects. For LAN-only management, the website shows the management page and redirects Webmail/Admin paths to Mailu's direct HTTPS listener. Host addresses and credentials are not stored in Git. Nginx returns 404 for the management, SSO, and mail UI paths when the request arrived through the public Cloudflare route.
