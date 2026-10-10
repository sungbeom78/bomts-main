# Public policy missing inputs

- 실패: unit_or_regression/qa_quick `mail` missing, encoding `mail`·`plan` missing.
- 시스템: scripts/check.sh 자체는 exit 0, 프레임워크 검사는 missing input 때문에 receipt를 인정하지 않음.
- 최근 변경: Private-history 작업 트리의 project.policy.yaml을 clean Public clone에 복사함.
- 데이터: DB·로그·메일 데이터 변화 없음. 카탈로그의 service_policy가 `mail/address-policy.yaml`을 참조하지만 Public clone에는 mail/이 없었음.
- 검색: origin/main tree에는 mail/·plan/ 없음. 현재 공개에 필요한 것은 비밀 없는 mail 정책 3개 파일이며 plan 원문은 검사 입력에 필요하지 않음.
- 원인: own_change.
- 조치: 감사 완료된 public mail/ 정책을 복사하고 check_inputs.encoding에서 없는 plan을 제거.
