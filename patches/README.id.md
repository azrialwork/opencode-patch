<p align="center"><a href="README.md">🇬🇧 English</a> · 🇮🇩 <b>Bahasa Indonesia</b></p>

# ✂️📋 Daftar Potongan Si Penjahit

Selamat datang di buku catatan si penjahit! 📖

Setiap file di folder ini yang berakhiran `.patch` adalah **satu resep potongan**.
Saat robot baru dibangun, robot pembangun membaca daftar ini
**dari nomor 1 sampai nomor 13**, berurutan, dan melakukan semua potongannya.

🛑 **Aturan emas:** kalau satu resep saja tidak pas, *semuanya berhenti*.
Tidak ada robot yang dikirim. Robot setengah terpotong lebih buruk daripada tidak ada robot.

Mau versi ceritanya dulu? Baca [buku ceritanya](../README.id.md). 📚

---

## 🧵 Ke-13 resep

### 1. 🏪 `0001-remove-builtin-providers.patch`
*Tutup pameran mainan raksasa.*
Semua toko AI bawaan dihapus — daftar modelnya, kuncinya, kode pembantunya.
Hanya toko kecil yang gratis (`opencode`, Zen) yang tersisa, plus toko apa pun yang kamu bangun sendiri.

### 2. 🪟 `0002-cli-tui-only.patch`
*Copot jendela-jendelanya.*
Halaman web dihapus: tidak ada lagi `web`, `serve`, atau `attach`, dan tidak ada terowongan rahasia
yang meminjam halaman dari `app.opencode.ai`. Robot hanya tinggal di terminal.

### 3. 🐙 `0003-remove-github-integration.patch`
*Pulangkan guritanya.*
Pembantu `opencode github` dan pembantu `opencode pr` dihapus,
beserta alat khusus guritanya (`@octokit/*`, `@actions/github`).
`git` biasa tidak disentuh.

### 4. 🔤 `0004-remove-lsp.patch`
*Guru bahasa pensiun.*
Seluruh dunia language server dihapus: rumah si guru (`src/lsp/`),
buku-buku unduhannya, alat `lsp`, bisikan setelah mengedit, kunci config `lsp`,
pintu `/lsp`, dan penghitung kecilnya di TUI.
(Warna *gambar* kode milik robot tetap ada — itu tinggal di tempat lain.)

### 5. 🔌 `0005-remove-acp.patch`
*Cabut colokan penerjemah.*
Pintu `opencode acp` dan seluruh ruangannya (`src/acp/`) dihapus,
plus colokannya (`@agentclientprotocol/sdk`) dan tes-tesnya.

### 6. 📤 `0006-remove-share.patch`
*Tidak ada kartu pos lagi.*
Berbagi sesi dihapus: layanan share, pintu `/session/{id}/share`,
stiker `share` di setiap percakapan, kunci config `share`/`autoshare`,
bendera `OPENCODE_AUTO_SHARE`, dan tombol share di TUI.

### 7. 🔄 `0007-remove-upgrade-uninstall.patch`
*Robot berhenti membangun ulang dirinya.*
Kata `upgrade` dan `uninstall`, pelayan `Installation`, pintu `/global/upgrade`,
lonceng update di TUI, dan kunci config `autoupdate` dihapus —
agar robot dari luar tidak akan pernah bisa menimpa robot buatan penjahit kami.

### 8. 📡 `0008-remove-opentelemetry.patch`
*Matikan radio kecilnya.*
Radio pengirim laporan (exporter OTLP) dan baterainya
(`@opentelemetry/*`, `@effect/opentelemetry`) dihapus, plus kunci config
`experimental.openTelemetry` dan bendera `OTEL_*`.
Catatan yang robot tulis untuk *dirinya sendiri* di rumah (logging lokal) tetap ada.

### 9. 📥 `0009-remove-import.patch`
*Tutup pintu buku harian lama.*
Perintah `opencode import` — yang membawa masuk percakapan lama dari file —
dihapus, beserta tes-tesnya.

### 10. 🖼️ `0010-remove-photon-image.patch`
*Gambar bepergian apa adanya.*
Mesin pengempis foto kecil (`@silvia-odwyer/photon-node`) dan kedua
pekerjanya dihapus. Gambar tidak lagi dibuka, diubah ukurannya, atau dimasak ulang;
mereka lewat persis seperti saat datang. Kunci config gambar ikut hilang bersamanya.

### 11. 🔑 `0011-remove-zen-login-billing.patch`
*Kasirnya pulang.*
Perintah `opencode console` dan seluruh dunia akun dihapus:
masuk dengan kode rahasia, penyimpanan akun dan organisasi, config kiriman
dari console, pintu `/experimental/console*`, dan pemindah organisasi di TUI.
Model gratis tetap bekerja — tanpa nama, tanpa tagihan.

### 12. 🍬 `0012-zen-free-tier-only.patch`
*Hanya permen gratis yang tersisa.*
Di dua tempat daftar permen toko ditulis (saat robot dibangun,
dan saat ia mengambil daftarnya), hanya permen yang harganya **nol di semua rak**
dan tidak basi (`deprecated`) yang boleh tinggal. Model Zen berbayar dihapus
dari datanya langsung. Permen dari tokomu sendiri tidak pernah disentuh.

### 13. ⌨️ `0013-remove-pty.patch`
*Hilangkan ruang ketik yang kosong.*
Pseudo-terminal (PTY) dihapus sampai ke akar: layanan core-nya, motor
`bun-pty`/`@lydell/node-pty`-nya, pintu `/pty` dan kunci tiketnya,
jembatan plugin, tipe skema, dan client SDK.
Layarnya dulu menempel di halaman web (potongan #2), dan alat Bash tidak pernah memakainya.

---

> 🗒️ **Catatan kecil:** README ini *bukan* patch.
> `scripts/apply-patches.sh` milik para pembangun hanya membaca file `*.patch`,
> jadi halaman ini hanya untuk mata manusia. Seperti matamu. Halo! 👀
