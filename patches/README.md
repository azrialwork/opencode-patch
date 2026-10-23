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
- `0006-remove-share.patch` — removes session sharing: the
  `SessionShare` service, the `/session/{id}/share` endpoints, the
  session `share` field and `share_url` storage column, the `share` /
  `autoshare` config keys, `OPENCODE_AUTO_SHARE`, the TUI share
  keybinds/sidebar URL, and the SDK share client/types.
- `0007-remove-upgrade-uninstall.patch` — removes the self-update /
  self-uninstall machinery: the `upgrade` and `uninstall` commands,
  the `Installation` service, the `/global/upgrade` endpoint, the TUI
  `/update` flow and update notices, the `autoupdate` config keys,
  and `OPENCODE_DISABLE_AUTOUPDATE`.
- `0008-remove-opentelemetry.patch` — removes OpenTelemetry: the OTLP
  exporters, the `@opentelemetry/*` / `@effect/opentelemetry`
  dependencies, the AI SDK telemetry tracer plumbing, the
  `experimental.openTelemetry` config key, and the `OTEL_*` flags.
- `0009-remove-import.patch` — removes the `opencode import` command
  (session JSON import) and its tests.
- `0010-remove-photon-image.patch` — removes the Photon image
  pipeline (`@silvia-odwyer/photon-node`, both image services, the
  image attachment config keys); images pass through unmodified.

This file is not a patch and is ignored by `scripts/apply-patches.sh`,
which only reads `*.patch`.
