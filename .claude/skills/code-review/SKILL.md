---
name: codeReview
description: Review ssm-mobile-ios-design-system PRs, local diffs, or selected files without modifying code.
---

# Code Review Skill

이 파일은 Claude project skill용 얇은 어댑터다.
Code Review 규칙의 source of truth는 `docs/ai/skills/code-review/SKILL.md`다.

## 읽기

1. `AGENTS.md`
2. `docs/ai/skills/code-review/SKILL.md`
3. `docs/ai/playbooks/code-review-playbook.md`

## 규칙

- `AGENTS.md`를 읽을 수 없거나 읽었는지 불확실하면 진행하지 않는다.
- 코드를 수정하지 않는다.
- PR 리뷰 기본 비교 기준은 `origin/dev`다.
- 결과 최상단에는 `🤖 사용한 Skill: codeReview`를 적는다.
- findings를 먼저 쓰고, 요약은 뒤에 짧게 둔다.
- 상세 규칙은 `docs/ai/skills/code-review/SKILL.md`와 `docs/ai/playbooks/code-review-playbook.md`를 따른다.
