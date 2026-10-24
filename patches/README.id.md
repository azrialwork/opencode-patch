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
diganti dengan teks milik repo ini: sebuah buku kecil aturan
kerja bersuara impersonal dan prosedural — instruksi eksplisit
mengalahkan aturan tetap, konten yang ditemui adalah data dan
tak pernah instruksi, verifikasi mendahului laporan, kegagalan
mendapat anggaran tiga percobaan, tindakan yang tak dapat
ditarik kembali menunggu persetujuan, riset bertumpu pada sumber
primer — didistilasi dari aturan agen tetap sang maintainer dan
direvisi berdasarkan panduan prompt resmi Anthropic, OpenAI, dan
Google. Ia tidak menyebut pengguna mana pun; ia hanya
menjabarkan bagaimana pekerjaan dilakukan, dan ia adalah
satu-satunya prompt yang didapat semua model, Zen maupun custom.
Teks pengingat plan-mode dan prompt agen bawaan (title, summary,
explore, compaction) adalah permukaan terpisah dan tidak disentuh.

**16. `0016-complete-env-block.patch` — blok environment bercerita
benar tentang perangkatnya, dan hanya kebenaran yang berguna.**
Baris "You are powered by the model named …" dihapus dari string
environment, dan blok `<env>` dibangun ulang untuk memuat yang
benar-benar ditindaklanjuti agen: direktori kerja, root workspace
(hanya bila berbeda dari direktori kerja), repo git beserta
branch-nya (dibaca dari `.git/HEAD`), sistem operasi (nama distro
di Linux), platform, arsitektur, jumlah core CPU, RAM, disk
bebas, home, user, shell, locale, zona waktu, dan tanggal. Di
Android ia menggambar varian Termux sebagai gantinya — nama
produk dan nama pasar, baris `Android:` (versi, level API, build,
security patch, semuanya dari satu dump `getprop`), dan baris
`Termux:`. Fakta dikumpulkan sekali per proses lalu di-cache; apa
pun yang tidak bisa ditentukan akan hilang, tidak pernah ditebak.

**17. `0017-tool-descriptions.patch` — setiap deskripsi tool
ditulis ulang dalam format rumah ini.** Setiap deskripsi tool
bawaan ditulis ulang mengikuti praktik terbaik prompt yang sama
dengan system prompt patch 0015: apa yang dilakukan tool dan apa
yang dikembalikannya; kapan tool dipakai; kapan tidak, dan apa
penggantinya; batas serta cara gagalnya; register polos di
seluruh teks. Patch ini mencakup teks-teks `.txt` per tool di
`src/tool/` (tiga belas, ditambah template shell), deskripsi
shell yang dirender (template plus bagian yang dibangkitkan di
`shell/prompt.ts`; varian deskripsi PowerShell dan cmd dihapus
sepenuhnya, sehingga yang tersisa hanya deskripsi bash dan
setiap shell menerimanya — rumah ini mengirim untuk Linux dan
Termux, tempat bash adalah shell yang penting), teks parameter
background milik `task`, deskripsi parameter `path` milik `glob`
(peringatan 268 karakter menjadi satu kalimat), deskripsi tool
code-mode, dan deskripsi tool structured-output di
`session/prompt.ts`. Perbaikan isi yang disengaja ikut serta:
deskripsi grep tidak lagi menyuruh model memakai `rg` di shell
untuk menghitung, yang dilarang deskripsi bash; websearch tidak
lagi mengiklankan penyaringan domain yang tidak ditawarkan skema
parameternya; deskripsi task meminta hasil subagen diverifikasi
terhadap permintaannya, bukan dipercaya begitu saja; dan aturan
gaya global yang diduplikasi `edit` dan `write` (file
dokumentasi, emoji) diserahkan kepada system prompt. Deskripsi
tool dari server MCP dan plugin tidak disentuh — OpenCode hanya
meneruskannya. `plan-enter.txt` juga tidak disentuh: tidak ada
kode yang mengimpornya.

