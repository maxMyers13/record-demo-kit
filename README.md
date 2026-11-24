# record-demo-kit

An agent skill that records a feature working in your web app and turns it into a polished demo video in **your** brand. It works in **Claude Code, Codex, Cursor, GitHub Copilot and Antigravity** (and Gemini CLI): one `SKILL.md` in the open [Agent Skills](https://agentskills.io) format, with the kit bundled beside it.

<p align="center">
  <a href="docs/demo.mp4"><img src="docs/demo.gif" width="360" alt="A launch-format demo video made with one /record-demo command"></a>
</p>

<p align="center"><sub>A <code>format=launch</code> video of a feedback form, made with one <code>/record-demo</code> command. <a href="docs/demo.mp4">Watch the MP4</a>.</sub></p>

Playwright drives your real app and captures it; [HyperFrames](https://www.npmjs.com/package/hyperframes) renders the result with your logo, colors and fonts. Three formats:

- **walkthrough** (default): 1920x1080 with a chapter rail, intro and outro. For PRs, team chat and hero videos.
- **clip**: a clean, zoomed 1440x900 clip that follows the action. For changelogs and docs, where the video is shown small.
- **launch**: a silent launch film of 45 s or less for LinkedIn, X or your site: one continuous camera over a light canvas, kinetic titles, a result card, your logo in the opener and outro.

## Install

One command installs the skill for every agent you have:

```bash
npx skills add maxMyers13/record-demo-kit -g
```

It asks which agents to install for (`-a '*' -y` picks all of them without asking; drop `-g` to install into the current repo only). This is where the skill lands and how you call it:

| Agent | Installed to | How to call it |
|---|---|---|
| Claude Code | `~/.claude/skills/record-demo` | `/record-demo team invites flow` |
| Codex | `~/.agents/skills/record-demo` | `$record-demo team invites flow` |
| Cursor | `~/.agents/skills/record-demo` | `/record-demo team invites flow` |
| GitHub Copilot | `~/.agents/skills/record-demo` | `/record-demo team invites flow` |
| Antigravity | `~/.gemini/config/skills/record-demo` | ask: "record a demo of the team invites flow" |
| Gemini CLI | `~/.agents/skills/record-demo` | ask: "record a demo of the team invites flow" |

In every agent you can also just ask in plain words ("record a demo of ..."): the agent picks the skill from its description.

**Claude Code plugin** (instead of the command above, if you prefer plugins):

```
/plugin marketplace add maxMyers13/record-demo-kit
/plugin install record-demo@record-demo-kit
```

**Any other agent, or no installer:** clone this repo and tell the agent to read `skills/record-demo/SKILL.md` and follow it. The skill finds its kit from the clone.

You also need macOS or Linux, Node 22+, ffmpeg with libx264 (`brew install ffmpeg` on macOS), and Playwright in the repo of the app you're recording:

```bash
npm i -D playwright && npx playwright install chromium
```

The first render downloads the pinned HyperFrames CLI and a headless Chrome (~150 MB, cached) plus GSAP.

## Add your brand

Out of the box, videos use a neutral **Example** brand. To use yours, ask your agent to "set up my record-demo brand pack", or do it by hand:

```bash
KIT=$(bash ~/.agents/skills/record-demo/demo-kit/scripts/resolve-kit.sh)   # Claude Code only: ~/.claude/skills/...
node "$KIT/scripts/init-brand.mjs" --name "Acme"      # creates ~/.config/record-demo/brand
```

Then, in `~/.config/record-demo/brand/`:

1. Replace `logo-on-dark.svg` and `logo-on-light.svg` (and `mark.svg`, a small square icon) with your logos, or point `brand.json` at your own file names.
2. Set your colors in `tokens.css`. Keep the variable names; change the values.
3. Put your font files in `fonts/` and update `fonts.css`. Fonts must be local files (renders run offline).
4. Check it: `node "$KIT/scripts/selftest.mjs" --quick`.

Your pack lives outside the skill, so updates never overwrite it, and every agent uses the same one. To keep several brands, point `DEMO_BRAND_DIR` at the one you want. Full details: [`demo-kit/README.md`](skills/record-demo/demo-kit/README.md#brand-packs).

## Use

Start your app's dev server, then call the skill from your app's repo (Claude Code, Cursor and Copilot syntax shown; see the table for the others):

```
/record-demo team invites flow
/record-demo shared doc editing seats=2
/record-demo settings page format=launch url=http://localhost:5173
/record-demo onboarding checklist format=clip for PR #42
```

The agent writes a storyboard, rehearses the flow, records it, renders it, checks the frames, and saves the video to `~/Documents/Demos/features/`. The full procedure it follows is [`skills/record-demo/SKILL.md`](skills/record-demo/SKILL.md).

You can also use the kit without an agent: see the scripts and worked examples in [`demo-kit/`](skills/record-demo/demo-kit/).

## License

MIT, see [`LICENSE`](LICENSE).

Third-party files bundled in this repository keep their own licenses:

- skills/record-demo/demo-kit/brand/fonts/poppins-*.woff2 — SIL Open Font License 1.1 (fonts/OFL-Poppins.txt)
- skills/record-demo/demo-kit/brand/fonts/jetbrains-mono-latin.woff2 — SIL Open Font License 1.1 (fonts/OFL-JetBrainsMono.txt)

GSAP is not included; the kit downloads it from jsDelivr on first use, under GreenSock's own license (https://gsap.com/standard-license).
