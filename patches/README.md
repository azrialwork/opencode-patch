<p align="center">🇬🇧 <b>English</b> · <a href="README.id.md">🇮🇩 Bahasa Indonesia</a></p>

# ✂️📋 The Tailor's List of Cuts

Welcome to the tailor's notebook! 📖

Every file in this folder that ends in `.patch` is **one cut recipe**.
When a new robot is built, the builder robots read this list
**from number 1 to number 13**, in order, and do every cut.

🛑 **The golden rule:** if one recipe does not fit, *everything stops*.
No robot is shipped. A half-cut robot is worse than no robot.

Want the story version first? Read the [storybook](../README.md). 📚

---

## 🧵 The 13 recipes

### 1. 🏪 `0001-remove-builtin-providers.patch`
*Close the giant toy fair.*
All built-in AI shops are deleted — their lists of models, their keys, their helper code.
Only the little free shop (`opencode`, Zen) stays, plus any shop you build yourself.

### 2. 🪟 `0002-cli-tui-only.patch`
*Take away the windows.*
The web pages are deleted: no more `web`, `serve`, or `attach`, and no secret tunnel
that borrowed pages from `app.opencode.ai`. The robot lives in the terminal only.

### 3. 🐙 `0003-remove-github-integration.patch`
*Send the octopus home.*
The `opencode github` helper and the `opencode pr` helper are deleted,
together with their octopus-only tools (`@octokit/*`, `@actions/github`).
Plain `git` is untouched.

### 4. 🔤 `0004-remove-lsp.patch`
*The language teacher retires.*
The whole language-server world is deleted: the teacher's house (`src/lsp/`),
his downloaded books, the `lsp` tool, the whisper-after-editing, the `lsp` config keys,
the `/lsp` doors, and his little counters in the TUI.
(The robot's *drawing* colors for code stay — those live somewhere else.)

### 5. 🔌 `0005-remove-acp.patch`
*Pull the translator plug.*
The `opencode acp` door and its whole room (`src/acp/`) are deleted,
plus its plug (`@agentclientprotocol/sdk`) and its tests.

### 6. 📤 `0006-remove-share.patch`
*No more postcards.*
Session sharing is deleted: the share service, the `/session/{id}/share` doors,
the `share` sticker on every chat, the `share`/`autoshare` config keys,
the `OPENCODE_AUTO_SHARE` flag, and the share buttons in the TUI.

### 7. 🔄 `0007-remove-upgrade-uninstall.patch`
*The robot stops rebuilding himself.*
The `upgrade` and `uninstall` words, the `Installation` butler, the `/global/upgrade` door,
the TUI update bell, and the `autoupdate` config keys are deleted —
so an outside robot can never overwrite our tailor-made one.

### 8. 📡 `0008-remove-opentelemetry.patch`
*Turn the little radio off.*
The report-sending radios (OTLP exporters) and their batteries
(`@opentelemetry/*`, `@effect/opentelemetry`) are deleted, plus the
`experimental.openTelemetry` config key and the `OTEL_*` flags.
Notes the robot writes for *himself* at home (local logging) stay.

### 9. 📥 `0009-remove-import.patch`
*Close the old-diary door.*
The `opencode import` command — the one that brought old chats in from files —
is deleted, with its tests.

### 10. 🖼️ `0010-remove-photon-image.patch`
*Pictures travel as they are.*
The tiny photo-squeezing machine (`@silvia-odwyer/photon-node`) and both of
its workers are deleted. Pictures are no longer decoded, resized, or re-cooked;
they pass through exactly as they arrived. The picture config keys go with it.

### 11. 🔑 `0011-remove-zen-login-billing.patch`
*The cashier goes home.*
The `opencode console` command and the whole account world are deleted:
signing in with secret codes, account and organization storage, config sent
from the console, the `/experimental/console*` doors, and the organization
switcher in the TUI. Free models keep working — anonymously, with no bill.

### 12. 🍬 `0012-zen-free-tier-only.patch`
*Only the free candies stay.*
At both places where the shop's candy list is written (when the robot is built,
and when he fetches the list), only candies that cost **zero on every shelf**
and are not old (`deprecated`) may stay. Paid Zen models are removed from the
data itself. Your own shop's candies are never touched.

### 13. ⌨️ `0013-remove-pty.patch`
*Remove the empty typing room.*
The pseudo-terminal (PTY) is deleted at the root: the core service, its
`bun-pty`/`@lydell/node-pty` motors, the `/pty` doors and their ticket locks,
the plugin bridge, the schema types, and the SDK clients.
Its screen lived in the web pages (cut #2), and the Bash tool never used it.

---

> 🗒️ **Tiny note:** this README is *not* a patch.
> The builders' `scripts/apply-patches.sh` only reads `*.patch` files,
> so this page is just for human eyes. Like yours. Hello! 👀
