# 공유 컴포넌트 수정 요청

이 프로젝트에서 dev-process-framework 나 공통 용어사전 시스템을 **직접 고치지 않는다.** 필요한 점을 여기 적으면
소유자가 원본 저장소(sungbeom78/dev-process-framework, sungbeom78/bomiyang-glossary)에서 처리한다.

<!-- - YYYY-MM-DD [framework|glossary] 무엇이 문제인가 / 원하는 변경 / 관련 작업 id -->

- 2026-10-14 [framework] `update_framework.py`가 `dev-process-framework`를 `f010502`로 올린 뒤
  중첩 `glossary`를 프레임워크 gitlink `68e85fc`에 맞추지 않아 기존 checkout `2f3aa5a`가
  로컬 변경으로 남는다. `_nested()`가 `data-expert-framework`뿐 아니라 프레임워크가 고정한 모든
  중첩 서브모듈을 안전하게 동기화하고, 업데이트 직후 `git -C dev-process-framework status --porcelain`이
  비어 있는지 검사해 실패를 보고하도록 요청한다. 관련 작업: `20261014-framework-update`, 사건:
  `framework-nested-glossary-pin-mismatch`.
