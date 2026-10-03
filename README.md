# record-demo-kit

A [Claude Code](https://claude.com/claude-code) plugin that records a feature working in your web app and turns it into a polished demo video in **your** brand.

Playwright drives your real app and captures it; [HyperFrames](https://www.npmjs.com/package/hyperframes) renders the result with your logo, colors and fonts. Three formats:

- **walkthrough** (default): 1920x1080 with a chapter rail, intro and outro. For PRs, team chat and hero videos.
- **clip**: a clean, zoomed 1440x900 clip that follows the action. For changelogs and docs, where the video is shown small.
- **launch**: a silent launch film of 45 s or less for LinkedIn, X or your site: one continuous camera over a light canvas, kinetic titles, a result card, your logo in the opener and outro.

## Install

In Claude Code:

```
/plugin marketplace add maxMyers13/record-demo-kit
/plugin install record-demo@record-demo-kit
```

You also need Node 22+, ffmpeg with libx264 (`brew install ffmpeg` on macOS), and Playwright in the repo of the app you're recording:

```bash
npm i -D playwright && npx playwright install chromium
```

The first render downloads the pinned HyperFrames CLI and a headless Chrome (~150 MB, cached) plus GSAP.

## Add your brand

Out of the box, videos use a neutral **Example** brand. To use yours:

```bash
KIT=$(ls -1d ~/.claude/plugins/cache/record-demo-kit/record-demo/*/demo-kit | sort -V | tail -1)
node "$KIT/scripts/init-brand.mjs" --name "Acme"      # creates ~/.config/record-demo/brand
```

Then, in `~/.config/record-demo/brand/`:

1. Replace `logo-on-dark.svg` and `logo-on-light.svg` (and `mark.svg`, a small square icon) with your logos, or point `brand.json` at your own file names.
2. Set your colors in `tokens.css`. Keep the variable names; change the values.
3. Put your font files in `fonts/` and update `fonts.css`. Fonts must be local files (renders run offline).
4. Check it: `node "$KIT/scripts/selftest.mjs" --quick`.

Your pack lives outside the plugin, so updates never overwrite it. To keep several brands, point `DEMO_BRAND_DIR` at the one you want. Full details: [`demo-kit/README.md`](plugins/record-demo/demo-kit/README.md#brand-packs).

## Use

Start your app's dev server, then in Claude Code from your app's repo:

```
/record-demo team invites flow
/record-demo shared doc editing seats=2
/record-demo settings page format=launch url=http://localhost:5173
/record-demo onboarding checklist format=clip for PR #42
```

Claude writes a storyboard, rehearses the flow, records it, renders it, checks the frames, and saves the video to `~/Documents/Demos/features/`. The full procedure it follows is [`commands/record-demo.md`](plugins/record-demo/commands/record-demo.md).

You can also use the kit without Claude: see the scripts and worked examples in [`demo-kit/`](plugins/record-demo/demo-kit/).

## License

MIT. The bundled example fonts (Poppins, JetBrains Mono) are under the SIL Open Font License. GSAP is downloaded on first use under [GreenSock's license](https://gsap.com/standard-license), not redistributed here.
