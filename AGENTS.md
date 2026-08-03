# AGENTS.md

## 목적

이 문서는 `ssm-mobile-ios-design-system`에서 `Cursor`, `Claude`, `Codex`를 포함한 모든 AI가 공통으로 먼저 읽는 라우터다.
상세 규칙은 `docs/ai/**` 정본 문서에 둔다.

AI는 모든 문서를 미리 읽지 않는다.
먼저 이 문서로 작업 종류를 판단하고, 필요한 문서만 추가로 읽는다.

## 우선순위

- `AGENTS.md`는 전역 entrypoint이자 문서 라우팅 기준이다.
- 상세 판단은 라우팅된 `docs/ai/**` 정본 문서를 따른다.
- `CLAUDE.md`는 얇은 어댑터이며, `AGENTS.md` 또는 `docs/ai/**`와 충돌하면 정본 문서를 따른다.
- 어댑터만 수정하고 정본 문서를 그대로 두지 않는다.

## 문서 로딩 전략

1. Always: 먼저 `AGENTS.md`만 읽고 작업 종류를 판단한다.
2. Skill Entry: 사용자가 `codeReview`를 요청하면 `docs/ai/skills/code-review/SKILL.md`를 시작점으로 읽는다.
3. Plan Gate: `.ai-workspace/plans/`에 계획이 있고 작업이 그 계획의 적용 영역이면 해당 계획 문서를 먼저 읽는다.
4. Triggered: 라우팅 테이블의 조건에 맞는 문서만 추가로 읽는다.
5. Stop: 문서와 실제 코드가 충돌하면 임의로 진행하지 않고 사용자 확인을 요청한다.

## 계획 규칙

- 계획 설계와 계획 문서의 형식은 `docs/ai/contracts/plan-template.md`를 따른다.
- 계획 산출물은 `.ai-workspace/plans/`에 두며 git에 추가하지 않는다.
- 계획 설계 중 사용자가 결정해야 하는 사항이 나오면 임의로 가정하지 않고 계획 문서의 `사용자 확인 필요` 섹션에 질문으로 남긴다.
- `확인 필요: 있음`인 계획은 사용자 확인 또는 리스크 수용 기록 없이 구현 단계로 넘어가지 않는다.
- 해당 결정에 의존하지 않는 단계는 먼저 진행할 수 있고, 막혀 있는 단계는 상태 표에 남긴다.
- 특정 계획의 이름이나 경로를 `AGENTS.md`나 `docs/ai/**`에 하드코딩하지 않는다.

## 응답 헤더 규칙

- AI는 사용자에게 직접 응답할 때 기본 호칭으로 `대장`을 사용한다.
- 사용자에게 직접 답변할 때는 기본적으로 존댓말을 사용한다.
- skill entrypoint를 사용한 작업의 최종 응답 최상단에는 `🤖 사용한 Skill: <skill-name>`을 적는다.
- skill을 사용하지 않은 일반 작업에는 이 헤더를 생략할 수 있다.

## 작업 라우팅

| 요청/작업 | 먼저 읽을 문서 | 필요할 때 추가로 읽을 문서 |
| --- | --- | --- |
| 일반 코드 질문, 파일 설명 | 현재 대상 파일 | `docs/ai/reference/swift-style.md` |
| 계획, 설계, 작업 계획 작성 요청 | `docs/ai/contracts/plan-template.md`, `.ai-workspace/plans/` 기존 계획 | 대상 코드, `docs/ai/reference/project-workflow.md` |
| 진행 중인 계획의 적용 영역 작업 | 해당 `.ai-workspace/plans/*.md` | `docs/ai/contracts/plan-template.md` |
| 컴포넌트 추가/수정 | 현재 대상 파일, 기존 유사 컴포넌트 | `docs/ai/reference/swift-style.md`, `docs/ai/reference/project-workflow.md` |
| 단순 버그 수정, 빌드/테스트 오류 수정 | 현재 대상 파일과 에러 로그 | `docs/ai/reference/swift-style.md` |
| codeReview, PR/로컬 diff 리뷰 | `docs/ai/skills/code-review/SKILL.md`, `docs/ai/playbooks/code-review-playbook.md` | - |
| Swift 파일 헤더, 설명 주석, 네이밍 판단 | `docs/ai/reference/swift-style.md` | 기존 유사 Swift 파일 |
| 브랜치, PR, 빌드, 의존성 관리 판단 | `docs/ai/reference/project-workflow.md` | 실제 Package.swift |
| 신규 skill 작성 | `docs/ai/skills/new-skill/SKILL.md` | `AGENTS.md` |

## 도구별 Skill 어댑터

- Claude codeReview project skill: `.claude/skills/code-review/SKILL.md`
- Claude codeReview slash command: `.claude/commands/review.md`

## 공통 금지 항목

아래 항목은 모든 작업에 기본 적용한다.

- `DealiImageGenerated`, `DealiIconGenerated` 계열 파일 직접 수정 금지.
- generated Swift 파일 직접 수정 금지.
- 승인 없는 구조 개편 금지.
- 문자열, 이미지, 아이콘 리소스 임의 추가 금지.
- `확인 필요: 있음`인 계획을 사용자 확인 없이 구현으로 진행하는 것 금지.
- 사용자 명시 승인 없는 `git commit`, `git push`, PR 생성, merge 금지.

## 최소 종료 규칙

- 최종 응답에는 `AI 문서 영향 없음`, `AI 문서 업데이트 필요`, 또는 `AI 문서 업데이트 반영됨` 중 하나를 남긴다.
