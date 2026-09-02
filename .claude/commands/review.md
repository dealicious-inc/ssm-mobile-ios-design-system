---
description: "디자인 시스템 코드 리뷰"
argument-hint: "[PR번호, 브랜치, diff 범위, 파일]"
allowed-tools: ["Bash", "Glob", "Grep", "Read"]
---

# Review

Claude에서 `/review`로 PR, 로컬 diff, 특정 파일을 리뷰할 때 사용하는 얇은 명령 어댑터다.
상세 코드 리뷰 기준의 source of truth는 `docs/ai/playbooks/code-review-playbook.md`다.

## 실행 규칙

1. `AGENTS.md`를 읽는다.
2. `AGENTS.md`를 읽을 수 없거나 읽었는지 불확실하면 진행하지 않는다.
3. `.claude/skills/code-review/SKILL.md`를 skill entrypoint로 사용한다.
4. 사용자의 리뷰 요청은 `$ARGUMENTS`로 해석한다.
5. 코드는 수정하지 않는다.
6. 결과 최상단에는 `🤖 사용한 Skill: codeReview`를 적는다.

## 사용자 요청

```text
$ARGUMENTS
```
