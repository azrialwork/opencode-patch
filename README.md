# opencode-patch

A delta patch series on top of upstream [OpenCode](https://github.com/anomalyco/opencode). This repository contains only patches and build automation — it is not a fork. Every release fetches the newest stable upstream `v1.x.x` source, applies the patch series in [`patches/`](patches/), and publishes patched CLI binaries for Linux (glibc) and Android/Termux (Bionic).

[Bahasa Indonesia](README.id.md)

## What the patches do

The series removes features and providers at the root — code, data, and dependencies are deleted, not hidden or filtered — narrows the built-in provider catalogue to the free Zen tier, adds a native Termux build target, and replaces the instruction surfaces (system prompt, environment block, tool descriptions, agent prompts, agent descriptions) with texts maintained in this repo.

| # | Patch | Effect |
|---|-------|--------|
| 0001 | remove-builtin-providers | Deletes every built-in provider except Zen (`opencode`), its SDK packages, loaders, and auth plugins. The models.dev catalogue is cut to the Zen entry at the data source. Custom providers in `opencode.json` are unaffected. |
| 0002 | cli-tui-only | Removes the web UI: the web app is no longer built or embedded, and the `web`, `serve`, and `attach` commands are deleted. The in-process API the TUI uses internally stays. |
| 0003 | remove-github-integration | Deletes the `github` command, the `pr` helper, and the GitHub-only dependencies. Plain git support is untouched. |
| 0004 | remove-lsp | Removes the LSP subsystem, the `lsp` tool, its config keys, endpoints, and dependencies. Formatters are a separate subsystem and stay. |
| 0005 | remove-acp | Deletes the `acp` command, the ACP implementation, and its SDK dependency. |
| 0006 | remove-share | Deletes session sharing: the service, the endpoints, the config keys, and the SDK client. |
| 0007 | remove-upgrade-uninstall | Deletes the `upgrade` and `uninstall` commands, the Installation service, and the periodic update checker. A patched build is never overwritten by an upstream release. |
| 0008 | remove-opentelemetry | Deletes the OTLP exporters, the telemetry dependencies, and the config key. Local logging is unchanged. |
| 0009 | remove-import | Deletes the `import` command. |
| 0010 | remove-photon-image | Deletes the Photon image pipeline and its dependency; image attachments pass through unmodified. |
| 0011 | remove-zen-login-billing | Deletes the Console account system: device-code login, account storage, and organization config injection. Zen free models keep working anonymously. |
| 0012 | zen-free-tier-only | Narrows the Zen catalogue to models that are zero-cost on every tier and not deprecated — nine models — at both catalogue filter points (build-time embed and runtime loader). |
| 0013 | remove-pty | Removes PTY at the root: the service and its adapters, the REST/WebSocket API, the protocol group, and the SDK clients. The agent's shell tool does not use PTY. |
| 0014 | android-bionic-target | Adds Android targets to the upstream build script (`OPENCODE_LIBC=bionic`) plus Termux packaging: a natively built `libopentui.so` and a `close_range` compatibility shim. No proot. Linux glibc builds are unaffected. |
| 0015 | single-system-prompt | Deletes the ten per-model system prompt variants and the model-ID selection logic. `default.txt` is replaced by a maintained text covering precedence and trust, verification before reporting, a three-attempt failure budget, approval for irreversible actions, and primary-source research. |
| 0016 | complete-env-block | Removes the model-identity line from the environment string and rebuilds the `<env>` block as a cached snapshot of the device: working directory, workspace root, git branch, OS/distro, architecture, CPU cores, RAM, free disk, shell, locale, timezone, date — with an Android/Termux variant. Undetermined fields are omitted, never guessed. |
| 0017 | tool-descriptions | Rewrites every built-in tool description in one format: what the tool does and returns, when to use it, when not to and what to use instead, limits and failure modes. The shell description keeps only the bash variant; the PowerShell and cmd variants are deleted. |
| 0018 | parallel-first-tools | States parallel tool calls as the default in the system prompt. The runtime already executed the independent calls of one turn concurrently; the texts now instruct it. |
| 0019 | explore-parallel-prompt | Aligns the explore agent's own prompt (it does not inherit the main prompt) with the parallel rule, and corrects its Bash guidance to read-only inspection. |
| 0020 | delegation-first-prompts | Establishes the work order across the system prompt, the agent cards, and the plan reminders: delegation first — codebase questions to the explore agent, self-contained multi-step units to the general agent — with parallel batching as the tier below. The delegation trigger is not knowing the answer, not the size of the question. |
| 0021 | agent-descriptions | Rewrites the four built-in agent descriptions in `agent.ts` — the text the main agent reads when choosing a subagent — to state the same delegation order at the point of choice. |

Per-patch details: [patches/README.md](patches/README.md).

## Install

```sh
curl -fsSL https://raw.githubusercontent.com/azrialwork/opencode-patch/main/install.sh | bash
```

The installer detects the platform — Linux glibc x64 (with a baseline build for CPUs without AVX2), Linux arm64, or Termux on Android (arm64) — downloads the matching archive, verifies its SHA256 against the release's `SHA256SUMS`, and installs to `/usr/local/bin` if writable, otherwise `~/.local/bin`.

| Option | Effect |
|--------|--------|
| `--version <tag>` | Install a specific release tag instead of the latest release. |
| `--install-dir <dir>` | Install to a specific directory. |

Both options can also be set as environment variables (`VERSION`, `INSTALL_DIR`).

Manual install: download an archive and `SHA256SUMS` from the [releases page](https://github.com/azrialwork/opencode-patch/releases), run `sha256sum -c SHA256SUMS`, extract the archive, and put the `opencode` binary on your `PATH`. The Termux archive contains a launcher plus the binary and its native libraries under `lib/opencode-patch/`; extract it as a whole and run the launcher.

## Release assets

| Asset | Platform |
|-------|----------|
| `opencode-linux-x64.tar.gz` | Linux glibc, x86-64 (AVX2) |
| `opencode-linux-x64-baseline.tar.gz` | Linux glibc, x86-64 without AVX2 |
| `opencode-linux-arm64.tar.gz` | Linux glibc, arm64 |
| `opencode-termux-arm64.tar.gz` | Android/Termux, Bionic arm64 |
| `SHA256SUMS` | SHA256 checksums of all archives |

## How releases are built

- The `Release` workflow (`.github/workflows/release.yml`) runs every six hours (cron `0 */6 * * *` UTC) and on manual dispatch, with optional `version` and `force` inputs.
- It resolves the newest stable upstream `v1.x.x` tag. A version this repository has already released is skipped, unless `force` is set.
- Patches are applied in filename order **before** `bun install`, and install runs without `--frozen-lockfile`, so dependencies removed by a patch are never installed. A patch that fails to apply fails the build; nothing is released.
- The Termux jobs build `libopentui.so` from the pinned OpenTUI v0.4.5 sources (Zig and the Android NDK, 16 KB page alignment) and verify the Bionic binary with `readelf`; any glibc dependency fails the build.
- Assets and `SHA256SUMS` are published as a GitHub release under the upstream version tag.

Tracking configuration lives in [`upstream.json`](upstream.json). Current basis: upstream `v1.19.4`, commit `148842ef7cb1bc34192b3fff57d0f9721ab9c801`.

## Results

For upstream v1.19.4, the patched Linux x64 binary is 159,951,024 bytes, against 214,526,128 bytes for the upstream build (−25.4%). The Termux binary is 138,289,528 bytes. The Termux build was verified end-to-end on a real Android 12 device (install, agent loop, TUI).

## Repository layout

```
patches/     the patch series, numbered, applied in filename order
scripts/     upstream version resolution, patch application, Linux packaging
termux/      Termux launcher, close_range shim, OpenTUI build patch and packaging
install.sh   one-command installer for the release binaries
upstream.json  upstream repository and tracking configuration
.github/workflows/release.yml  the release automation
```

## Adding a patch

1. Make the change in a writable clone of upstream at the tracked tag, and test it.
2. Export it as the next numbered file: `git diff > patches/NNNN-short-name.patch`.
3. Document it in [patches/README.md](patches/README.md).
4. Commit. The next scheduled build applies it.

Two rules govern the series. A patch removes at the root: it deletes code, data, and dependencies rather than hiding or filtering them. And the hidden agents' prompts (title, summary, compaction) are never modified; they stay byte-identical to upstream.

## License

MIT, the same as upstream OpenCode. See [LICENSE](LICENSE).
