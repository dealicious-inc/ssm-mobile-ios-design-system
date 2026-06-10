# CLAUDE.md

이 파일은 Claude용 얇은 어댑터다.
`AGENTS.md`는 문서 라우터이며, 상세 규칙의 source of truth는 `docs/ai/**`다.
Claude는 이 파일을 읽은 뒤 `AGENTS.md`를 먼저 읽고, 작업 종류에 맞는 정본 문서만 추가로 읽는다.

## Bootstrap Gate

- 어떤 작업도 `AGENTS.md`를 읽기 전에는 시작하지 않는다.
- `AGENTS.md`를 읽을 수 없거나 읽었는지 불확실하면 진행하지 않고 다시 읽는다.
- context compaction, 긴 대화, 세션 재개 후에는 `AGENTS.md`를 다시 읽고 라우팅을 확인한다.

## 적용 기준

- 전역 공통 규칙, 금지사항, 문서 라우팅은 `AGENTS.md`를 따른다.
- `codeReview` 요청은 `AGENTS.md`의 Skill Entry 라우팅을 따른다.
- Claude project skill이나 slash command는 얇은 entrypoint로만 사용한다.
- 이 파일과 `AGENTS.md` 또는 `docs/ai/**`가 충돌하면 `AGENTS.md`와 `docs/ai/**`를 우선한다.
- 상세 규칙을 이 파일에 중복 추가하지 않는다.
