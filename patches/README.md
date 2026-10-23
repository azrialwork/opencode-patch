# patches

Patch files (`*.patch`) in this directory are applied to the upstream
OpenCode checkout, in filename order, before building. See the main
README for how to create one.

Current series:

- `0001-remove-builtin-providers.patch` — removes all built-in providers
  and models except `opencode` (Zen); custom providers still work. See
  the main README's *Patches* section for exactly what is deleted.
- `0002-cli-tui-only.patch` — removes the Web UI (build embed, `web` /
  `serve` / `attach` commands, and the server's UI route incl. its
  `app.opencode.ai` proxy fallback) so the result is CLI + TUI only.
- `0003-remove-github-integration.patch` — removes the `opencode github`
  agent command, the `opencode pr` helper, and the GitHub-only
  (`@octokit/*`, `@actions/github`) dependencies and tests.

This file is not a patch and is ignored by `scripts/apply-patches.sh`,
which only reads `*.patch`.
