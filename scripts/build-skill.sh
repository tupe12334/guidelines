#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
RULES_DIR="$ROOT/rules"
SKILLS_DIR="$ROOT/skills/coding-guidelines"
PLUGIN_DIR="$ROOT/.claude-plugin"

mkdir -p "$SKILLS_DIR" "$PLUGIN_DIR"

# 1. Build SKILL.md
{
  cat <<'FRONTMATTER'
---
name: coding-guidelines
description: Apply project coding guidelines: input validation, error handling, DDD structure, type safety, testing, and more. Invoke when writing or reviewing code.
version: 0.1.0
---

# Coding Guidelines

Apply these rules when writing or reviewing code.

FRONTMATTER

  for f in "$RULES_DIR"/*.md; do
    title=$({ grep '^# ' "$f" || true; } | head -1 | sed 's/^# //')
    body=$({ grep -v '^#' "$f" || true; } | sed '/^[[:space:]]*$/d')
    [[ -z "$title" && -z "$body" ]] && continue
    [[ -z "$title" ]] && title="$(basename "$f" .md)"
    printf '## %s\n\n%s\n\n' "$title" "$body"
  done
} > "$SKILLS_DIR/SKILL.md"

# 2. Build plugin.json
cat > "$PLUGIN_DIR/plugin.json" <<'EOF'
{
  "$schema": "https://anthropic.com/claude-code/plugin.schema.json",
  "name": "guidelines",
  "description": "Coding guidelines skill covering input validation, error handling, DDD structure, type safety, testing, and more.",
  "author": {
    "name": "tupe12334"
  }
}
EOF

# 3. Update marketplace.json with current SHA
SHA=$(git -C "$ROOT" rev-parse HEAD)
RULE_COUNT=$(ls "$RULES_DIR"/*.md | wc -l | tr -d ' ')

cat > "$PLUGIN_DIR/marketplace.json" <<EOF
{
  "\$schema": "https://anthropic.com/claude-code/marketplace.schema.json",
  "name": "guidelines",
  "description": "Coding guidelines plugin: rules for input validation, error handling, DDD structure, type safety, testing, and more.",
  "owner": {
    "name": "tupe12334"
  },
  "plugins": [
    {
      "name": "guidelines",
      "description": "Coding guidelines skill: $RULE_COUNT rules covering validation, error handling, DDD, type safety, and more.",
      "author": {
        "name": "tupe12334"
      },
      "category": "productivity",
      "source": {
        "source": "git-subdir",
        "url": "https://github.com/tupe12334/guidelines.git",
        "path": ".",
        "ref": "main",
        "sha": "$SHA"
      },
      "homepage": "https://github.com/tupe12334/guidelines"
    }
  ]
}
EOF

echo "Built: $SKILLS_DIR/SKILL.md ($RULE_COUNT rules)"
echo "Built: $PLUGIN_DIR/plugin.json"
echo "Built: $PLUGIN_DIR/marketplace.json (sha: ${SHA:0:7})"
