#!/bin/sh
set -eu

test -f site/index.html
test -f site/en/index.html
test -f site/en/about/index.html
test -f site/en/product/index.html
test -f site/en/contact/index.html
test -f site/en/privacy/index.html
test -f site/en/terms/index.html
test -f site/privacy/index.html
test -f site/terms/index.html
test -f site/robots.txt
test -f site/sitemap.xml
test -f site/google16ad3deed6bb0ce2.html
test -f docs/architecture.md
test -f docs/manual/index.html
test -f docs/manual/website.html
test -f docs/manual/architecture.html
test -f docs/manual/admin.html

sh -n scripts/check.sh
sh -n dev-process/local/scripts/check-framework-sync.sh

for page in site/index.html site/en/index.html site/en/about/index.html site/en/product/index.html site/en/contact/index.html site/en/privacy/index.html site/en/terms/index.html site/about/index.html site/product/index.html site/contact/index.html site/privacy/index.html site/terms/index.html; do
  grep -q '<meta name="viewport"' "$page"
  grep -q 'BOMTS' "$page"
done

grep -q 'founder@bomts.net' site/index.html
grep -q 'founder@bomts.net' site/en/index.html
grep -q 'https://www.bomts.net/en/' site/sitemap.xml
grep -q 'https://www.bomts.net/en/about/' site/sitemap.xml
grep -q 'https://www.bomts.net/en/product/' site/sitemap.xml
grep -q 'https://www.bomts.net/en/contact/' site/sitemap.xml
grep -q 'https://www.bomts.net/en/privacy/' site/sitemap.xml
grep -q 'https://www.bomts.net/en/terms/' site/sitemap.xml
grep -q '2026년 10월 9일' site/about/index.html
grep -q 'October 9, 2026' site/en/about/index.html
grep -q 'April 2026' README.md
grep -q 'Sitemap: https://www.bomts.net/sitemap.xml' site/robots.txt
test "$(cat site/google16ad3deed6bb0ce2.html)" = 'google-site-verification: google16ad3deed6bb0ce2.html'

! grep -R -q '사업자 및 개인정보 보호 책임자 정보는 실제 정보 확인 후 보완됩니다' site
! grep -R -q '관할, 사업자 정보 등 법적 필수 항목은 실제 운영 주체 확인 후 보완됩니다' site
! grep -q 'Private development records show\|Public verification\|does not claim unverified' site/en/about/index.html
grep -q 'Initial prototype development began.' site/en/about/index.html
grep -q '초기 프로토타입 개발을 시작했습니다.' site/about/index.html

python3 - <<'PY'
from pathlib import Path

pairs = {
    '/': '/en/',
    '/product/': '/en/product/',
    '/about/': '/en/about/',
    '/contact/': '/en/contact/',
    '/privacy/': '/en/privacy/',
    '/terms/': '/en/terms/',
}
for ko, en in pairs.items():
    for path, lang in ((ko, 'ko'), (en, 'en')):
        source = Path('site', path.strip('/'), 'index.html') if path != '/' else Path('site/index.html')
        text = source.read_text(encoding='utf-8')
        url = f'https://www.bomts.net{path}'
        assert f'<html lang="{lang}">' in text, source
        assert f'<link rel="canonical" href="{url}">' in text, source
        assert f'<meta property="og:url" content="{url}">' in text, source
        assert f'hreflang="ko" href="https://www.bomts.net{ko}"' in text, source
        assert f'hreflang="en" href="https://www.bomts.net{en}"' in text, source
        assert f'hreflang="x-default" href="https://www.bomts.net{ko}"' in text, source

english = '\n'.join(Path('site', p.strip('/'), 'index.html').read_text(encoding='utf-8') for p in pairs.values())
for path in ('/en/product/', '/en/about/', '/en/contact/', '/en/privacy/', '/en/terms/'):
    assert f'href="{path}"' in english, path
PY

docker compose config --quiet
