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
Internet
  -> provider or public SMTP edge with stable IP and PTR
  -> mailbox service / secure relay
  -> founder@bomts.net and ott@bomts.net as separate accounts
```

Cloudflare Tunnel may front webmail HTTPS but is not an SMTP MX endpoint. The SMTP design stays gated until the network findings in `current-environment.md` are resolved.

The design keeps mail domains separate from mailboxes so `edubeom.com` and `ahnda.com` can be added later without merging access rights.

## Internal mail management path

The public website and Mailu remain separate Compose projects. For LAN-only management, the website container also joins Mailu's existing bomts-mailu_webmail network and proxies Webmail/Admin requests to Mailu Front over HTTPS. The upstream service name and mail hostname are runtime environment values; host addresses and credentials are not stored in Git. Nginx denies the management, SSO, and mail UI paths whenever the request arrived through the public Cloudflare route.
