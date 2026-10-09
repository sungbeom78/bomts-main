#!/bin/sh
set -eu

test "$(git rev-parse :dev-process-framework)" = "$(git -C dev-process-framework rev-parse HEAD)"
test -z "$(git -C dev-process-framework status --porcelain)"

test -L .agents/skills/sk-dev-lifecycle
test -L .agents/skills/sk-dev-user-manual
test -L .claude/skills/sk-dev-lifecycle
test -L .claude/skills/sk-dev-user-manual

test "$(readlink .agents/skills/sk-dev-lifecycle)" = "../../dev-process-framework/skills/sk-dev-lifecycle"
test "$(readlink .claude/skills/sk-dev-lifecycle)" = "../../dev-process-framework/skills/sk-dev-lifecycle"

grep -q 'manual-review' AGENTS.md
grep -q '^dist/manual-review/$' .gitignore

printf '%s\n' 'dev-process-framework gitlink, installed skills, and generated policy files are synchronized.'
