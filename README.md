
# Pengalaman Mengerjakan Assignment dan pelajaran
Selama ngerjain assignment kemarin, aku cukup senang karena prosesnya lumayan seru. Meskipun ada bagian yang bikin mikir keras, tapi secara keseluruhan aku enjoy. Assignment ini lumayan bantu aku buat nge-refresh materi yang sebelumnya udah pernah aku pelajari. Nah, pas liburan kemarin, aku juga nyempetin buat belajar Flutter lagi. Aku ngikutin playlist di YouTube yang menurutku penjelasannya enak banget dan cukup lengkap. Buat yang mau cek, ini link playlist-nya: https://www.youtube.com/watch?v=DR4Vuu_VSZA&list=PL5jb9EteFAOAusKTSuJ5eRl1BapQmMDT6. --Tapi ini terlalu advance jadi belum selesai ditonton. Dari situ, aku mulai ngerti lagi cara ngebangun aplikasi Flutter dari awal.

Tapi, pas mulai ngerjain project sendiri, ternyata nggak semudah yang ada di video. Awalnya sih file-file project yang aku bikin masih lumayan rapi, struktur folder juga jelas. Tapi makin lama, apalagi waktu mulai nambahin fitur baru, semua itu mulai berantakan. Kayaknya ini gara-gara aku masih suka asal tambahin kode tanpa mikirin strukturnya lagi. Akhirnya, ngerapiinnya malah makan waktu lebih lama dari yang aku kira, jadi ada yang belum aku rapihin sampai akhir.

Dari semua proses itu, aku nyadar kalau aku lebih nyaman ngerjain bagian frontend. Mungkin karena sebelumnya aku juga sering ngerjain desain visual, jadi bikin UI dan ngebagusin tampilan aplikasi tuh rasanya lebih asik aja. Di bagian frontend Flutter, aku juga sepertinya udah cukup paham.

Tapi begitu nyoba backend, apalagi yang udah mulai pake SharedPreferences buat nyimpen data, aku sering banget kebingungan. Kalau cuma model biasa sih aku masih bisa ikutin. Cuma pas masuk ke bagian yang agak kompleks, aku sering minta bantuan ke AI chatbot buat cari solusi. Mungkin karena belum terbiasa aja si, jadi harus sering-sering latihan biar lebih paham.


## Fitur-Fitur yang Ada

- **Tambah To Do**  
  Pengguna bisa nambah data to do baru. Model data dari to do ini berisi:
  - `id`: buat id to do-nya
  - `startDate`: tanggal mulai aktivitasnya
  - `endDate`: tanggal selesai atau deadline-nya
  - `title`: judul atau nama to do-nya
  - `description`: deskripsi atau catatan detail tentang tugasnya
  - `category`: kategori to do 
  - `isDone`: status to do, udah selesai atau belum

- **Edit & Hapus To Do**  
  To do yang udah ditambahkan bisa diubah atau dihapus lewat halaman **TodoDetail**. Jadi kalau ada yang salah input atau udah nggak perlu.

- **User Info Page**  
  Ada halaman khusus buat liat dan edit informasi user. Data yang bisa diedit di sini:
  - `foto profile`
  - `username`
  - `tanggal lahir`
  - `major` (jurusan)
  - `email`

---

## Third Party Libraries yang Dipakai

Berikut beberapa package yang aku pake di project ini, beserta fungsinya:

- **get**  
  Package ini dipakai buat state management, routing, dan dependency injection. Simpelnya, `get` bikin proses pindah halaman, ngatur data antar-widget, dan komunikasi antar-screen jadi lebih gampang dan clean.

- **shared_preferences**  
  Library ini buat nyimpen data secara lokal di device. Cocok buat app ini karena data yang ada tidak rumit.

- **intl**  
  Ini library buat formatting tanggal, waktu, dan angka sesuai locale. Aku gunain buat format tanggal di `startDate` dan `endDate`, supaya tampilannya lebih user-friendly (misal: 10 Mar 2025, bukan format yang ribet).

- **image_picker**  
  Package ini berguna buat ngambil gambar dari gallery atau kamera. Di app ini, aku rencanain buat ambil gambar profil user.

---

