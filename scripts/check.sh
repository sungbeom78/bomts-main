#!/bin/sh
set -eu

test -f site/index.html
test -f site/en/index.html
test -f site/privacy/index.html
test -f site/terms/index.html
test -f site/robots.txt
test -f site/sitemap.xml
test -f docs/architecture.md
test -f docs/manual/index.html
test -f docs/manual/website.html
test -f docs/manual/architecture.html
test -f docs/manual/admin.html

sh -n scripts/check.sh
sh -n dev-process/local/scripts/check-framework-sync.sh

for page in site/index.html site/en/index.html site/about/index.html site/product/index.html site/contact/index.html site/privacy/index.html site/terms/index.html; do
  grep -q '<meta name="viewport"' "$page"
  grep -q 'BOMTS' "$page"
done

grep -q 'founder@bomts.net' site/index.html
grep -q 'founder@bomts.net' site/en/index.html
grep -q 'https://www.bomts.net/en/' site/sitemap.xml

docker compose config --quiet
