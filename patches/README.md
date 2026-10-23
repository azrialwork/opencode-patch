English · [Bahasa Indonesia](README.id.md)

# The list of cuts

In the storybook, the tailor keeps a short list of opinions, and this
folder is that list, written down properly. Every file here whose
name ends in `.patch` is one cut recipe. When a robot is built, the
builders read this list from number 1 to number 13, in order, and
make every cut on a fresh copy of upstream OpenCode.

One rule matters more than the rest: if a recipe does not fit, the
build stops and nothing is shipped.

For the same list told as a story, read the [storybook](../README.md).

## The recipes

**1. `0001-remove-builtin-providers.patch` — the giant toy fair closes.**
Every built-in provider and its models are deleted, along with the
provider SDK packages, the custom loaders, and the built-in auth
plugins. The models.dev catalogue is cut down to a single entry,
`opencode` (Zen), at the data source itself — in the build-time
embed, the on-disk cache, and the runtime fetch. Custom providers
defined in `opencode.json` keep working.

**2. `0002-cli-tui-only.patch` — the windows come out.**
The Web UI is removed at the root: the build no longer builds or
embeds the web app, the `web`, `serve`, and `attach` commands are
deleted, and the HTTP server's catch-all UI route is deleted together
with its fallback that proxied the UI from `app.opencode.ai`. The
in-process server the TUI uses internally stays.

**3. `0003-remove-github-integration.patch` — the octopus goes home.**
The `opencode github` agent command and the `opencode pr` helper are
deleted, together with the GitHub-only helper `parseGitHubRemote` and
the GitHub-only dependencies (`@actions/github`, `@octokit/graphql`,
`@octokit/rest`, `@octokit/webhooks-types`) and their tests. Plain
git support is untouched.

**4. `0004-remove-lsp.patch` — the language teacher retires.**
LSP is removed entirely: the language-server subsystem and its binary
downloads, the `lsp` tool, the diagnostics whispered after every edit,
the `lsp` config keys in both schemas, the `/lsp` and `/find/symbol`
endpoints, the LSP displays in the TUI, the SDK's LSP client and
types, and the `vscode-jsonrpc` / `vscode-languageserver-types`
dependencies. Formatters are a different subsystem and stay.

**5. `0005-remove-acp.patch` — the translator plug is pulled.**
The `opencode acp` command and the whole `src/acp/` implementation
are deleted, along with the `@agentclientprotocol/sdk` dependency and
the ACP tests.

**6. `0006-remove-share.patch` — no more postcards.**
Session sharing is deleted: the `SessionShare` service, the
`/session/{id}/share` endpoints, the `share` field on sessions and
its storage column, the `share` and `autoshare` config keys, the
`OPENCODE_AUTO_SHARE` flag, the share keybinds and sidebar link in
the TUI, and the SDK's share client and types.

**7. `0007-remove-upgrade-uninstall.patch` — the robot stops rebuilding himself.**
The `upgrade` and `uninstall` commands are deleted, along with the
`Installation` service, the `/global/upgrade` endpoint, the TUI
update command, dialog, and notices, the periodic update checker,
the `autoupdate` config keys, and `OPENCODE_DISABLE_AUTOUPDATE`. A
patched build must never be overwritten by an upstream release.

**8. `0008-remove-opentelemetry.patch` — the little radio is switched off.**
The OTLP log and trace exporters are deleted, along with the
`@opentelemetry/*` and `@effect/opentelemetry` dependencies, the AI
SDK telemetry plumbing, the `experimental.openTelemetry` config key,
the `OTEL_EXPORTER_OTLP_*` flags, and the OTEL environment forwarding
into workspaces. Local logging is unchanged.

**9. `0009-remove-import.patch` — old diaries stay out.**
The `opencode import` command, which imported session data from
exported JSON files, is deleted with its tests.

**10. `0010-remove-photon-image.patch` — pictures travel as they are.**
The Photon pipeline is deleted: the `@silvia-odwyer/photon-node`
dependency and both image services, so image attachments and image
reads pass through unmodified instead of being decoded, resized, and
re-encoded. The `attachment` / `attachments` image config keys go
with it.

**11. `0011-remove-zen-login-billing.patch` — no accounts, no bills.**
The `opencode console` command and the whole Console account system
are deleted: device-code login, account and organization storage,
remote organization config injected into the local config, the
`/experimental/console*` endpoints, the TUI organization switcher,
and the core Zen provider plugin that registered the Console OAuth
method and merged console-served configuration into the catalogue.
Zen's free models keep working anonymously.

**12. `0012-zen-free-tier-only.patch` — only the free candies stay.**
At both catalogue filter points — the build-time embed and the
runtime models.dev loader — the `opencode` provider keeps only
models whose cost is zero on every tier and whose status is not
`deprecated`. Exactly nine models remain. Paid Zen models are
removed from the data, not hidden; custom providers and models are
unaffected.

**13. `0013-remove-pty.patch` — the spare room is taken away.**
PTY, the pseudo-terminal, is removed at the root: the core service
and its Bun and Node adapters (`bun-pty`, `@lydell/node-pty`), the
`/pty` REST and WebSocket API and its ticket auth, the V2 protocol
group and server handlers, the plugin PTY-environment bridge, the
schema types and events, the `pty` ID prefix, and the SDK v1 and v2
clients and types. The terminal panel only ever existed in the
web/desktop UI (removed by cut 2), and the agent's Bash tool does
not use PTY.

---

A note for careful readers: this README is not a patch.
`scripts/apply-patches.sh` only reads `*.patch` files, so this page
is never applied to anything. It is here for human eyes.