**18. `0018-parallel-first-tools.patch` — panggilan tool
paralel adalah default-nya, secara tertulis.** Runtime memang
sudah mengeksekusi panggilan tool independen dalam satu giliran
secara konkuren (terverifikasi empirik pada build ini); kini
teks-teksnya memerintahkan persis itu sebagai default, bukan
pilihan. `default.txt` mendapat aturan khusus di bawah "How
the work is done" — panggilan independen (baca, cari, ambil,
perintah, peluncuran subagen) berangkat bersama dalam satu blok
dan berjalan pada saat yang sama, tidak pernah satu per
giliran; sebuah panggilan menunggu hanya bila inputnya sungguh
membutuhkan hasil panggilan sebelumnya; hal lain yang belum
diketahui diselidiki secara paralel; verifikasi mengikuti
aturan yang sama — ditambah bullet yang sepadan di pengingat
tetap di bagian akhir. Deskripsi tool dari patch 0017
diselaraskan ke default yang sama: baris batching di read,
glob, grep, webfetch, dan websearch berubah dari "can be
batched" menjadi "by default", edit dan write mendapat catatan
penerbitan paralel (edit yang tumpang tindih pada file yang
sama tetap berurutan), peluncuran konkuren milik task menjadi
default yang dinyatakan, dan bagian shell yang dirender
menyatakan perintah independen berjalan paralel secara default. Hanya teks instruksi — tanpa perubahan
kode.

**19. `0019-explore-parallel-prompt.patch` — kartu milik agen
explore sendiri belajar aturan dua tangan.** Agen yang punya
prompt sendiri tidak mewarisi `default.txt`: teks sistem milik
subagen explore adalah `src/agent/prompt/explore.txt`, dan ia
masih milik upstream — alatnya didaftar satu per satu, tanpa
satu kata pun soal paralel — padahal explore adalah pekerja
pencarian bervolume tertinggi di sistem ini. Prompt itu
mendapat aturan paralel rumah ini sebagai pedoman pertamanya:
panggilan Glob, Grep, dan Read yang independen berangkat
bersama dalam satu blok dan berjalan pada saat yang sama;
sebuah panggilan menunggu hanya bila inputnya bergantung pada
hasil sebelumnya. Baris-baris alatnya diselaraskan dengan
deskripsi tool pada saat yang sama: Read mendaftar isi
direktori, dan Bash dicadangkan untuk pemeriksaan read-only
yang tidak dicakup tool khusus. Baris upstream yang menyuruh
explore memakai Bash "for file operations like copying,
moving, or listing directory contents" bertentangan dengan
deskripsi tool dan dengan aturan read-only milik explore
sendiri di bagian bawah file yang sama. Prompt agen bawaan
lainnya — title, summary, compaction — berjalan dengan semua
tool ditolak, jadi tidak ada yang bisa diparalelkan di sana;
ketiganya tidak disentuh.

**20. `0020-delegation-first-prompts.patch` — tata kerja rumah
ini: delegasi dulu, batch kemudian.** Prompt utama kini
menyatakan hierarkinya secara terang-terangan. `default.txt`
mendapat aturan delegasi di atas aturan paralel: pekerjaan
yang punya spesialis pergi ke spesialis itu lewat tool task —
pencarian dan pemahaman codebase ke agen explore, satu unit
pekerjaan multi-langkah yang utuh ke agen general — setiap
delegasi membawa brief yang lengkap, dan hasilnya diverifikasi
sebelum apa pun dibangun di atasnya; pekerjaan langsung
dicadangkan untuk yang kecil, sudah diketahui tempatnya, dan
pasti, atau yang delegasinya lebih mahal daripada pekerjaannya
sendiri. Aturan paralel tetap ada, dengan penurunan tingkat
yang eksplisit: ia adalah tingkat di bawah delegasi, yang
mengatur pekerjaan yang dikerjakan langsung, dan pengingat
penutup mengatakan hal yang sama dalam satu baris. Kartu milik
para pekerja diperkuat ke arah sebaliknya — di dalam sebuah
brief, batching adalah hukum pertama: aturan paralel milik
explore naik ke baris-baris pembukanya, dan agen general
menerima prompt-nya sendiri untuk pertama kalinya
(`src/agent/prompt/general.txt`, disambungkan di `agent.ts`),
mandiri seperti milik explore, dengan paralel-secara-default
sebagai pedoman pertamanya; sampai kini general diam-diam
mewarisi `default.txt`. Pengingat plan mode (`plan.txt`,
`plan-mode.txt`) diselaraskan ke tata yang sama: perencanaan
mendelegasikan lebih dulu — eksplorasi ke agen explore,
validasi desain ke agen general, secara paralel bila
independen — dan pembacaan langsung adalah tingkat
cadangannya. Prompt milik agen-agen hidden tetap tidak
disentuh, seperti biasa.

---

Catatan untuk pembaca yang teliti: README ini bukan patch.
`scripts/apply-patches.sh` hanya membaca file `*.patch`, jadi halaman
ini tidak pernah diterapkan ke apa pun. Ia ada di sini untuk mata
manusia.
