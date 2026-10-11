# Claude Startups 신청 작성 계획서

기준일: 2026-10-11

이 문서는 BOMTS의 Claude Startups 신청을 준비하기 위한 작성 원고다. 실제 제출 화면은 Claude Console 로그인 뒤 표시되므로 필드명과 혜택은 제출 직전에 다시 확인한다.

## 1. 현재 공식 안내

- 신청은 [Claude Startups](https://claude.com/programs/startups) 페이지에서 Claude Console로 로그인해 진행한다.
- 공식 페이지는 bootstrapped, pre-seed, venture-backed startup 모두 신청할 수 있다고 안내한다. VC 투자는 필수가 아니다.
- Anthropic은 현재 Claude Team 1년 및 USD 1,000 API credit offer가 수요 초과 상태라고 공지한다. 따라서 이 혜택을 확정된 것으로 신청서에 쓰지 않는다.
- Startup Stack, Applied AI office hours, 행사 등은 현재 안내되고 있으나 제공 여부는 심사와 당시 약관에 따른다.
- 심사에서는 사업 traction, 투자·funding, Claude integration·usage 등이 고려될 수 있으며 최종 결정은 Anthropic에 있다.
- API credit이 제공되더라도 first-party Claude API와 Claude Console에 적용되며 Bedrock·Vertex AI에는 적용되지 않는다.

공식 자료:

- https://claude.com/programs/startups
- https://platform.claude.com/offers/startups-application
- https://www.anthropic.com/startup-program-official-terms

## 2. 제출에 사용할 확인된 정보

| 항목 | 작성 값 | 상태 |
|---|---|---|
| Company / project name | BOMTS | 확인됨 |
| Website | https://www.bomts.net/en/ | 운영 중 |
| Company email | founder@bomts.net | 독립 Mailbox, 외부 수신 확인됨 |
| Founder | Sungbeom Ahn (안숭범) | 사용자 확인 |
| Product category | AI-assisted market decision support | 확인됨 |
| Product stage | Development / early-stage product | 제출 직전 표현 확인 |
| Primary Claude use | Market-context analysis, retrieval-augmented Q&A, structured decision summaries | 계획 확인 |

Founder background:

> Sungbeom Ahn has more than 18 years of experience in data engineering, data warehousing, ETL, and enterprise data systems. His work has focused on Informatica, Hadoop, SQL-based data platforms, and production data-processing systems. He is now building BOMTS and also works in data and AI education and development.

## 3. 제출 전 사용자가 확정해야 할 정보

다음 값은 추측해서 작성하지 않는다.

| 확인 질문 | 필요한 이유 |
|---|---|
| 법인 또는 사업자 공식 영문명은 BOMTS인가? | Company legal name |
| 설립일 또는 사업 시작일은 언제인가? | Startup stage·eligibility 질문 대응 |
| 소재 국가와 사업 주소는 무엇인가? | Company profile·terms |
| bootstrapped인가, 투자받았는가? | Funding·investor 질문 |
| 투자받았다면 투자자·accelerator·라운드·연도는? | Partner VC 및 심사 자료 |
| 현재 팀원 수는 몇 명인가? | Company size |
| Claude Console 조직을 만들었는가? 조직명은? | 신청 진입 필수 |
| 과거 Anthropic startup credit을 받은 적이 있는가? | 중복 혜택·심사 질문 |
| Claude Team을 사용 중이거나 사용한 적이 있는가? | offer eligibility 확인 |
| 현재 사용자·pilot·매출·파트너 등 공개 가능한 traction은? | 심사 설명 강화 |
| 월 예상 API 사용량과 첫 90일 목표는? | Claude integration 계획 |

## 4. 영문 작성 초안

### One-line description

> BOMTS is an AI-assisted market decision-support platform that turns market data, strategy knowledge, and risk rules into reviewable analyses and explainable decisions.

### Short product description

> BOMTS helps users examine market opportunities with a structured, evidence-based workflow. It combines market data, retrieval-augmented knowledge, predefined strategy rules, and risk controls so that each result can be reviewed rather than accepted as a black-box recommendation. The product is being built by a founder with more than 18 years of experience in enterprise data engineering, data warehousing, ETL, and production data platforms.

### How BOMTS plans to use Claude

> We plan to use the first-party Claude API for market-context analysis, retrieval-augmented question answering, structured reasoning over market and strategy data, and concise decision summaries. Claude will explain which evidence and rules support or weaken a setup, while deterministic controls and human review remain responsible for final decisions. Our initial integration will focus on grounded answers, source traceability, evaluation datasets, latency, and cost measurement before production expansion.

### Why this program would help

> The program would help BOMTS validate its Claude integration with realistic workloads, improve evaluation and prompt design, and move from an early implementation to a measured production pilot. Access to technical guidance and the startup community would be especially useful for designing reliable retrieval, explainability, and cost controls for a data-intensive product.

### Founder background

> I have more than 18 years of experience building enterprise data platforms, data warehouses, ETL pipelines, and large-scale processing systems using Informatica, Hadoop, and SQL. I am applying that experience to BOMTS, an AI-assisted market decision-support product, while continuing work in data and AI education and development.

## 5. 제출 절차

1. `founder@bomts.net`으로 수신·발신과 verification mail 수신을 확인한다.
2. 같은 주소로 Claude Console 계정을 만들거나 기존 Console 조직에 로그인한다.
3. 3절의 미확정 정보를 사용자에게 받아 표를 완성한다.
4. 제품 사이트 영문 페이지, 개인정보 안내, 이용 조건, 연락처가 공개 URL에서 열리는지 확인한다.
5. 4절 초안을 실제 입력 글자 수에 맞춰 줄이고, 구현되지 않은 기능을 현재 기능처럼 쓰지 않았는지 검토한다.
6. 신청 직전에 공식 프로그램 페이지와 약관의 날짜·혜택·지원 범위를 다시 확인한다.
7. 신청서를 제출하고 접수 화면 또는 접수 메일을 비밀정보 없이 Private 운영 기록에 남긴다.
8. `founder@bomts.net`에서 심사 결과와 추가 확인 요청을 모니터링한다.

## 6. 제출 금지·주의 사항

- Claude API 연동이 아직 검증되지 않았다면 “Powered by Claude”나 “production integration”이라고 쓰지 않는다.
- 사용자 수, 매출, 투자, 설립일, API 사용량을 추정해서 쓰지 않는다.
- API key, Console token, 메일 비밀번호, 인프라 주소를 신청 준비 문서나 Git에 기록하지 않는다.
- 투자나 credit 혜택을 확정된 사실로 표현하지 않는다.
- 금융 조언 또는 자동매매를 제공한다고 과장하지 않는다. BOMTS는 검토 가능한 의사결정 지원과 사람의 최종 판단을 강조한다.

## 7. 제출 완료 기준

- 모든 필수 필드가 실제 사실로 채워져 있다.
- `founder@bomts.net` verification mail을 수신할 수 있다.
- Claude Console 조직과 신청 주체가 일치한다.
- 영문 설명이 현재 구현 범위를 넘지 않는다.
- 신청 직전 공식 페이지와 약관을 다시 확인했다.
- 제출 접수 증거와 후속 조치 담당자가 정해져 있다.
