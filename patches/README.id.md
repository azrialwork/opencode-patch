[English](README.md) · Bahasa Indonesia

# Daftar potongan

Di buku cerita, penjahit menyimpan daftar pendapat yang pendek, dan
folder inilah daftar itu, ditulis dengan sebenarnya. Setiap file di
sini yang namanya berakhiran `.patch` adalah satu resep potongan.
Saat robot dibangun, para pembangun membaca daftar ini dari nomor 1
sampai 13, berurutan, dan melakukan setiap potongan pada salinan
OpenCode upstream yang masih segar.

Satu aturan lebih penting dari yang lain: kalau satu resep tidak pas,
pembangunan berhenti dan tidak ada yang dikirim.

Untuk daftar yang sama dalam bentuk cerita, baca
[buku ceritanya](../README.id.md).

## Resep-resepnya

**1. `0001-remove-builtin-providers.patch` — pameran mainan raksasa tutup.**
Setiap provider bawaan dan modelnya dihapus, beserta paket SDK
provider, loader khusus, dan plugin auth bawaan. Katalog models.dev
dipotong menjadi satu entri saja, `opencode` (Zen), langsung di sumber
datanya — di embed saat build, cache di disk, dan pengambilan saat
runtime. Provider custom yang didefinisikan di `opencode.json` tetap
bekerja.

**2. `0002-cli-tui-only.patch` — jendela-jendelanya dicopot.**
Web UI dihapus dari akarnya: build tidak lagi membangun atau
menyematkan aplikasi web, perintah `web`, `serve`, dan `attach`
dihapus, dan route UI catch-all di server HTTP dihapus beserta
fallback-nya yang meminjam UI dari `app.opencode.ai`. Server
in-process yang dipakai TUI secara internal tetap ada.

**3. `0003-remove-github-integration.patch` — gurita pulang.**
Perintah agen `opencode github` dan pembantu `opencode pr` dihapus,
beserta helper khusus GitHub `parseGitHubRemote` dan dependensi
khusus GitHub (`@actions/github`, `@octokit/graphql`, `@octokit/rest`,
`@octokit/webhooks-types`) serta tes-tesnya. Dukungan git biasa tidak
disentuh.

**4. `0004-remove-lsp.patch` — guru bahasa pensiun.**
LSP dihapus seluruhnya: subsistem language server dan unduhan
binary-nya, alat `lsp`, diagnostik yang dibisikkan setelah setiap
edit, kunci config `lsp` di kedua skema, endpoint `/lsp` dan
`/find/symbol`, tampilan LSP di TUI, client dan tipe LSP di SDK, dan
dependensi `vscode-jsonrpc` / `vscode-languageserver-types`.
Formatter adalah subsistem yang berbeda dan tetap ada.

**5. `0005-remove-acp.patch` — colokan penerjemah dicabut.**
Perintah `opencode acp` dan seluruh implementasi `src/acp/` dihapus,
beserta dependensi `@agentclientprotocol/sdk` dan tes ACP.

**6. `0006-remove-share.patch` — tidak ada kartu pos lagi.**
Berbagi sesi dihapus: layanan `SessionShare`, endpoint
`/session/{id}/share`, field `share` pada sesi dan kolom
penyimpanannya, kunci config `share` dan `autoshare`, flag
`OPENCODE_AUTO_SHARE`, keybind dan tautan share di TUI, serta client
dan tipe share di SDK.

**7. `0007-remove-upgrade-uninstall.patch` — robot berhenti membangun ulang dirinya.**
Perintah `upgrade` dan `uninstall` dihapus, beserta layanan
`Installation`, endpoint `/global/upgrade`, perintah update, dialog,
dan pemberitahuan di TUI, pemeriksa update berkala, kunci config
`autoupdate`, dan `OPENCODE_DISABLE_AUTOUPDATE`. Build hasil patch
tidak boleh ditimpa rilis upstream.

**8. `0008-remove-opentelemetry.patch` — radio kecilnya dimatikan.**
Exporter log dan trace OTLP dihapus, beserta dependensi
`@opentelemetry/*` dan `@effect/opentelemetry`, plumbing telemetri AI
SDK, kunci config `experimental.openTelemetry`, flag
`OTEL_EXPORTER_OTLP_*`, dan penerusan environment OTEL ke workspace.
Logging lokal tidak berubah.

