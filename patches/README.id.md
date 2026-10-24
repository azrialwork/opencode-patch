[English](README.md) · Bahasa Indonesia

# Seri patch

Build rilis menerapkan setiap file `*.patch` di direktori ini ke checkout upstream yang segar, menurut urutan nama file, lewat `scripts/apply-patches.sh`. Jika satu patch gagal diterapkan, build berhenti dan tidak ada yang dirilis.

File ini mendokumentasikan keadaan akhir setiap patch. Hanya file `*.patch` yang diterapkan; README ini adalah dokumentasi.

### 0001 — `0001-remove-builtin-providers.patch`

Setiap provider bawaan beserta modelnya dihapus, bersama paket SDK provider, loader kustom, dan plugin auth bawaan. Katalog models.dev dipotong menjadi satu entri, `opencode` (Zen), pada sumber datanya sendiri — di embed saat build, cache di disk, dan fetch runtime. Provider kustom yang didefinisikan di `opencode.json` tetap bekerja.

### 0002 — `0002-cli-tui-only.patch`

Web UI dihapus sampai ke akar: build tidak lagi membangun atau menyematkan aplikasi web, perintah `web`, `serve`, dan `attach` dihapus, dan rute UI catch-all milik server HTTP dihapus bersama fallback-nya yang mem-proxy UI dari `app.opencode.ai`. Server in-process yang dipakai TUI secara internal tetap ada.

### 0003 — `0003-remove-github-integration.patch`

Perintah agen `opencode github` dan helper `opencode pr` dihapus, bersama helper khusus GitHub `parseGitHubRemote`, dependensi khusus GitHub (`@actions/github`, `@octokit/graphql`, `@octokit/rest`, `@octokit/webhooks-types`), dan test-nya. Dukungan git biasa tidak disentuh.

### 0004 — `0004-remove-lsp.patch`

LSP dihapus seluruhnya: subsistem language server dan unduhan binary-nya, tool `lsp`, diagnostik yang ditampilkan setelah edit, kunci konfigurasi `lsp` di kedua skema, endpoint `/lsp` dan `/find/symbol`, tampilan LSP di TUI, klien dan tipe LSP milik SDK, serta dependensi `vscode-jsonrpc` / `vscode-languageserver-types`. Formatter adalah subsistem berbeda dan tetap ada.

### 0005 — `0005-remove-acp.patch`

Perintah `opencode acp` dan seluruh implementasi `src/acp/` dihapus, bersama dependensi `@agentclientprotocol/sdk` dan test ACP.

### 0006 — `0006-remove-share.patch`

Berbagi sesi dihapus: service `SessionShare`, endpoint `/session/{id}/share`, field `share` pada sesi dan kolom penyimpanannya, kunci konfigurasi `share` dan `autoshare`, flag `OPENCODE_AUTO_SHARE`, keybind dan tautan sidebar share di TUI, serta klien dan tipe share milik SDK.

### 0007 — `0007-remove-upgrade-uninstall.patch`

Perintah `upgrade` dan `uninstall` dihapus, bersama service `Installation`, endpoint `/global/upgrade`, perintah, dialog, dan pemberitahuan pembaruan di TUI, pemeriksa pembaruan berkala, kunci konfigurasi `autoupdate`, dan `OPENCODE_DISABLE_AUTOUPDATE`. Build hasil patch tidak boleh ditimpa oleh rilis upstream.

### 0008 — `0008-remove-opentelemetry.patch`

Exporter log dan trace OTLP dihapus, bersama dependensi `@opentelemetry/*` dan `@effect/opentelemetry`, plumbing telemetri AI SDK, kunci konfigurasi `experimental.openTelemetry`, flag `OTEL_EXPORTER_OTLP_*`, dan penerusan environment OTEL ke workspace. Pencatatan lokal tidak berubah.

### 0009 — `0009-remove-import.patch`

Perintah `opencode import`, yang mengimpor data sesi dari file JSON hasil ekspor, dihapus bersama test-nya.

