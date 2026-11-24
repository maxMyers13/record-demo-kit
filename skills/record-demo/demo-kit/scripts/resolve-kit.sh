#!/usr/bin/env bash
# resolve-kit.sh — print the absolute path of the demo-kit directory, or exit 1.
# The kit ships inside the record-demo skill folder, so it lives wherever the agent installed that skill.
# Probe order: $DEMO_KIT_DIR, this script's own kit, project skill folders, user skill folders,
# a Claude Code plugin install, a clone of the repo.
S=skills/record-demo/demo-kit
probe() { [ -n "$1" ] && [ -f "$1/kit.json" ] && { (cd "$1" && pwd -P); exit 0; }; }
probe "${DEMO_KIT_DIR:-}"
[ -z "${DEMO_KIT_NO_SELF:-}" ] && probe "$(cd "$(dirname "$0")/.." 2>/dev/null && pwd -P)"
root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
for base in "$root" "$HOME"; do
  for agent in .agents .claude .cursor .github .copilot .codex .gemini .gemini/config .gemini/antigravity .gemini/antigravity-ide .agent; do
    probe "$base/$agent/$S"
  done
done
newest="$(find "$HOME/.claude/plugins/cache/record-demo-kit" -path "*/$S/kit.json" 2>/dev/null | sort -V | tail -1)"
[ -n "$newest" ] && probe "$(dirname "$newest")"
probe "$root/$S"
exit 1