**9. `0009-remove-import.patch` — buku harian lama tidak ikut masuk.**
Perintah `opencode import`, yang mengimpor data sesi dari file JSON
hasil export, dihapus beserta tes-tesnya.

**10. `0010-remove-photon-image.patch` — gambar bepergian apa adanya.**
Pipeline Photon dihapus: dependensi `@silvia-odwyer/photon-node` dan
kedua layanan gambar, sehingga lampiran gambar dan hasil baca gambar
diteruskan apa adanya, tidak dibuka, diubah ukurannya, atau dimasak
ulang. Kunci config gambar `attachment` / `attachments` ikut hilang.

**11. `0011-remove-zen-login-billing.patch` — tidak ada akun, tidak ada tagihan.**
Perintah `opencode console` dan seluruh sistem akun Console dihapus:
login device-code, penyimpanan akun dan organisasi, config organisasi
remote yang disuntikkan ke config lokal, endpoint
`/experimental/console*`, pemindah organisasi di TUI, dan plugin
provider Zen di core yang mendaftarkan metode OAuth Console dan
menggabungkan config dari server console ke katalog. Model gratis
Zen tetap bekerja tanpa nama.

**12. `0012-zen-free-tier-only.patch` — hanya permen gratis yang tersisa.**
Di kedua titik penyaring katalog — embed saat build dan loader
models.dev saat runtime — provider `opencode` hanya mempertahankan
model yang biayanya nol di semua tier dan statusnya bukan
`deprecated`. Tepat sembilan model yang tersisa. Model Zen berbayar
dihapus dari datanya, bukan disembunyikan; provider dan model custom
tidak terpengaruh.

**13. `0013-remove-pty.patch` — ruang cadangannya dihilangkan.**
PTY, pseudo-terminal, dihapus dari akarnya: layanan core dan adapter
Bun dan Node-nya (`bun-pty`, `@lydell/node-pty`), API REST dan
WebSocket `/pty` beserta auth tiketnya, grup protocol V2 dan handler
server, jembatan PTY-environment di plugin, tipe dan event skema,
prefix ID `pty`, serta client dan tipe SDK v1 dan v2. Panel terminal
hanya pernah ada di UI web/desktop (dihapus oleh potongan 2), dan
alat Bash milik agen tidak memakai PTY.

**14. `0014-android-bionic-target.patch` — pintu kedua, untuk ponsel.**
Potongan ini menambah, bukan mengurangi. Ia mengajari script build
upstream dua target Android (`linux-arm64-android`,
`linux-x64-android`, dipilih dengan `--android`) supaya sumber yang
sudah ramping yang sama juga terkompilasi melawan libc Bionic milik
Android, dengan `OPENCODE_LIBC=bionic` tertanam dan tanpa
potongan khusus glibc (tanpa binary FFF, tanpa define OPENTUI_LIBC,
tanpa field libc di manifest paket tertanam). Build Linux glibc
tidak tersentuh: tanpa `--android`, daftar target berperilaku
persis seperti sebelumnya. Aset rilis Termux memasangkan binary ini
dengan `libopentui.so` yang dibangun secara native dan shim kecil
`close_range` (lihat `termux/` di repo ini); tidak ada proot yang
terlibat di titik mana pun.

**15. `0015-single-system-prompt.patch` — satu suara untuk semua model.**
Pemilihan system prompt per model dihapus dari akarnya: sembilan
file prompt keluarga (`anthropic`, `beast`, `codex`, `gemini`,
`gpt`, `gpt-astra`, `kimi`, `meta`, `trinity`) dan `copilot-gpt-5.txt`
yang tidak pernah diimpor dihapus, dan `SystemPrompt.provider()`
tidak lagi bercabang berdasarkan ID model. `default.txt` sendiri
dipertahankan persis seperti bawaan upstream — ia hanya menjadi
satu-satunya prompt yang didapat semua model, Zen maupun custom.
Teks pengingat plan-mode dan prompt agen bawaan (title, summary,
explore, compaction) adalah permukaan terpisah dan tidak disentuh.

---

Catatan untuk pembaca yang teliti: README ini bukan patch.
`scripts/apply-patches.sh` hanya membaca file `*.patch`, jadi halaman
ini tidak pernah diterapkan ke apa pun. Ia ada di sini untuk mata
manusia.
