# Google Search Console 등록

BOMTS 공개 사이트의 sitemap URL은 다음과 같습니다.

```text
https://www.bomts.net/sitemap.xml
```

## 등록 절차

1. [Google Search Console](https://search.google.com/search-console/)에서 `https://www.bomts.net/` URL 접두어 속성을 추가합니다.
2. Google이 제공하는 방법으로 소유권을 확인합니다. DNS TXT 방식을 사용한다면 Cloudflare DNS에 Google이 제공한 값을 등록합니다. 검증 토큰은 저장소에 기록하지 않습니다.
3. Search Console의 **Sitemaps** 메뉴에서 `sitemap.xml`을 입력하고 제출합니다.
4. 제출 결과가 성공인지 확인하고, **URL 검사**에서 `/`, `/en/`, `/about/`, `/en/about/`을 검사합니다.
5. 페이지를 수정한 뒤에는 sitemap이 계속 HTTP 200인지 확인하고 필요한 URL만 색인 생성을 요청합니다.

## 공개 상태 확인

```bash
curl -fsS https://www.bomts.net/robots.txt
curl -fsS https://www.bomts.net/sitemap.xml
```

`robots.txt`에는 sitemap URL이 있어야 하며, sitemap에 한글·영문 공개 페이지가 모두 포함되어야 합니다.
