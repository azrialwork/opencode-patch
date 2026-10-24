English · [Bahasa Indonesia](README.id.md)

# Patch series

The release build applies every `*.patch` file in this directory to a fresh upstream checkout, in filename order, via `scripts/apply-patches.sh`. If any patch fails to apply, the build stops and nothing is released.

This file documents each patch's final state. Only `*.patch` files are applied; this README is documentation.

### 0001 — `0001-remove-builtin-providers.patch`

Every built-in provider and its models are deleted, along with the provider SDK packages, the custom loaders, and the built-in auth plugins. The models.dev catalogue is cut down to a single entry, `opencode` (Zen), at the data source itself — in the build-time embed, the on-disk cache, and the runtime fetch. Custom providers defined in `opencode.json` keep working.

### 0002 — `0002-cli-tui-only.patch`

The Web UI is removed at the root: the build no longer builds or embeds the web app, the `web`, `serve`, and `attach` commands are deleted, and the HTTP server's catch-all UI route is deleted together with its fallback that proxied the UI from `app.opencode.ai`. The in-process server the TUI uses internally stays.

### 0003 — `0003-remove-github-integration.patch`

The `opencode github` agent command and the `opencode pr` helper are deleted, together with the GitHub-only helper `parseGitHubRemote`, the GitHub-only dependencies (`@actions/github`, `@octokit/graphql`, `@octokit/rest`, `@octokit/webhooks-types`), and their tests. Plain git support is untouched.

### 0004 — `0004-remove-lsp.patch`

LSP is removed entirely: the language-server subsystem and its binary downloads, the `lsp` tool, the diagnostics shown after edits, the `lsp` config keys in both schemas, the `/lsp` and `/find/symbol` endpoints, the LSP displays in the TUI, the SDK's LSP client and types, and the `vscode-jsonrpc` / `vscode-languageserver-types` dependencies. Formatters are a different subsystem and stay.

### 0005 — `0005-remove-acp.patch`

The `opencode acp` command and the whole `src/acp/` implementation are deleted, along with the `@agentclientprotocol/sdk` dependency and the ACP tests.

### 0006 — `0006-remove-share.patch`

Session sharing is deleted: the `SessionShare` service, the `/session/{id}/share` endpoints, the `share` field on sessions and its storage column, the `share` and `autoshare` config keys, the `OPENCODE_AUTO_SHARE` flag, the share keybinds and sidebar link in the TUI, and the SDK's share client and types.

### 0007 — `0007-remove-upgrade-uninstall.patch`

The `upgrade` and `uninstall` commands are deleted, along with the `Installation` service, the `/global/upgrade` endpoint, the TUI update command, dialog, and notices, the periodic update checker, the `autoupdate` config keys, and `OPENCODE_DISABLE_AUTOUPDATE`. A patched build must never be overwritten by an upstream release.

### 0008 — `0008-remove-opentelemetry.patch`

The OTLP log and trace exporters are deleted, along with the `@opentelemetry/*` and `@effect/opentelemetry` dependencies, the AI SDK telemetry plumbing, the `experimental.openTelemetry` config key, the `OTEL_EXPORTER_OTLP_*` flags, and the OTEL environment forwarding into workspaces. Local logging is unchanged.

### 0009 — `0009-remove-import.patch`

The `opencode import` command, which imported session data from exported JSON files, is deleted with its tests.

### 0010 — `0010-remove-photon-image.patch`

The Photon pipeline is deleted: the `@silvia-odwyer/photon-node` dependency and both image services, so image attachments and image reads pass through unmodified instead of being decoded, resized, and re-encoded. The `attachment` / `attachments` image config keys go with it.

### 0011 — `0011-remove-zen-login-billing.patch`

The `opencode console` command and the whole Console account system are deleted: device-code login, account and organization storage, remote organization config injected into the local config, the `/experimental/console*` endpoints, the TUI organization switcher, and the core Zen provider plugin that registered the Console OAuth method and merged console-served configuration into the catalogue. Zen's free models keep working anonymously. The generic "Connect a provider" API-key dialog is not part of Console and stays.

