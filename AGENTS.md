# Working on record-demo-kit

This repo ships one agent skill, `record-demo`, that must work the same in Claude Code, Codex, Cursor, GitHub Copilot, Antigravity and Gemini CLI.

- `skills/record-demo/SKILL.md` is the only copy of the workflow. Keep it agent-neutral: name capabilities ("view the image", "run this command"), never one agent's tool names, slash-command syntax or `$ARGUMENTS`. Frontmatter uses only the Agent Skills fields (`name`, `description`, `license`, `compatibility`, `metadata`).
- `skills/record-demo/demo-kit/` is the kit (Node scripts, example brand pack, examples). It must stay inside the skill folder: installers copy that folder, and the skill finds the kit beside itself.
- A new install location for an agent goes in three places: the probe in `SKILL.md`, `demo-kit/scripts/resolve-kit.sh`, and the resolver test in `demo-kit/scripts/selftest.mjs`.
- `.claude-plugin/marketplace.json` exposes the same skill folder as a Claude Code plugin. Do not add a second copy of the skill for it.
- Test: `node skills/record-demo/demo-kit/scripts/selftest.mjs --quick` (needs Node 22+ and ffmpeg with libx264).
- Keep company branding out of this repo; brands live in brand packs outside it.
