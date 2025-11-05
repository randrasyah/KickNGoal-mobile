# KickNGoal - Football Shop - Mobile.ver

**Nama:** Fairuz Akhtar Randrasyah
**NPM:** 2406403955
**Kelas:** PBP D

## Tugas Individu

---

## Tugas 7

**1. Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.**

    Widget Tree: sederhananya merupakan blueprint dari keseluruhan UI kita. Flutter menyusun UI dalam sebuah hierarki, di mana setiap elemen—mulai dari tombol, teks, padding, hingga keseluruhan halaman—adalah sebuah Widget. Widget tree ini adalah struktur yang memberi tahu Flutter bagaimana cara merender elemen-elemen tersebut di layar.

    Hubungan Parent-Child:
    - Parent: widget yang membungkus widget lain. Contohnya dalam kode, Column adalah parent dari Row, SizedBox, dan Center.
    - Child: widget yang berada di dalam parent.
    
    Hubungan ini penting karena parent memiliki kendali atas child-nya. Parent yang menentukan batasan/constraints untuk child, misal untuk set batasan panjang atau misal alignmentnya harus center. Child kemudian memutuskan bagaimana ia akan tampil di dalam batasan yang diberikan oleh parent-nya. Misalnya, Center (parent) memerintahkan Column (child) untuk berada di tengah.

**2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.**

    Widget Utama & Struktur:
    - MyApp: Widget root custom (StatelessWidget) yang memulai seluruh aplikasi.
    - MaterialApp: Widget inti dari Material Design. Fungsinya menyediakan fondasi aplikasi, termasuk navigasi (routes), tema (ThemeData), dan widget home awal.
    - MyHomePage: Widget custom (StatelessWidget) yang berisi tampilan halaman utama.
    - Scaffold: Menyediakan struktur dasar halaman yang standar, seperti AppBar (bilah atas) dan body (konten halaman).

    Widget Layout:
    - Padding: Memberi jarak di sekeliling child-nya.
    - Column: Menyusun children-nya secara vertikal.
    - Row: Menyusun children-nya secara horizontal.
    - SizedBox: Membuat kotak kosong dengan ukuran tertentu, biasanya digunakan untuk memberi jarak antar widget.
    - Center: Menempatkan child-nya di tengah-tengah area.
    - GridView: Menyusun children-nya dalam format grid yang bisa di-scroll.
    - Container: Digunakan di InfoCard sebagai sebuah kotak yang bisa diatur width, height, padding, dan dekorasi lainnya.

    Widget Tampilan & Interaksi:
    - AppBar: Toolbar aplikasi di bagian atas layar.
    - Text: Menampilkan string teks.
    - Icon: Menampilkan icon grafis dari library Material Icons.
    - Material: Digunakan di ItemCard untuk menyediakan properti visual Material Design seperti warna latar, elevasi (bayangan), dan bentuk (borderRadius).
    - InkWell: Digunakan di ItemCard untuk membuat child-nya bisa diklik dan memberikan efek visual ripple saat disentuh.

    Widget Custom:
    - InfoCard: Widget untuk menampilkan card berisi title dan content (untuk NPM, Nama, Kelas).
    - ItemCard: Widget untuk menampilkan satu item di dalam GridView (ikon dan nama).

    Utility dll.:
    - ThemeData: Mengkonfigurasi tema visual (warna, font) untuk MaterialApp.
    - ColorScheme: Bagian dari ThemeData yang spesifik mengatur skema warna (seperti primary dan secondary).
    - ScaffoldMessenger: Digunakan di ItemCard untuk mengelola tampilan SnackBar.
    - SnackBar: Pesan sementara yang muncul di bagian bawah layar.
    - MediaQuery: Digunakan di InfoCard untuk mendapatkan informasi tentang layar, seperti lebarnya (MediaQuery.of(context).size.width), agar card bisa responsif.

**3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.**

    MaterialApp adalah widget fondasi yang membungkus semua fitur yang diperlukan untuk membangun aplikasi dengan gaya Material Design. Fungsi utamanya adalah:
        - Mengatur Tema: Menyediakan ThemeData global yang bisa diakses oleh semua widget di bawahnya, sehingga tampilan (warna, font) konsisten.
        - Manajemen Navigasi: Menyiapkan sistem routing (perpindahan halaman) menggunakan Navigator.
        - Konfigurasi Aplikasi: Mengatur judul aplikasi (yang terlihat di task manager OS), halaman home, dan pengaturan locale (bahasa).

    Mengapa Menjadi Root: MaterialApp harus berada root karena ia menyediakan BuildContext yang esensial. Banyak widget Material Design lainnya (seperti Scaffold, Navigator, Theme.of(context)) bergantung pada MaterialApp untuk bisa berfungsi. Mereka perlu mencari ke atas dalam widget tree untuk menemukan ThemeData atau Navigator yang disediakan oleh MaterialApp. Tanpa MaterialApp sebagai parent, widget-widget tersebut akan error karena tidak menemukan konteks yang mereka butuhkan.