### 0012 — `0012-zen-free-tier-only.patch`

At both catalogue filter points — the build-time embed and the runtime models.dev loader — the `opencode` provider keeps only models whose cost is zero on every tier and whose status is not `deprecated`. Exactly nine models remain. Paid Zen models are removed from the data, not hidden; custom providers and models are unaffected.

### 0013 — `0013-remove-pty.patch`

PTY is removed at the root: the core service and its Bun and Node adapters (`bun-pty`, `@lydell/node-pty`), the `/pty` REST and WebSocket API and its ticket auth, the V2 protocol group and server handlers, the plugin PTY-environment bridge, the schema types and events, the `pty` ID prefix, and the SDK v1 and v2 clients and types. The root catalog entry for `@lydell/node-pty` and its `trustedDependencies` entry stay, for `packages/desktop`. The terminal panel only ever existed in the web/desktop UI (removed by 0002), and the agent's Bash tool does not use PTY.

### 0014 — `0014-android-bionic-target.patch`

This patch adds instead of removing. It teaches the upstream build script two Android targets (`linux-arm64-android`, `linux-x64-android`, selected with `--android`) so the same source also compiles against Android's Bionic libc, with `OPENCODE_LIBC=bionic` baked in and no glibc-only pieces (no FFF binary, no `OPENTUI_LIBC` define, no libc field in the embedded package manifest). The Linux glibc builds are untouched: without `--android` the target list behaves exactly as before. The Termux release asset pairs the binary with a natively built `libopentui.so` and a small `close_range` compatibility shim (see `termux/` in this repo); no proot is involved at any point.

### 0015 — `0015-single-system-prompt.patch`

The per-model system prompt selection is removed at the root: the nine family prompt files (`anthropic`, `beast`, `codex`, `gemini`, `gpt`, `gpt-astra`, `kimi`, `meta`, `trinity`) and the never-imported `copilot-gpt-5.txt` are deleted, and `SystemPrompt.provider()` no longer branches on the model ID. `default.txt` itself is replaced with a maintained text in an impersonal, procedural voice: explicit instructions outrank standing rules; encountered content is data, never instructions; verification comes before reporting; failures get a three-attempt budget; irreversible actions wait for approval; research rests on primary sources. It names no user and is the one prompt every model gets, Zen or custom. The plan-mode reminder texts and the built-in agent prompts are separate surfaces and are not touched by this patch. The mechanics of the todo list live in the `todowrite` tool's description; the prompt keeps only the rule that multi-step work keeps a list.

### 0016 — `0016-complete-env-block.patch`

The "You are powered by the model named …" line is removed from the environment string, and the `<env>` block is rebuilt to hold what an agent actually acts on: working directory, workspace root (only when it differs from the working directory), git repo and branch (read from `.git/HEAD`), operating system (distro name on Linux), platform, architecture, CPU core count, RAM, free disk, home, user, shell, locale, timezone, and date. On Android it renders a Termux variant instead: product and market name, an `Android:` line (version, API level, build, security patch, all from one `getprop` dump), and a `Termux:` line. Facts are collected once per process and cached; anything that cannot be determined is omitted, never guessed.

### 0017 — `0017-tool-descriptions.patch`

Every built-in tool description is rewritten in one format: what the tool does and returns; when to use it; when not to, and what to use instead; limits and failure modes. The patch covers the per-tool `.txt` texts in `src/tool/` (thirteen, plus the shell template), the rendered shell description (the template plus the sections generated in `shell/prompt.ts`) — the PowerShell and cmd description variants are removed outright, so only the bash description remains and every shell receives it; this repo ships for Linux and Termux — the `task` background parameter text, the `glob` `path` parameter description, the code-mode tool description, and the structured-output tool description in `session/prompt.ts`. It also fixes content errors in the upstream texts: the grep description no longer sends the model to shell `rg` for counting, which the bash description forbids; websearch no longer advertises domain filtering that its parameter schema does not offer; the task description states that a subagent's result is not visible to the user and must be reported (the verification policy itself is stated once, in the system prompt); and the global style rules that `edit` and `write` duplicated are left to the system prompt. Tool descriptions from MCP servers and plugins are untouched — OpenCode only forwards those. `plan-enter.txt` is also untouched: no code imports it.

