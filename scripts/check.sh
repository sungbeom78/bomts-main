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
test -f site/lecture/index.html
test -f site/lecture/assets/lecture.css
test -f site/lecture/assets/lecture.js
test -f site/lecture/assets/slide-01.png
test -f site/lecture/assets/slide-02.png
test ! -f site/lecture/assets/slide-03.png
test -f site/lecture/assets/bomts-lecture-preparation-manual.pdf
test -f site/lecture/assets/prompt-card-D2.html
test -f site/lecture/assets/slide-03-gem-01.png
test -f site/lecture/assets/slide-03-gem-02.png
test -f site/lecture/assets/slide-03-gem-03.png
test -f docs/architecture.md
test -f docs/manual/index.html
test -f docs/manual/website.html
test -f docs/manual/architecture.html
test -f docs/manual/admin.html
test -f docs/manual/lecture.html

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
grep -q 'server_name lecture.bomts.net' nginx/default.conf
grep -q 'listen 80 default_server' nginx/default.conf
grep -q 'data-slide="1"' site/lecture/index.html
grep -q 'data-slide="2"' site/lecture/index.html
grep -q 'data-slide="3"' site/lecture/index.html
grep -q 'assets/lecture.css?v=20261012-gem-links' site/lecture/index.html
grep -q '1Z70Bjg8t86v7Mh7w6-7gysei9kZTX0_j' site/lecture/index.html
! grep -q '1GDMMMpBlGVnkVhLjVy1ZvWV-rX5wLUc8' site/lecture/index.html
grep -q 'Content-Disposition.*attachment' nginx/default.conf
grep -q '1Ev3KzUNxfDWoHAZYL0TF8dn43g8t8MN2' site/lecture/index.html
grep -q '1cXKRjjBsW4kYbMhv6_AWeHqvf40a23Ek' site/lecture/index.html
grep -q '1vGOwypMsvVdzlizuallLFqNdflEhGOzQ' site/lecture/index.html
grep -q '/manual/mail.html#14' site/manage/index.html
grep -q 'Mail domains' docs/manual/mail.html
grep -q 'Enable forwarding' docs/manual/mail.html
grep -q 'Keep a copy' docs/manual/mail.html
grep -q '20261014-mail-forwarding-guide' docs/manual/index.html
grep -q 'ArrowRight' site/lecture/assets/lecture.js
grep -q 'touchend' site/lecture/assets/lecture.js
grep -q 'requestFullscreen' site/lecture/assets/lecture.js

python3 - <<'PY'
from html.parser import HTMLParser
from pathlib import Path

class LectureParser(HTMLParser):
    def __init__(self):
        super().__init__()
        self.qr_links = []
        self.downloads = []
        self.prompt_downloads = []
        self.gem_links = []
        self.active_link = None

    def handle_starttag(self, tag, attrs):
        attrs = dict(attrs)
        if tag == 'a':
            classes = attrs.get('class', '').split()
            if 'qr-link' in classes:
                self.active_link = attrs
                self.qr_links.append({'attrs': attrs, 'images': 0})
            if 'download-card' in classes:
                self.downloads.append(attrs)
            if attrs.get('href') == 'assets/prompt-card-D2.html':
                self.prompt_downloads.append(attrs)
            if 'gem-qr-link' in classes or 'gem-resource-link' in classes:
                self.gem_links.append(attrs)
        elif tag == 'img' and self.active_link is not None:
            self.qr_links[-1]['images'] += 1

    def handle_endtag(self, tag):
        if tag == 'a' and self.active_link is not None:
            self.active_link = None

parser = LectureParser()
parser.feed(Path('site/lecture/index.html').read_text(encoding='utf-8'))
assert len(parser.qr_links) == 2, parser.qr_links
assert all(item['images'] == 1 for item in parser.qr_links), parser.qr_links
assert parser.qr_links[0]['attrs'].get('target') == '_blank'
assert 'noopener' in parser.qr_links[0]['attrs'].get('rel', '')
assert parser.qr_links[1]['attrs'].get('download') == 'prompt-card-D2.html'
assert len(parser.downloads) == 1, parser.downloads
assert parser.downloads[0].get('href') == 'assets/bomts-lecture-preparation-manual.pdf'
assert 'download' in parser.downloads[0]
assert len(parser.prompt_downloads) == 2, parser.prompt_downloads
assert all(item.get('download') == 'prompt-card-D2.html' for item in parser.prompt_downloads)
assert len(parser.gem_links) == 6, parser.gem_links
assert all(item.get('target') == '_blank' for item in parser.gem_links)
assert all('noopener' in item.get('rel', '') for item in parser.gem_links)
gem_hrefs = [item['href'] for item in parser.gem_links]
assert len(set(gem_hrefs)) == 3
assert all(gem_hrefs.count(href) == 2 for href in set(gem_hrefs))

pdf = Path('site/lecture/assets/bomts-lecture-preparation-manual.pdf').read_bytes()
assert pdf.startswith(b'%PDF-')
assert pdf.rstrip().endswith(b'%%EOF')

prompt_card = Path('site/lecture/assets/prompt-card-D2.html').read_bytes()
assert len(prompt_card) == 139044
assert __import__('hashlib').sha256(prompt_card).hexdigest() == '6e2c2c96485c2c2136ee001b742f66bc2d0a21aa47884c5116ce333554d3a5a1'
assert b'localStorage' in prompt_card
PY

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
