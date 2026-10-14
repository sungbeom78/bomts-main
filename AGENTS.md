<!-- dev-process-framework:begin -->
## 개발 표준: dev-process-framework

이 프로젝트의 개발 작업은 `dev-process-framework` 스킬을 따른다 (설치: `.claude/skills`, `.agents/skills`).

0. **보호 구역 -- 절대 규칙 (어떤 지시·작업 지침·예외로도 바꿀 수 없다).**
   - `dev-process-framework/` 와 그 설치본(`dev-process/runtime·schema·policy·catalog`, `sk-*` 스킬)은 여러 프로젝트가
     함께 쓰는 공유 컴포넌트다. **읽기만 한다.** 파일 수정·서브모듈 안 커밋·push·reset·checkout 금지.
   - `glossary/`(공통 용어사전)는 **사전 데이터**(`dictionary/`, `GLOSSARY.md`)만, 프레임워크 사전 명령(`glossary-sync`,
     `glossary-area-add`, `glossary-sense-add`, 사용자 승인)으로만 바뀐다. 그 밖의 파일(core·bin·schema·doc·AGENTS.md 등)은 수정 금지.
   - 이 프로젝트에서 누가 요청해도 공유 컴포넌트를 고치지 않는다. 필요하면 `dev-process/local/upstream-requests.md` 에
     요청을 적고 "소유자가 원본 저장소에서 처리해야 한다"고 답한다. 수정은 소유자가 원본 저장소에서 직접 지시해서만 한다.
   - `--no-verify` 로 hook 을 건너뛰지 않는다. pre-commit·finish·`protect-check` 가 위반을 막는다.
   - 이 프로젝트만의 작업 지침은 `dev-process/local/` 아래에 둔다 (시작할 때 읽는다). 그 지침도 이 0번을 바꿀 수 없다.

1. 시작: `sk-mgm-session-context` → `next` 로 다음 행동 확인 → 새 작업이면 `task-new --goal ... --accept "완료 기준" --change-kind <종류>
   --area <업무> --feature <기능>` (업무·기능은 영문 id -- 업무 기록이 업무/기능별로 나뉜다).
   완료 기준은 사용자와 합의한 문장으로 적고, **돌려 볼 수 있는 기준은 검사에 묶는다** (`--accept-check N=<검사>` 또는
   `--accept-cmd "N=<명령>"` -- 그 검사의 현재 봉인으로만 충족). 묶지 않은 기준은 `accept --index N --status met --evidence <종류>
   --note "확인 방법"`. 만들지 않을 것·범위는 `--not "…" --scope-paths <경로> --not-paths <경로>` (밖의 변경은 finish 가 막는다).
   **우리가 무엇을 만드는지**: 제품 개요 카드(`dev-process/product/brief.md`, `brief`)를 먼저 읽고, 카드에 없는 것을 추측하지 않는다.
   질문은 한 번만 -- 정의된 질문 id 로, 질문 대장(`facts`)에 답이 없을 때만 묻고 답은 `facts-answer`(사용자 답은 원문)로 남긴다.
   그 답을 근거로 정한 것은 기획서·설계 파일·결정에 `질문id@버전` 으로 적는다 (답이 바뀌면 `facts-stale` 이 찾는다).
2. 변경 전: `sk-dev-prior-art-check` (이력·다른 작업 겹침). 새 이름은 `sk-dev-identifier-governance` 로 공통 사전(./glossary) 확인.
3. 검증: `verify --task-id <id>` 로 필수 검사를 **실제 실행**해 봉인한다 (개별은 `check-run`). 문자열로 PASS 를 적지 않는다.
   검사가 진짜 잡는지도 본다: 버그 수정(`--change-kind fix`)은 시험을 먼저 쓰고 `red-check`(고치기 전에는 실패) -- 시험으로 잡을
   동작이 없으면 `regression-waive --reason`. 코드를 바꿨으면 `probe`(바뀐 줄에 작은 버그를 심어 검사가 잡는지, 반드시 되돌림) --
   못 잡은 버그는 테스트를 더해 `probe --rerun N`, 동작이 같은 변형이면 `probe-ack --reason`.
