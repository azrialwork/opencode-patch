# opencode-patch

A delta repo on top of upstream [OpenCode](https://github.com/anomalyco/opencode).
It contains **only** the changes wanted on top of upstream — never a copy of
the upstream source tree — and rebuilds the patched OpenCode from upstream
source on GitHub Actions, publishing the result as a GitHub Release here.

## What it builds

- **Scope:** CLI only (`packages/opencode`), no desktop app.
- **Platform:** Linux only, **glibc** only (no musl).
- **Assets per release:**
  - `opencode-linux-x64.tar.gz`
  - `opencode-linux-arm64.tar.gz`
  - `opencode-linux-x64-baseline.tar.gz` (x64 without AVX2, for older CPUs)
  - `SHA256SUMS`

Each archive contains a single `opencode` binary.

## Version tracking

There is no static pin. The release workflow automatically follows the
latest stable upstream **`v1.x.x`** release:

- A scheduled GitHub Actions run (cron `0 */6 * * *` UTC — 07:00, 13:00,
  19:00, 01:00 WIB) checks upstream every 6 hours, and can also be started
  manually (`workflow_dispatch`, optionally with a version override).
- `scripts/latest-upstream.sh` resolves the highest exact `v1.<minor>.<patch>`
  tag and its commit SHA via `git ls-remote`. Prereleases and `v2.x` are
  never followed.
- The candidate must be a published, non-draft, non-prerelease upstream
  GitHub Release, and must not already have a release in this repo —
  otherwise the run stops without building.
- Every release here is tagged exactly like upstream (`v1.19.4`, ...) and
  its notes record the exact upstream commit SHA it was built from, so an
  individual release is always reproducible even though tracking moves.

The initial basis is upstream `v1.19.4` (commit
`148842ef7cb1bc34192b3fff57d0f9721ab9c801`).

## How a build works

1. Resolve the latest stable `v1.x.x` (above).
2. Check out `anomalyco/opencode` at that exact commit.
3. Install the Bun version upstream pins in its root `package.json`
   (`packageManager`), then `bun install --frozen-lockfile`.
4. Apply `patches/*.patch` in filename order (`scripts/apply-patches.sh`).
   Any patch that does not apply cleanly fails the build — no release is
   produced from a half-patched tree.
5. Build with upstream's own script, `./packages/opencode/script/build.ts`,
   restricted to Linux glibc targets by runner + flags:
   x64 job `--single --baseline`, arm64 job `--single`.
   `OPENCODE_VERSION` is set to the upstream version being built;
   `OPENCODE_RELEASE` is intentionally not set, so packaging and upload
   stay with this repo's workflow.
6. Smoke-test the native binaries (`opencode --version`), package the
   `.tar.gz` assets, checksum them, and create the GitHub Release.

## Patches

Currently **no patches** — the series is intentionally empty and releases
are plain upstream rebuilds while the pipeline is being proven.

To add a patch later:

1. In a *writable* clone of upstream, check out the target `v1.x.x` tag.
2. Make the change, test it (`bun typecheck` / package tests, per
   upstream's `AGENTS.md`).
3. Export it: `git diff > patches/0001-short-name.patch` (numbered, one
   logical change per patch).
4. Commit the patch file here. The next scheduled run picks it up
   automatically; a manual run applies it immediately.

## Install

Download the archive for your CPU from this repo's
[Releases](../../releases), then:

```sh
tar -xzf opencode-linux-x64.tar.gz
./opencode --version
install -m 755 opencode ~/.local/bin/opencode
```

## License

The scripts and patches in this repo are MIT (see `LICENSE`). OpenCode
itself is MIT-licensed upstream; all upstream code remains under its own
license and is fetched at build time, not stored here.
