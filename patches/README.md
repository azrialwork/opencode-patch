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
- `0004-remove-lsp.patch` — removes LSP entirely: the language-server
  subsystem and downloads, the `lsp` tool, post-edit diagnostics, the
  `lsp` config keys (V1 + V2), the `/lsp` and `/find/symbol` endpoints,
  the TUI LSP displays, the SDK LSP client/types, and the
  `vscode-jsonrpc` / `vscode-languageserver-types` dependencies.
- `0005-remove-acp.patch` — removes ACP (Agent Client Protocol): the
  `opencode acp` command, the `src/acp/` implementation, the
  `@agentclientprotocol/sdk` dependency, and the ACP tests.

This file is not a patch and is ignored by `scripts/apply-patches.sh`,
which only reads `*.patch`.
