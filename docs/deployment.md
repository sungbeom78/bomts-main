# Website deployment

## Deploy

```bash
./scripts/check.sh
docker compose up -d --build
curl -fsS http://127.0.0.1:3001/healthz
curl -I https://www.bomts.net
```

The Compose service uses restart policy `unless-stopped`, binds public tunnel traffic to `127.0.0.1:3001` and internal traffic to `${BOMTS_HOST_NETWORK_IP}:3001`, runs with a read-only root filesystem, and uses temporary filesystems for Nginx runtime state.

## Rollback

Use the previous Git revision and rebuild the website service. Do not change `/etc/cloudflared/config.yml`; the origin contract remains `http://127.0.0.1:3001`.

## Operational checks

- `docker compose ps`
- `docker inspect --format '{{json .State.Health}}' bomts_public_website`
- `curl -fsS http://127.0.0.1:3001/healthz`
- `curl -I https://www.bomts.net`

If the local health check passes and the public site fails, inspect the cloudflared service and tunnel route. Back up any system configuration before editing it.

## Repair the decision tunnel route

The guarded repair command for the known `decision.bomts.net` origin typo is:

```bash
sudo /project/bomts-main/scripts/fix-decision-tunnel.sh
```

The command refuses unexpected configuration states. It creates `/etc/cloudflared/config.yml.YYYYMMDD_HHMMSS.bak`, validates the candidate and installed configuration, restarts cloudflared, and requires both the local service and public URL to return HTTP 200. If a post-install check fails, it restores the backup and restarts cloudflared.

The repair completed on 2026-10-08. The preserved backup is `/etc/cloudflared/config.yml.20261008_110552.bak`. Verify the current state without changing it:

```bash
./scripts/check-decision-tunnel.sh
```

## Internal mail management proxy

The website container joins the external Docker network named bomts-mailu_webmail. Runtime .env must set BOMTS_MAIL_ORIGIN=https://front; the public example contains no host IP or credential. Nginx renders its template into the writable /etc/nginx/conf.d tmpfs while the rest of the container remains read-only.

LAN requests may open /manage/, /webmail/, /admin/, /sso/, and Mailu static assets. Requests carrying the public Cloudflare client header receive 404 for those paths. A deployment is complete only after browser checks confirm both sides.