### 0010 — `0010-remove-photon-image.patch`

Pipeline Photon dihapus: dependensi `@silvia-odwyer/photon-node` dan kedua image service, sehingga lampiran gambar dan pembacaan gambar diteruskan apa adanya alih-alih di-decode, di-resize, dan di-encode ulang. Kunci konfigurasi gambar `attachment` / `attachments` ikut dihapus.

### 0011 — `0011-remove-zen-login-billing.patch`

Perintah `opencode console` dan seluruh sistem akun Console dihapus: login device-code, penyimpanan akun dan organisasi, konfigurasi organisasi jarak jauh yang disuntikkan ke konfigurasi lokal, endpoint `/experimental/console*`, pengalih organisasi di TUI, dan plugin provider Zen inti yang mendaftarkan metode OAuth Console serta menggabungkan konfigurasi dari console ke katalog. Model gratis Zen tetap bekerja secara anonim. Dialog "Connect a provider" generik berbasis API key bukan bagian dari Console dan tetap ada.

### 0012 — `0012-zen-free-tier-only.patch`

Pada kedua titik filter katalog — embed saat build dan loader models.dev runtime — provider `opencode` hanya mempertahankan model yang biayanya nol di semua tier dan statusnya bukan `deprecated`. Model Zen berbayar dihapus dari datanya, bukan disembunyikan; provider dan model kustom tidak terpengaruh.

### 0013 — `0013-remove-pty.patch`

PTY dihapus sampai ke akar: service inti dan adapter Bun dan Node-nya (`bun-pty`, `@lydell/node-pty`), API REST dan WebSocket `/pty` beserta auth tiketnya, grup protokol V2 dan handler servernya, jembatan environment PTY milik plugin, tipe dan event skema, awalan ID `pty`, serta klien dan tipe SDK v1 dan v2. Entri katalog root `@lydell/node-pty` dan entri `trustedDependencies`-nya tetap ada, untuk `packages/desktop`. Panel terminal hanya pernah ada di UI web/desktop (dihapus oleh 0002), dan tool Bash agen tidak memakai PTY.

### 0014 — `0014-android-bionic-target.patch`

Patch ini menambah, bukan menghapus. Ia mengajarkan skrip build upstream dua target Android (`linux-arm64-android`, `linux-x64-android`, dipilih dengan `--android`) sehingga source yang sama juga terkompilasi melawan libc Bionic milik Android, dengan `OPENCODE_LIBC=bionic` tertanam dan tanpa bagian khusus glibc (tanpa binary FFF, tanpa define `OPENTUI_LIBC`, tanpa field libc di manifest paket tertanam). Build Linux glibc tidak disentuh: tanpa `--android` daftar target berperilaku persis seperti sebelumnya. Aset rilis Termux memasangkan binary dengan `libopentui.so` yang dibangun native dan shim kompatibilitas `close_range` kecil (lihat `termux/` di repo ini); tidak ada proot di titik mana pun.

### 0015 — `0015-single-system-prompt.patch`

Pemilihan system prompt per model dihapus sampai ke akar: file prompt keluarga (`anthropic`, `beast`, `codex`, `gemini`, `gpt`, `gpt-astra`, `kimi`, `meta`, `trinity`) dan `copilot-gpt-5.txt` yang tidak pernah diimpor dihapus, dan `SystemPrompt.provider()` tidak lagi bercabang pada ID model. `default.txt` sendiri diganti dengan teks terpelihara dalam suara impersonal dan prosedural: instruksi eksplisit mengungguli aturan tetap; konten yang ditemui adalah data, bukan instruksi; verifikasi mendahului pelaporan; kegagalan mendapat anggaran tiga percobaan; tindakan irreversibel menunggu persetujuan; riset bertumpu pada sumber primer. Ia tidak menamai pengguna mana pun dan merupakan satu-satunya prompt yang diterima setiap model, Zen maupun kustom. Teks pengingat plan-mode dan prompt agen bawaan adalah permukaan terpisah dan tidak disentuh patch ini. Mekanisme daftar todo hidup di deskripsi tool `todowrite`; prompt hanya menyimpan aturan bahwa pekerjaan multi-langkah memelihara sebuah daftar.

