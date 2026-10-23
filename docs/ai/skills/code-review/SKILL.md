---
name: codeReview
description: Reviews PRs, local diffs, or selected files in the design system. Finds architecture violations, runtime/security risks, and scope issues without modifying code.
---

# Code Review Skill

## 읽기

1. `AGENTS.md`
2. `docs/ai/playbooks/code-review-playbook.md`
3. 리뷰 대상 diff, PR, 또는 지정 파일
4. `AGENTS.md` 라우팅에 따라 필요한 reference

## 시작 조건

- 리뷰할 diff, PR 기준, 또는 파일이 있다.
- 기준이 없으면 먼저 리뷰 범위를 확인한다.

## 규칙

- 코드를 수정하지 않는다.
- PR 리뷰 기본 비교 기준은 `origin/dev`다.
- 결과는 한국어로 쓰고, findings를 먼저 쓴다.
- 발견 이슈는 `이슈 1`, `이슈 2`처럼 번호를 붙이고 재리뷰에서도 번호를 유지한다.
- 각 이슈에는 `권장 수정 방향`을 포함한다.
- 코드로 설명할 수 있는 수정은 반드시 `As-Is` / `To-Be` 코드 블럭을 제공한다.
- severity, 체크 항목, 출력 형식은 `docs/ai/playbooks/code-review-playbook.md`를 따른다.