**4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?**

    StatelessWidget: Widget yang immutable (statis/tidak bisa berubah). Setelah dibuat, properti dan tampilannya tidak bisa diubah dari dalam widget itu sendiri.
        - Cara Kerja: Hanya memiliki satu metode utama, yaitu build(). Metode build() ini hanya akan dipanggil ulang jika konfigurasi yang diterima dari parent-nya berubah.
        - Contoh: Text("Halo"), Icon(Icons.add), atau InfoCard dan ItemCard dalam kode saya (karena data di dalamnya final dan di pass dari MyHomePage).

    StatefulWidget: Widget yang mutable (dinamis/bisa berubah). Widget ini bisa mengelola data internal (disebut State) yang bisa berubah selama runtime.
        - Cara Kerja: Terdiri dari dua kelas: Widget (konfigurasinya) dan State (datanya). Ketika data di dalam State perlu diubah (misalnya karena user menekan tombol), kita memanggil fungsi setState(). Call ini memberi tahu Flutter bahwa datanya telah berubah, dan Flutter akan memanggil ulang metode build() dari State tersebut untuk memperbarui UI.
        - Contoh: Checkbox, TextField (form input), Slider, atau halaman yang mengambil data dari internet (statusnya berubah dari loading menjadi success).

    Kapan Memilih yang Mana?
    - Gunakan StatelessWidget jika UI hanya bergantung pada informasi yang di-passing oleh parent-nya dan tidak pernah berubah secara internal. (Contoh: Menampilkan nama, judul, gambar statis).

    - Gunakan StatefulWidget jika UI widget tersebut perlu berubah berdasarkan interaksi pengguna di dalam widget itu sendiri, atau berdasarkan data internal yang berubah seiring waktu. (Contoh: Counter yang angkanya bertambah, form yang diisi pengguna).

**5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?**

    BuildContext sederhananya adalah alamat atau lokasi sebuah widget di dalam widget tree. BuildContext memberi tahu widget di mana posisinya saat ini relatif terhadap widget lain (parent dan children).

    Mengapa Penting? BuildContext penting karena ia adalah pegangan yang digunakan widget untuk berinteraksi dengan environmentnya di dalam tree. Fungsi utamanya adalah untuk mencari widget atau service lain yang berada di atasnya (di level parent atau ancestor).

    Penggunaannya di build(): Setiap metode build menerima BuildContext context sebagai parameter. Context inilah yang kita gunakan untuk meminta sesuatu dari tree.

    Contoh dalam kode:
    - Theme.of(context): "Context, tolong carikan ThemeData terdekat di atas saya."
    - MediaQuery.of(context): "Context, tolong berikan saya informasi layar (MediaQuery) terdekat."
    - ScaffoldMessenger.of(context): "Context, tolong carikan ScaffoldMessenger terdekat di atas saya."

    Tanpa context, sebuah widget akan terisolasi dan tidak tahu apa-apa tentang tree di sekitarnya.

**6. Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".**

    Hot Reload: Proses menyuntikkan file kode yang baru diubah ke dalam Dart Virtual Machine (VM) yang sedang berjalan. Flutter memperbarui class dan function di memori, lalu secara otomatis memicu build() ulang untuk widget tree. Perubahan UI (layout, warna, teks) terlihat instan (seringkali kurang dari 1 detik).
        - Kelebihan: Sangat cepat dan menjaga state aplikasi. Jika kita sedang mengisi form di halaman ketiga, setelah hot reload, kita akan tetap di halaman ketiga dengan form yang masih terisi.
        - When to use: Paling sering digunakan. Ideal untuk tweaking UI, memperbaiki layout, dan iterasi desain cepat.

    Hot Restart: Proses menghancurkan Dart VM yang sedang berjalan dan membuat yang baru, lalu menjalankan ulang aplikasi dari awal (main()). Kode aplikasi di-compile ulang (tapi lebih cepat dari cold boot) dan seluruh state aplikasi di-reset. Aplikasi dimulai ulang ke halaman awal.
        - Kelebihan: Berguna ketika hot reload tidak cukup.
        - When to use: Digunakan ketika kita mengubah sesuatu yang hot reload tidak bisa tangani, seperti mengubah state global, mengubah main(), atau mengubah initState() pada StatefulWidget (karena initState() tidak dijalankan ulang oleh hot reload).

    Perbedaan Utamanya adalah State (Data). Hot Reload menjaga state (aplikasi tidak di-reset) sedangkan Hot Restart menghancurkan state (aplikasi di-reset ke awal).