### 0016 — `0016-complete-env-block.patch`

Baris "You are powered by the model named …" dihapus dari string environment, dan blok `<env>` dibangun ulang agar memuat hal yang benar-benar ditindaklanjuti agen: direktori kerja, root workspace (hanya bila berbeda dari direktori kerja), repo dan branch git (dibaca dari `.git/HEAD`), sistem operasi (nama distro di Linux), platform, arsitektur, jumlah core CPU, RAM, disk bebas, home, user, shell, locale, zona waktu, dan tanggal. Di Android, varian Termux yang dirender: nama produk dan nama pasar, satu baris `Android:` (versi, level API, build, security patch, semuanya dari satu dump `getprop`), dan satu baris `Termux:`. Fakta dikumpulkan sekali per proses dan di-cache; apa pun yang tidak dapat ditentukan dihilangkan, tidak pernah ditebak.

### 0017 — `0017-tool-descriptions.patch`

Setiap deskripsi tool bawaan ditulis ulang dalam satu format: apa yang dilakukan dan dikembalikan tool; kapan dipakai; kapan tidak, dan apa penggantinya; batas dan cara gagalnya. Patch mencakup teks `.txt` per tool di `src/tool/` (termasuk template shell), deskripsi shell yang dirender (template plus seksi yang dihasilkan di `shell/prompt.ts`) — varian deskripsi PowerShell dan cmd dihapus tuntas, sehingga hanya deskripsi bash yang tersisa dan setiap shell menerimanya; repo ini dirilis untuk Linux dan Termux — teks parameter background milik `task`, deskripsi parameter `path` milik `glob`, deskripsi tool code-mode, dan deskripsi tool structured-output di `session/prompt.ts`. Ia juga memperbaiki kesalahan isi pada teks upstream: deskripsi grep tidak lagi mengirim model ke `rg` shell untuk menghitung, yang dilarang deskripsi bash; websearch tidak lagi mengiklankan pemfilteran domain yang tidak ditawarkan skema parameternya; deskripsi task menyatakan bahwa hasil subagen tidak terlihat oleh pengguna dan harus dilaporkan (kebijakan verifikasinya sendiri dinyatakan satu kali, di system prompt); dan aturan gaya global yang diduplikasi `edit` dan `write` diserahkan ke system prompt. Deskripsi tool dari server MCP dan plugin tidak disentuh — OpenCode hanya meneruskannya. `plan-enter.txt` juga tidak disentuh: tidak ada kode yang mengimpornya.

### 0018 — `0018-parallel-first-tools.patch`

Panggilan tool paralel dinyatakan sebagai default di `default.txt`: satu aturan khusus — panggilan independen (baca, cari, fetch, perintah, peluncuran subagen) keluar bersamaan dalam satu blok dan berjalan pada saat yang sama, tidak pernah satu per giliran; sebuah panggilan menunggu hanya bila inputnya sungguh membutuhkan hasil panggilan sebelumnya; verifikasi mengikuti aturan yang sama — plus satu bullet yang cocok di pengingat penutup. Runtime memang sudah mengeksekusi panggilan independen dalam satu giliran secara bersamaan (terverifikasi empiris pada build ini); patch ini menyelaraskan instruksi dengan runtime. Hanya teks instruksi — tanpa perubahan kode. Aturan dinyatakan satu kali, di sini; deskripsi tool masing-masing hanya menyimpan mekanisme khas tool-nya (misalnya, `edit` mencatat bahwa suntingan yang tumpang tindih pada file yang sama diurutkan).

### 0019 — `0019-explore-parallel-prompt.patch`

