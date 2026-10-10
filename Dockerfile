FROM nginx:1.27-alpine
COPY nginx/default.conf /etc/nginx/templates/default.conf.template
COPY site/ /usr/share/nginx/html/
COPY docs/manual/ /usr/share/nginx/html/manual/
EXPOSE 80
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD wget -q -O - http://127.0.0.1/healthz || exit 1