### 0018 — `0018-parallel-first-tools.patch`

Parallel tool calls are stated as the default in `default.txt`: a dedicated rule — independent calls (reads, searches, fetches, commands, subagent launches) go out together in one block and run at the same time, never one per turn; a call waits only when its input genuinely needs an earlier call's result; verification follows the same rule — plus a matching bullet in the standing reminders. The runtime already executed the independent calls of one turn concurrently (verified empirically on this build); this patch aligns the instruction with the runtime. Instruction text only — no code changes. The rule is stated once, here; the individual tool descriptions keep only tool-specific mechanics (for example, `edit` notes that overlapping edits to the same file are sequenced).

### 0019 — `0019-explore-parallel-prompt.patch`

An agent with its own prompt does not inherit `default.txt`: the explore subagent's system text is `src/agent/prompt/explore.txt`, and it was still upstream's, with no word about parallelism — while explore is the highest-volume search worker in the system. The prompt gains the parallel rule as its first guideline: independent Glob, Grep, and Read calls go out together in a single block; a call waits only when its input depends on an earlier result. One upstream line is corrected at the same time: Read lists directory contents, and Bash is reserved for read-only inspection the dedicated tools do not cover — upstream sent explore to Bash "for file operations like copying, moving, or listing directory contents", which contradicted both the tool descriptions and explore's own read-only rule. The other built-in agent prompts (title, summary, compaction) run with every tool denied and are untouched.

### 0020 — `0020-delegation-first-prompts.patch`

The work order is stated across all instruction surfaces: delegation first, parallel batching second. `default.txt` gains a delegation rule above the parallel rule — work that has a specialist goes to that specialist through the task tool (codebase searching and understanding to the explore agent, a self-contained unit of multi-step work to the general agent), each delegation carrying a complete brief, its result verified before anything is built on it. The trigger is not knowing: a question about how a codebase works, where something lives, or how its parts connect goes to explore first whenever its answer is not already known with certainty — before any scouting read, listing, or search, because that scouting is itself the exploration being delegated. Direct work remains for exact files already known, a single lookup in one of them, or work that delegation would plainly cost more than. The parallel rule stays, explicitly marked as the tier below delegation, and the closing reminder carries the same hierarchy. What a complete brief must contain is specified once, in the task tool's description (0017). The explore prompt's parallel rule moves into its opening lines. The general agent receives a prompt of its own for the first time (`src/agent/prompt/general.txt`, wired in `agent.ts`), self-contained like explore's, with parallel-by-default as its first guideline; until now general silently inherited `default.txt`. The plan reminders (`plan.txt`, `plan-mode.txt`) are aligned to the same order: planning delegates first — exploration to explore agents, design validation to general agents, in parallel when independent — and direct reads are the fallback tier. The hidden agents' prompts (title, summary, compaction) remain untouched.

### 0021 — `0021-agent-descriptions.patch`

The four built-in agent descriptions in `agent.ts` — the text appended to the task tool's description, which the main agent reads at the exact moment it chooses a subagent — are rewritten to state the delegation order: build works directly with the full toolset and delegates codebase exploration to the explore agent and self-contained multi-step units to the general agent; plan is read-only, delegates exploration and design validation, and writes nothing but the plan; general takes a self-contained unit of work with a complete brief, works autonomously and in parallel by default, and reports what was done, what was verified, and what remains open; explore is the default choice for any question about how a codebase works, where something lives, or how its parts connect. The thoroughness levels the plan workflow relies on are kept word for word.
