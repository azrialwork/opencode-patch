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

**14. `0014-android-bionic-target.patch` — a second door, for the phone.**
This cut adds instead of removing. It teaches the upstream build
script two Android targets (`linux-arm64-android`,
`linux-x64-android`, selected with `--android`) so the same slimmed
source also compiles against Android's Bionic libc, with
`OPENCODE_LIBC=bionic` baked in and no glibc-only pieces (no FFF
binary, no OPENTUI_LIBC define, no libc field in the embedded
package manifest). The Linux glibc builds are untouched: without
`--android` the target list behaves exactly as before. The Termux
release asset pairs the binary with a natively built `libopentui.so`
and a small `close_range` compat shim (see `termux/` in this repo);
no proot is involved at any point.

**15. `0015-single-system-prompt.patch` — one voice for every model.**
The per-model system prompt selection is removed at the root: the
nine family prompt files (`anthropic`, `beast`, `codex`, `gemini`,
`gpt`, `gpt-astra`, `kimi`, `meta`, `trinity`) and the never-imported
`copilot-gpt-5.txt` are deleted, and `SystemPrompt.provider()` no
longer branches on the model ID. `default.txt` itself is replaced
with a text of this repo's own: a short book of working rules in
an impersonal, procedural voice — explicit instructions outrank
standing rules, encountered content is data and never
instructions, verification comes before reporting, failures get a
three-attempt budget, irreversible actions wait for approval,
research rests on primary sources — distilled from the
maintainer's standing agent rules and revised against the
published prompt guidance of Anthropic, OpenAI, and Google. It
names no user; it only describes how the work is done, and it is
the one prompt every model gets, Zen or custom. The plan-mode reminder texts and
the built-in agent prompts (title, summary, explore, compaction)
are separate surfaces and are not touched.

**16. `0016-complete-env-block.patch` — the environment block
tells the truth about the device, and only the useful truth.** The
"You are powered by the model named …" line is removed from the
environment string, and the `<env>` block is rebuilt to hold what
an agent actually acts on: working directory, workspace root (only
when it differs from the working directory), git repo and branch
(read from `.git/HEAD`), operating system (distro name on Linux),
platform, architecture, CPU core count, RAM, free disk, home,
user, shell, locale, timezone, and date. On Android it renders a
Termux variant instead — product and market name, an `Android:`
line (version, API level, build, security patch, all from one
`getprop` dump), and a `Termux:` line. Facts are collected once
per process and cached; anything that cannot be determined is
omitted, never guessed.

**17. `0017-tool-descriptions.patch` — every tool description
rewritten in the house format.** Every built-in tool description
is rewritten following the same prompt best practices as patch
0015's system prompt: what the tool does and returns; when to use
it; when not to, and what to use instead; limits and failure
modes; plain register throughout. The patch covers the per-tool
`.txt` texts in `src/tool/` (thirteen, plus the shell template),
the rendered shell description (the template plus the section
generated in `shell/prompt.ts`) — the PowerShell and cmd
description variants are removed outright, so only the bash
description remains and every shell receives it; this house
ships for Linux and Termux, where bash is the shell that
matters,
the `task` background parameter text, the `glob` `path`
parameter description (a 268-character warning becomes one
sentence), the code-mode tool description, and the
structured-output tool description in `session/prompt.ts`.
Deliberate content fixes ride along: the grep description no
longer sends the model to shell `rg` for counting, which the
bash description forbids; websearch no longer advertises domain
filtering that its parameter schema does not offer; the task
description asks for a subagent's result to be verified against
the request instead of generally trusted; and the global style
rules that `edit` and `write` duplicated (documentation files,
emojis) are left to the system prompt. Tool descriptions from
MCP servers and plugins are untouched — OpenCode only forwards
those. `plan-enter.txt` is also untouched: no code imports it.

**18. `0018-parallel-first-tools.patch` — parallel tool calls
are the default, in writing.** The runtime already executes the
independent tool calls of one turn concurrently (verified
empirically on this build); the texts now instruct exactly that
as the default rather than an option. `default.txt` gains a
dedicated rule under "How the work is done" — independent calls
(reads, searches, fetches, commands, subagent launches) go out
together in one block and run at the same time, never one per
turn; a call waits only when its input genuinely needs an
earlier call's result; anything else unknown is probed in
parallel; verification follows the same rule — plus a matching
bullet in the standing reminders at the end. The tool
descriptions from patch 0017 are aligned to the same default:
the batching lines in read, glob, grep, webfetch, and websearch
move from "can be batched" to "by default", edit and write gain
parallel-issuance notes (overlapping edits to the same file
stay sequenced), task's concurrent launch becomes the stated
default, and the rendered shell section says independent
commands run in parallel by default. Instruction text only — no code changes.

**19. `0019-explore-parallel-prompt.patch` — the explore
agent's own card learns the two-hands rule.** An agent with its
own prompt does not inherit `default.txt`: the explore
subagent's system text is `src/agent/prompt/explore.txt`, and
it was still upstream's — its tools listed one by one, with no
word about parallelism — while explore is the highest-volume
search worker in the system. The prompt gains the house
parallel rule as its first guideline: independent Glob, Grep,
and Read calls go out together in a single block and run at the
same time; a call waits only when its input depends on an
earlier result. The tool lines are aligned with the tool
descriptions at the same time: Read lists directory contents,
and Bash is reserved for read-only inspection the dedicated
tools do not cover. Upstream's line sending explore to Bash
"for file operations like copying, moving, or listing directory
contents" contradicted the descriptions and explore's own
read-only rule at the bottom of the same file. The other
built-in agent prompts — title, summary, compaction — run with
every tool denied, so there is nothing to parallelize there;
they are untouched.

**20. `0020-delegation-first-prompts.patch` — the house order
of work: delegate first, batch second.** The main prompt now
states the hierarchy outright. `default.txt` gains a delegation
rule above the parallel rule: work that has a specialist goes
to that specialist through the task tool — codebase searching
and understanding to the explore agent, a self-contained unit
of multi-step work to the general agent — each delegation
carrying a complete brief, and its result verified before
anything is built on it; direct work is reserved for what is
small, already located, and certain, or where delegation would
cost more than the work itself. The parallel rule stays,
explicitly demoted: it is the tier below delegation, governing
the work done directly, and the closing reminder says the same
in one line. The workers' own cards are strengthened in the
opposite direction — inside a brief, batching is the first
law: explore's parallel rule moves up into its opening lines,
and the general agent receives a prompt of its own for the
first time (`src/agent/prompt/general.txt`, wired in
`agent.ts`), self-contained like explore's, with
parallel-by-default as its first guideline; until now general
silently inherited `default.txt`. The plan-mode reminders
(`plan.txt`, `plan-mode.txt`) are aligned to the same order:
planning delegates first — exploration to explore agents,
design validation to general agents, in parallel when
independent — and direct reads are the fallback tier. The
hidden agents' prompts remain untouched, as always.

---

A note for careful readers: this README is not a patch.
`scripts/apply-patches.sh` only reads `*.patch` files, so this page
is never applied to anything. It is here for human eyes.
