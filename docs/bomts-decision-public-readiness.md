# bomts-decision 공개 전환 사전 감사

검사일: 2026-10-11  
대상: `sungbeom78/bomts-decision` (`/project/bomts-decision`)  
검사 방식: 읽기 전용, 현재 작업 트리와 모든 Git commit/blob

```ini
PUBLIC_SAFE=false
```

저장소는 여전히 **Private**이며, 이번 감사에서 공개 설정을 변경하거나 파일을 수정하지 않았다.

## 개발 시점 확인

- GitHub 저장소 생성일: 2026-04-01 (사용자가 GitHub에서 확인한 날짜)
- 로컬 전체 이력의 최초 commit: `f56db8595f560a67ede3cabf253b12a5a0aaef3c`
- 최초 commit 시각: 2026-04-01T21:19:55+09:00
- 최초 commit 제목: `chore: initial commit`

위 사실은 BOMTS가 2026년 4월에 개발 중이었다는 근거다. 현재 Private 상태이므로 제3자가 GitHub에서 직접 확인할 수 있는 공개 근거는 아직 아니다.

## 비밀 및 개인정보 검사

| 검사 | 범위 | 결과 |
|---|---|---|
| Gitleaks | 현재 추적 파일 | 탐지 0건 |
| Gitleaks | 전체 Git history | 탐지 0건 |
| TruffleHog | 현재 추적 파일 | 탐지 0건 |
| TruffleHog | 전체 Git history | 탐지 0건 |
| 추가 패턴 검사 | API key·token·password·private key | 실제 credential 탐지 없음; `.env.example`의 예제 값만 확인 |
| 환경 파일 | 전체 Git history | 실제 `.env` 없음; `.env.example`만 존재 |
| 네트워크 정보 | 전체 Git history | 사설 IPv4 탐지 0건 |
| 직접 식별정보 | 전화번호·주민번호 유사 패턴 | 탐지 0건 |

검사 결과에는 비밀 값이나 이메일 주소 원문을 기록하지 않았다.

## 공개 전 정리가 필요한 내용

1. 최초 commit에 `backup/backup_20260331_205340/` 아래 105개 파일이 들어 있다. 다음 commit에서 삭제됐지만 전체 Git history에는 남아 있으므로, 공개용 새 이력을 만들거나 이력을 정제해야 한다.
2. 현재 브랜치에 `dump.log`, `build_output.txt`, `lint_output.txt` 생성물이 추적돼 있다. `dump.log`는 데이터베이스 dump가 아니라 생성 로그지만 세 파일 모두 공개 소스에서 제외하는 편이 적절하다.
3. 의사결정 흐름, 엔진 로직, 질문·결과 bank, 가중 세션 자료 등 제품의 상세 투자 판단 로직이 포함돼 있다. 공개 가능한 제품 설명과 비공개 운영·지식재산의 경계를 소유자가 먼저 결정해야 한다.
4. 서버 이전 문서에는 서버 경로와 개인 이메일이 포함돼 있다. 공개용 문서에서는 일반화하거나 제거해야 한다.
5. commit 작성자 메타데이터에 개인 이메일 도메인이 들어 있다. 공개 전 GitHub noreply 주소 등으로 이력 메타데이터를 바꿀지 결정해야 한다.
6. `src/data/weighted_sessions.json`은 5개 생성 세션 자료이며 직접 개인정보 필드는 확인되지 않았다. 공개할 학습·평가 자료인지 별도 확인이 필요하다.

## 공개 전 권장 순서

1. 공개할 제품 코드와 전략 자료 범위를 확정한다.
2. 생성 로그·서버 이전 정보·개인 이메일을 제거하거나 일반화한다.
3. 과거 백업이 없는 공개용 새 root commit을 만들거나 전체 이력을 정제한다.
4. 정리된 후보에 Gitleaks, TruffleHog, 개인정보·내부 경로 검사를 다시 실행한다.
5. 검사 결과를 다시 보고한 뒤 사용자의 별도 승인을 받아 Public으로 전환한다.

`bomiyang-trade-system`은 이번 검사 대상에 포함하지 않았다.