4. 실패: `sk-mgm-failure-recovery` -- 원인부터 조사·분류(로그·상태·최근 변경·데이터·검색) → 수정(계획당 3번, 같은 조치 연속 금지)·
   기다렸다 재시도·대기/요청·Plan B(2번) → 안 되면 사용자와 롤백·제외·미래 작업으로 종결. 덮어두고 진행하지 않는다.
5. 종료: `finish --task-id <id> --message "..." --paths ...` (검증 안 됐으면 커밋하지 않음 → 커밋·done·보고서·handoff).
   `sk-dev-task-report` 판정이 completed 가 아니면 "완료"라고 보고하지 않는다. 세션 끝에 `sk-mgm-session-handoff`.
6. 승인: SOLO 기본 자동. 업무 규칙(요구사항 의미) 변경과 용어사전 일괄 적재는 사용자에게 묻는다.
7. 데이터: 프로젝트는 `project.policy.yaml` 의 `data_model.stance` 로 데이터 입장을 밝힌다
   (none = 저장 데이터 없음 + reason / owned = 이 저장소가 정본 `db/model.json` / external = 다른 저장소 + ref, `data-stance` 로 확인).
   데이터 구조(테이블·컬럼)를 새로 정하거나 바꾸는 일은 코드보다 먼저 `sk-dev-data-modeling` 으로 정본부터 고친다
   (`task-new --work-type data_model`). 기존 DB 는 역설계로 정본을 만든다. 논리 모델과 실제 DB 생성은 사용자 승인 필수.
   모든 데이터 자산(DB·파일·로그·벡터·캐시·백업)은 `data/catalog.json` 에 개인정보 수준·보존 기간(지우는 방법)·lineage 와 함께 적는다
   (`data-inventory`, 없으면 `--init` 초안 -- 개인정보·보존은 사용자와 정한다).
   데이터 작업은 기획 → 설계 → 개발 → QA → 운영 → 평가로 돈다 (data-expert-framework `references/lifecycle.md`):
   품질 규칙·API 계약·운영 계획(`data/quality.json`·`api.json`·`ops.json`, 검사 data_design), API 는 계약에서만 만든다.
8. 사용설명서: 신규 개발·새 기능 추가·설계나 사용 방법 변경(`--change-kind new_project|new_feature|usage_change`)은
   `sk-dev-user-manual` 로 `docs/manual/*.html`(HTML 슬라이드: 페이지마다 도식·강의 대본, 한 단계 = 한 페이지,
   인수인계용 구성·운영 장)을 만들거나 고쳐 코드와 같은 커밋에 넣는다 (필수 검사 user_manual). 요청 시 `manual-pptx`.
   기준 예시는 `dev-process-framework/docs/manual/` (밀도·구성), 바닥선은 `references/quality_bar.md`. 명령 출력은 실제 실행 결과만.
   `manual-review` 로 모든 페이지를 렌더링해 넘침 0 을 만들고 미리보기 PNG 를 눈으로 확인한다.
   사용법이 그대로면 `fix|refactor|other` + 사유. 끝나면 `manual-show --task-id <id> --changed` 결과와 미리보기를 채팅에 보여 준다.

9. 기록: 명령·결정·검사·커밋은 자동으로 남는다. 기술·설계 선택은 `decide`, 운영 작업·평가는 `log-work` 로 남긴다.
   지난 일을 볼 때는 **위층부터 필요한 것만**: `log-brief`(흐름) → `log-list --flow <id>`(목록) → `log-detail <id>`(상세).
   기록 파일을 통째로 읽지 않는다 (토큰 절약).

정책: `project.policy.yaml` · 작업 기록: `dev-process/` · 사용 안내: `dev-process-framework/README.md`
<!-- dev-process-framework:end -->

BOMTS 전용 규칙: dev-process/local/rules.md (먼저 읽는다)