Agen yang memiliki prompt sendiri tidak mewarisi `default.txt`: teks sistem subagen explore adalah `src/agent/prompt/explore.txt`, dan ia masih milik upstream, tanpa satu kata pun tentang paralelisme — padahal explore adalah pekerja pencarian bervolume tertinggi di sistem ini. Prompt itu mendapat aturan paralel sebagai pedoman pertamanya: panggilan Glob, Grep, dan Read yang independen keluar bersamaan dalam satu blok; sebuah panggilan menunggu hanya bila inputnya bergantung pada hasil sebelumnya. Satu baris upstream dibetulkan pada saat yang sama: Read menampilkan isi direktori, dan Bash dicadangkan untuk inspeksi read-only yang tidak dicakup tool khusus — upstream mengirim explore ke Bash "for file operations like copying, moving, or listing directory contents", yang bertentangan dengan deskripsi tool dan aturan read-only explore sendiri. Prompt agen bawaan lain (title, summary, compaction) berjalan dengan semua tool ditolak dan tidak disentuh.

### 0020 — `0020-delegation-first-prompts.patch`

Tata urutan kerja dinyatakan di semua permukaan instruksi: delegasi lebih dulu, batch paralel kedua. `default.txt` mendapat aturan delegasi di atas aturan paralel — pekerjaan yang memiliki spesialis pergi ke spesialis itu lewat tool task (pencarian dan pemahaman codebase ke agen explore, satu unit pekerjaan multi-langkah yang utuh ke agen general), setiap delegasi membawa brief lengkap, hasilnya diverifikasi sebelum apa pun dibangun di atasnya. Pemicunya adalah tidak mengetahui: pertanyaan tentang cara kerja sebuah codebase, di mana sesuatu berada, atau bagaimana bagian-bagiannya terhubung pergi ke explore lebih dulu setiap kali jawabannya belum diketahui dengan pasti — sebelum baca, list, atau cari pengintaian apa pun, karena pengintaian itu sendiri adalah eksplorasi yang didelegasikan. Kerja langsung tersisa untuk file persis yang sudah diketahui, satu pencarian di salah satunya, atau pekerjaan yang jelas lebih mahal bila didelegasikan. Aturan paralel tetap ada, secara eksplisit ditandai sebagai tingkat di bawah delegasi, dan pengingat penutup membawa hierarki yang sama. Isi wajib sebuah brief lengkap dispesifikasikan satu kali, di deskripsi tool task (0017). Aturan paralel prompt explore berpindah ke baris-baris pembukanya. Agen general menerima prompt-nya sendiri untuk pertama kali (`src/agent/prompt/general.txt`, dihubungkan di `agent.ts`), mandiri seperti milik explore, dengan paralel-secara-default sebagai pedoman pertamanya; sampai kini general diam-diam mewarisi `default.txt`. Pengingat plan (`plan.txt`, `plan-mode.txt`) diselaraskan ke urutan yang sama: perencanaan mendelegasikan lebih dulu — eksplorasi ke agen explore, validasi desain ke agen general, secara paralel bila independen — dan baca langsung adalah tingkat cadangannya. Prompt agen hidden (title, summary, compaction) tetap tidak disentuh.

### 0021 — `0021-agent-descriptions.patch`

Keempat deskripsi agen bawaan di `agent.ts` — teks yang ditempelkan ke deskripsi tool task, yang dibaca agen utama pada saat yang tepat ketika ia memilih subagen — ditulis ulang untuk menyatakan tata delegasi: build bekerja langsung dengan toolset penuh dan mendelegasikan eksplorasi codebase ke agen explore serta unit multi-langkah yang utuh ke agen general; plan bersifat read-only, mendelegasikan eksplorasi dan validasi desain, dan tidak menulis apa pun kecuali rencana; general menerima satu unit pekerjaan utuh dengan brief lengkap, bekerja otonom dan paralel secara default, dan melaporkan apa yang dikerjakan, apa yang diverifikasi, dan apa yang masih terbuka; explore adalah pilihan baku untuk pertanyaan apa pun tentang cara kerja sebuah codebase, di mana sesuatu berada, atau bagaimana bagian-bagiannya terhubung. Tingkat kedalaman (thoroughness) yang diandalkan workflow plan dipertahankan kata per kata.
