---
name: new-skill
description: Creates, updates, or standardizes repo-local AI skills for ssm-mobile-ios-design-system. Keeps SKILL.md thin and updates shared references as needed.
---

# New Skill

## 읽기

1. `AGENTS.md`
2. 기존 `docs/ai/skills/*/SKILL.md`
3. 필요 시 `.claude/skills`, `.claude/commands`

## 규칙

- `SKILL.md`는 얇은 entrypoint로 유지한다.
- 긴 규칙은 playbook/reference로 분리한다.
- 새 skill은 `docs/ai/skills/<skill-name>/SKILL.md`에 둔다.
- Claude에서 네이티브 project skill로 써야 하면 `.claude/skills/<skill-name>/SKILL.md`에 얇은 어댑터를 둔다.
- Claude slash command가 필요하면 `.claude/commands/<skill-name>.md`에 얇은 명령 어댑터를 둔다.
- 이름은 lowercase hyphen을 기본으로 한다.
- 호출명/경로 변경은 `AGENTS.md`, `CLAUDE.md`와 맞춘다.
- 새 skill의 `.claude/skills/<skill-name>/SKILL.md` frontmatter `description`에 자연어 트리거 문장을 포함한다.

## 금지

- 긴 플레이북을 `SKILL.md`에 중복하지 않는다.
- 기존 skill로 충분한 작업을 새 skill로 만들지 않는다.
