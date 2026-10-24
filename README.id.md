# opencode-patch

Seri patch delta di atas [OpenCode](https://github.com/anomalyco/opencode) upstream. Repositori ini hanya berisi patch dan otomasi build — bukan fork. Setiap rilis mengambil source upstream `v1.x.x` stabil terbaru, menerapkan seri patch di [`patches/`](patches/), dan menerbitkan binary CLI hasil patch untuk Linux (glibc) dan Android/Termux (Bionic).

[English](README.md)

## Apa yang dilakukan patch-patch ini

Seri ini menghapus fitur dan provider sampai ke akarnya — kode, data, dan dependensi dihapus, bukan disembunyikan atau difilter — mempersempit katalog provider bawaan ke tier Zen gratis, menambahkan target build Termux native, dan mengganti permukaan instruksi (system prompt, blok environment, deskripsi tool, prompt agen, deskripsi agen) dengan teks yang dikelola di repo ini.

| # | Patch | Efek |
|---|-------|------|
| 0001 | remove-builtin-providers | Menghapus setiap provider bawaan kecuali Zen (`opencode`), paket SDK-nya, loader, dan plugin auth-nya. Katalog models.dev dipotong ke entri Zen pada sumber datanya. Provider kustom di `opencode.json` tidak terpengaruh. |
| 0002 | cli-tui-only | Menghapus Web UI: aplikasi web tidak lagi dibangun atau disematkan, dan perintah `web`, `serve`, dan `attach` dihapus. API in-process yang dipakai TUI secara internal tetap ada. |
| 0003 | remove-github-integration | Menghapus perintah `github`, helper `pr`, dan dependensi khusus GitHub. Dukungan git biasa tidak disentuh. |
| 0004 | remove-lsp | Menghapus subsistem LSP, tool `lsp`, kunci konfigurasinya, endpoint, dan dependensinya. Formatter adalah subsistem berbeda dan tetap ada. |
| 0005 | remove-acp | Menghapus perintah `acp`, implementasi ACP, dan dependensi SDK-nya. |
| 0006 | remove-share | Menghapus berbagi sesi: service, endpoint, kunci konfigurasi, dan klien SDK-nya. |
| 0007 | remove-upgrade-uninstall | Menghapus perintah `upgrade` dan `uninstall`, Installation service, dan pemeriksa pembaruan berkala. Build hasil patch tidak pernah ditimpa rilis upstream. |
| 0008 | remove-opentelemetry | Menghapus exporter OTLP, dependensi telemetri, dan kunci konfigurasinya. Pencatatan lokal tidak berubah. |
| 0009 | remove-import | Menghapus perintah `import`. |
| 0010 | remove-photon-image | Menghapus pipeline gambar Photon dan dependensinya; lampiran gambar diteruskan apa adanya. |
| 0011 | remove-zen-login-billing | Menghapus sistem akun Console: login device-code, penyimpanan akun, dan injeksi konfigurasi organisasi. Model Zen gratis tetap bekerja secara anonim. |
| 0012 | zen-free-tier-only | Mempersempit katalog Zen ke model yang berbiaya nol di semua tier dan tidak deprecated — sembilan model — pada kedua titik filter katalog (embed saat build dan loader runtime). |
| 0013 | remove-pty | Menghapus PTY sampai ke akar: service dan adapternya, API REST/WebSocket, grup protokol, dan klien SDK. Tool shell agen tidak memakai PTY. |
| 0014 | android-bionic-target | Menambahkan target Android ke skrip build upstream (`OPENCODE_LIBC=bionic`) plus pengemasan Termux: `libopentui.so` yang dibangun native dan shim kompatibilitas `close_range`. Tanpa proot. Build Linux glibc tidak terpengaruh. |
| 0015 | single-system-prompt | Menghapus sepuluh varian system prompt per model dan logika pemilihan berdasarkan ID model. `default.txt` diganti teks terpelihara yang mencakup presedensi dan kepercayaan, verifikasi sebelum pelaporan, anggaran kegagalan tiga percobaan, persetujuan untuk tindakan irreversibel, dan riset berbasis sumber primer. |
| 0016 | complete-env-block | Menghapus baris identitas model dari string environment dan membangun ulang blok `<env>` sebagai potret perangkat yang di-cache: direktori kerja, root workspace, branch git, OS/distro, arsitektur, core CPU, RAM, disk bebas, shell, locale, zona waktu, tanggal — dengan varian Android/Termux. Field yang tidak dapat ditentukan dihilangkan, tidak pernah ditebak. |
| 0017 | tool-descriptions | Menulis ulang setiap deskripsi tool bawaan dalam satu format: apa yang dilakukan dan dikembalikan tool, kapan dipakai, kapan tidak dan apa penggantinya, batas dan cara gagalnya. Deskripsi shell hanya menyisakan varian bash; varian PowerShell dan cmd dihapus. |
| 0018 | parallel-first-tools | Menyatakan panggilan tool paralel sebagai default di system prompt. Runtime memang sudah mengeksekusi panggilan independen dalam satu giliran secara bersamaan; teks kini memerintahkannya. |
| 0019 | explore-parallel-prompt | Menyelaraskan prompt milik agen explore sendiri (ia tidak mewarisi prompt utama) dengan aturan paralel, dan membetulkan panduan Bash-nya menjadi inspeksi read-only. |
| 0020 | delegation-first-prompts | Menetapkan tata urutan kerja di system prompt, kartu agen, dan pengingat plan: delegasi lebih dulu — pertanyaan codebase ke agen explore, unit multi-langkah yang utuh ke agen general — dengan batch paralel sebagai tingkat di bawahnya. Pemicu delegasi adalah tidak mengetahui jawabannya, bukan ukuran pertanyaannya. |
| 0021 | agent-descriptions | Menulis ulang keempat deskripsi agen bawaan di `agent.ts` — teks yang dibaca agen utama saat memilih subagen — agar menyatakan tata delegasi yang sama di titik pilihan itu dibuat. |

Detail per patch: [patches/README.id.md](patches/README.id.md).

## Instalasi

```sh
curl -fsSL https://raw.githubusercontent.com/azrialwork/opencode-patch/main/install.sh | bash
```

Installer mendeteksi platform — Linux glibc x64 (dengan build baseline untuk CPU tanpa AVX2), Linux arm64, atau Termux di Android (arm64) — mengunduh arsip yang sesuai, memverifikasi SHA256-nya terhadap `SHA256SUMS` milik rilis, dan memasang ke `/usr/local/bin` bila dapat ditulis, selain itu `~/.local/bin`.

| Opsi | Efek |
|------|------|
| `--version <tag>` | Memasang tag rilis tertentu alih-alih rilis terbaru. |
| `--install-dir <dir>` | Memasang ke direktori tertentu. |

Kedua opsi juga dapat diatur sebagai variabel lingkungan (`VERSION`, `INSTALL_DIR`).

Instalasi manual: unduh arsip dan `SHA256SUMS` dari [halaman rilis](https://github.com/azrialwork/opencode-patch/releases), jalankan `sha256sum -c SHA256SUMS`, ekstrak arsipnya, dan letakkan binary `opencode` di `PATH` Anda. Arsip Termux berisi launcher plus binary dan library native-nya di bawah `lib/opencode-patch/`; ekstrak sebagai satu kesatuan dan jalankan launcher-nya.

## Aset rilis

| Aset | Platform |
|------|----------|
| `opencode-linux-x64.tar.gz` | Linux glibc, x86-64 (AVX2) |
| `opencode-linux-x64-baseline.tar.gz` | Linux glibc, x86-64 tanpa AVX2 |
| `opencode-linux-arm64.tar.gz` | Linux glibc, arm64 |
| `opencode-termux-arm64.tar.gz` | Android/Termux, Bionic arm64 |
| `SHA256SUMS` | Checksum SHA256 semua arsip |

## Bagaimana rilis dibangun

- Workflow `Release` (`.github/workflows/release.yml`) berjalan setiap enam jam (cron `0 */6 * * *` UTC) dan lewat dispatch manual, dengan input opsional `version` dan `force`.
- Workflow menyelesaikan tag upstream `v1.x.x` stabil terbaru. Versi yang sudah dirilis repositori ini dilewati, kecuali `force` diatur.
- Patch diterapkan menurut urutan nama file **sebelum** `bun install`, dan install berjalan tanpa `--frozen-lockfile`, sehingga dependensi yang dihapus patch tidak pernah terinstall. Patch yang gagal diterapkan menggagalkan build; tidak ada yang dirilis.
- Job Termux membangun `libopentui.so` dari source OpenTUI v0.4.5 yang di-pin (Zig dan Android NDK, alignment halaman 16 KB) dan memverifikasi binary Bionic dengan `readelf`; dependensi glibc apa pun menggagalkan build.
- Aset dan `SHA256SUMS` diterbitkan sebagai rilis GitHub dengan tag versi upstream.

Konfigurasi pelacakan ada di [`upstream.json`](upstream.json). Basis saat ini: upstream `v1.19.4`, commit `148842ef7cb1bc34192b3fff57d0f9721ab9c801`.

## Hasil

Untuk upstream v1.19.4, binary Linux x64 hasil patch berukuran 159.951.024 byte, berbanding 214.526.128 byte untuk build upstream (−25,4%). Binary Termux berukuran 138.289.528 byte. Build Termux terverifikasi end-to-end pada perangkat Android 12 asli (instalasi, loop agen, TUI).

## Tata letak repositori

```
patches/     seri patch, bernomor, diterapkan menurut urutan nama file
scripts/     resolusi versi upstream, penerapan patch, pengemasan Linux
termux/      launcher Termux, shim close_range, patch build OpenTUI dan pengemasan
install.sh   installer satu perintah untuk binary rilis
upstream.json  konfigurasi repositori upstream dan pelacakannya
.github/workflows/release.yml  otomasi rilis
```

## Menambah patch

1. Buat perubahan di clone upstream yang dapat ditulis pada tag yang dilacak, dan uji.
2. Ekspor sebagai file bernomor berikutnya: `git diff > patches/NNNN-nama-singkat.patch`.
3. Dokumentasikan di [patches/README.id.md](patches/README.id.md).
4. Commit. Build terjadwal berikutnya akan menerapkannya.

Dua aturan mengatur seri ini. Sebuah patch menghapus sampai ke akar: ia menghapus kode, data, dan dependensi, bukan menyembunyikan atau memfilternya. Dan prompt agen hidden (title, summary, compaction) tidak pernah diubah; ketiganya tetap byte-identik dengan upstream.

## Lisensi

MIT, sama seperti OpenCode upstream. Lihat [LICENSE](LICENSE).
