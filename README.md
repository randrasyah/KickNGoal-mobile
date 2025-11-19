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

---

## Tugas 8

**1. Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement() pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?**

**Navigator.push():** Menambahkan halaman baru ke atas stack navigasi tanpa menghapus halaman sebelumnya. User dapat kembali ke halaman sebelumnya menggunakan tombol back.

**Navigator.pushReplacement():** Mengganti halaman saat ini dengan halaman baru. Halaman sebelumnya dihapus dari stack, sehingga user tidak bisa kembali ke halaman tersebut dengan tombol back.

**Penggunaan dalam Football Shop:**
- **Navigator.push()**: Digunakan ketika navigasi dari homepage ke form "Add Product" melalui button card. User bisa kembali ke homepage dengan tombol back setelah selesai mengisi form.
  ```dart
  // product_card.dart
  if (item.name == "Add Product") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const ProductFormPage(),
          ),
      );
  }
  ```

- **Navigator.pushReplacement()**: Digunakan dalam drawer navigation untuk pindah antar halaman utama (Home dan Add Product) untuk mencegah penumpukan halaman yang tidak perlu dalam stack.
  ```dart
  // left_drawer.dart
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MyHomePage(),
      )
  );
  ```

**2. Bagaimana kamu memanfaatkan hierarchy widget seperti Scaffold, AppBar, dan Drawer untuk membangun struktur halaman yang konsisten di seluruh aplikasi?**

Saya menggunakan hierarki widget untuk menciptakan struktur yang konsisten:

**Scaffold sebagai Foundation:** Setiap halaman menggunakan Scaffold sebagai struktur dasar yang menyediakan kerangka standar Material Design dengan AppBar dan body.

**AppBar yang Konsisten:** 
```dart
AppBar(
    title: const Text(
        'KickNGoal',
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
        ),
    ),
    backgroundColor: Theme.of(context).colorScheme.primary,
    iconTheme: const IconThemeData(color: Colors.black),
),
```

**Drawer Navigation:** Menggunakan LeftDrawer yang sama di semua halaman utama untuk navigasi konsisten:
```dart
drawer: const LeftDrawer(),
```

**Manfaat Hierarki Widget:**
- **Konsistensi Visual:** Semua halaman memiliki AppBar dengan style yang sama
- **Navigasi Unified:** Drawer tersedia di setiap halaman untuk akses cepat
- **Struktur Predictable:** User tau di mana menemukan elemen navigasi
- **Maintenance Mudah:** Perubahan pada LeftDrawer atau theme akan teraplikasi ke seluruh app

**3. Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.**

**Padding:** Memberikan ruang putih yang konsisten dan meningkatkan readability.
```dart
// product_form.dart
Padding(
  padding: const EdgeInsets.all(8.0),
  child: TextFormField(
    decoration: InputDecoration(
      hintText: "Product Name",
      labelText: "Product Name",
      // ...
    ),
  ),
),
```
*Kelebihan:* Mencegah elemen form menempel ke edge layar, memberikan breathing space yang membuat form lebih comfortable untuk digunakan.

**SingleChildScrollView:** Memungkinkan form untuk di-scroll ketika konten melebihi tinggi layar.
```dart
// product_form.dart dan menu.dart
body: SingleChildScrollView(
    child: Column(
        children: [
            ...
        ],
    ),
),
```
*Kelebihan:* Mencegah overflow error, memastikan semua form fields dapat diakses pada berbagai ukuran layar, dan memberikan UX yang smooth saat mengisi form panjang.

**ListView (dalam konteks Drawer):** Menyediakan scrollable list untuk navigation items.
```dart
// left_drawer.dart
Drawer(
  child: ListView(
    children: [
      DrawerHeader(...),
      ListTile(...),
      ListTile(...),
    ],
  ),
)
```
*Kelebihan:* Mengatur navigation items secara vertikal, automatically scrollable jika items terlalu banyak, dan memberikan tap interaction yang responsif.

**4. Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?**

Saya menggunakan pendekatan systematic color theming untuk menciptakan identitas visual yang konsisten:

**Global Theme Configuration:**
```dart
// main.dart
theme: ThemeData(
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: const Color(0xFFDCEDC8), // pastel green for navbar
    secondary: const Color(0xFFF9F9F9), // pastel yellow for secondary
  ),
),
```

**Konsistensi Warna Button:**
```dart
// menu.dart - yellow color scheme
final List<ItemHomepage> items = [
    ItemHomepage("All Products", Icons.shopping_bag, const Color(0xFFFFF59D)), // light yellow
    ItemHomepage("Add Product", Icons.add, const Color(0xFFFFF176)), // medium yellow  
    ItemHomepage("Logout", Icons.logout, const Color(0xFFFFEE58)), // darker yellow
];
```

**Konsistensi di Semua Komponen:**
```dart
// AppBar selalu menggunakan theme primary
backgroundColor: Theme.of(context).colorScheme.primary,

// drawer header matching dengan AppBar
decoration: const BoxDecoration(
  color: Color(0xFFDCEDC8), 
),
```

**Implementasi Konsisten di Seluruh Aplikasi:**
- **AppBar:** Menggunakan `Theme.of(context).colorScheme.primary` untuk konsistensi
- **Drawer Header:** Matching dengan AppBar menggunakan warna yang sama
- **Button Cards:** Gradasi yellow
- **Text Colors:** Black untuk contrast yang baik

**Filosofi Warna yang Dipilih:**
- **Green (Navbar):** Warna identik sepak bola dan kebugaran
- **Yellow (Buttons):** Complimentary color untuk hijau
- **Black Text:** Memberikan readability yang baik

Pendekatan ini memastikan bahwa setiap elemen visual mendukung identitas KickNGoal.

--

## Tugas 9

**1. Jelaskan mengapa kita perlu membuat model Dart saat mengambil/mengirim data JSON? Apa konsekuensinya jika langsung memetakan Map<String, dynamic> tanpa model (terkait validasi tipe, null-safety, maintainability)?**

**Mengapa Perlu Model Dart:**

Model Dart memberikan struktur yang kuat dan type-safe untuk data JSON. Dengan model, kita mendefinisikan kontrak yang jelas tentang bentuk data yang diharapkan.

**Keuntungan Menggunakan Model:**
- **Type Safety:** Dart compiler dapat mendeteksi kesalahan tipe data saat compile time
- **Auto-completion:** IDE dapat memberikan suggestion yang akurat untuk field yang tersedia
- **Validation:** Dapat menambahkan validasi custom di method fromJson()
- **Null Safety:** Dapat menentukan field mana yang nullable dan non-nullable
- **Maintainability:** Mudah untuk refactor dan mengubah struktur data

**Konsekuensi Tanpa Model (Map<String, dynamic>):**
```dart
// Tanpa model
Map<String, dynamic> product = jsonData;
String name = product['nama']; // Typo! seharusnya 'name'
int price = product['price']; // Runtime error jika price null
```

```dart
// Dengan model
ProductEntry product = ProductEntry.fromJson(jsonData);
String name = product.name; // Auto-completion, compile-time safety
int price = product.price; // Null safety terjamin
```

**Masalah Spesifik Tanpa Model:**
- **Runtime Errors:** Typo pada key string baru ketauan saat runtime
- **Null Pointer Exceptions:** Tidak ada jaminan field tidak null
- **Refactoring Difficulty:** Sulit tracking penggunaan field di seluruh aplikasi
- **No IntelliSense:** Tidak ada code completion untuk field

**2. Apa fungsi package http dan CookieRequest dalam tugas ini? Jelaskan perbedaan peran http vs CookieRequest.**

**Package HTTP:**
Package HTTP adalah library standar Dart untuk melakukan HTTP requests (GET, POST, PUT, DELETE). Ini adalah package dasar yang hanya menangani komunikasi HTTP mentah.

**CookieRequest (pbp_django_auth):**
CookieRequest adalah wrapper di atas HTTP client yang secara otomatis mengelola cookies dan session untuk integrasi dengan Django authentication.

**Perbedaan Peran:**

| Aspek | HTTP Package | CookieRequest |
|-------|--------------|---------------|
| **Cookie Management** | Manual | Otomatis |
| **Session Handling** | Tidak ada | Built-in |
| **Django Integration** | Manual setup | Plug-and-play |
| **Authentication** | Manual | Integrated login/logout |
| **CSRF Token** | Manual handling | Otomatis |

**Dalam KickNGoal:**
- **HTTP:** Bisa digunakan untuk request sederhana tanpa autentikasi
- **CookieRequest:** Digunakan untuk semua request yang memerlukan authentication (login, create product, filtered products)

**3. Jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.**

**Konsep State Management:**
CookieRequest menyimpan state global aplikasi, khususnya informasi authentication session dan cookies. Semua komponen yang butuh akses ke backend Django memerlukan instance yang sama.

**Mengapa Harus Dibagikan:**

1. **Session Consistency:** Semua request harus menggunakan session yang sama
```dart
// BAD - setiap widget punya instance berbeda
class WidgetA {
  final request = CookieRequest(); // Session terpisah
}
class WidgetB {
  final request = CookieRequest(); // Session terpisah
}

// GOOD - shared instance
Provider(
  create: (_) => CookieRequest(), // Satu instance untuk semua
  child: MyApp(),
)
```

2. **Login State Synchronization:** Ketika user login di satu halaman, semua halaman lain harus tahu user sudah login
3. **Cookie Persistence:** Cookies yang disimpan saat login harus tersedia di semua request selanjutnya
4. **Memory Efficiency:** Satu instance lebih efisien daripada multiple instances


**4. Jelaskan konfigurasi konektivitas yang diperlukan agar Flutter dapat berkomunikasi dengan Django. Mengapa kita perlu menambahkan 10.0.2.2 pada ALLOWED_HOSTS, mengaktifkan CORS dan pengaturan SameSite/cookie, dan menambahkan izin akses internet di Android? Apa yang akan terjadi jika konfigurasi tersebut tidak dilakukan dengan benar?**

**Konfigurasi yang Diperlukan:**

**1. ALLOWED_HOSTS (Django settings.py):**
```python
ALLOWED_HOSTS = ["localhost", "127.0.0.1", "10.0.2.2"]
```
- **10.0.2.2:** IP khusus Android emulator untuk mengakses localhost host machine
- **localhost/127.0.0.1:** Untuk web browser development

**2. CORS Configuration:**
```python
CORS_ALLOW_ALL_ORIGINS = True
CORS_ALLOW_CREDENTIALS = True
CSRF_COOKIE_SECURE = True
SESSION_COOKIE_SECURE = True
CSRF_COOKIE_SAMESITE = 'None'
SESSION_COOKIE_SAMESITE = 'None'
```

**3. Internet Permission (Android):**
```xml
<!-- android/app/src/main/AndroidManifest.xml -->
<uses-permission android:name="android.permission.INTERNET" />
```

**Penjelasan Setiap Konfigurasi:**

**ALLOWED_HOSTS:**
- Django memverifikasi Host header untuk mencegah HTTP Host header attacks
- 10.0.2.2 diperlukan karena Android emulator menggunakan network mapping khusus
- Tanpa ini, Django akan menolak request dengan error 400 Bad Request

**CORS (Cross-Origin Resource Sharing):**
- Browser memblokir request cross-origin secara default
- Flutter web development server dan Django server berbeda origin
- Tanpa CORS, Browser akan memblokir request dengan CORS error

**SameSite Cookie Settings:**
- Modern browser menerapkan SameSite cookie policy yang ketat
- `SameSite=None` memungkinkan cookies dikirim dalam cross-site requests
- Tanpa ini, Session cookies tidak akan dikirim, authentication gagal

**Internet Permission:**
- Android memerlukan explicit permission untuk network access
- Tanpa ini, Aplikasi tidak bisa membuat network requests sama sekali

**Konsekuensi Jika Tidak Dikonfigurasi:**

| Konfigurasi Missing | Konsekuensi |
|-------------------|-------------|
| ALLOWED_HOSTS | HTTP 400 Bad Request |
| CORS | Browser CORS policy error |
| Internet Permission | Network requests gagal total |
| SameSite Settings | Authentication/session tidak bekerja |

**5. Jelaskan mekanisme pengiriman data mulai dari input hingga dapat ditampilkan pada Flutter.**

**Alur Pengiriman Data:**

**1. Input Data di Flutter:**
```dart
// product_form.dart
final response = await request.postJson(
  "http://localhost:8000/create-product-ajax/",
  jsonEncode({
    'name': _name,
    'price': _price.toString(),
    'description': _description,
    // ... fields lainnya
  }),
);
```

**2. Request Dikirim ke Django:**
- Flutter mengemas data dalam JSON format
- CookieRequest menambahkan cookies dan headers yang diperlukan
- Data dikirim via HTTP POST request

**3. Proses di Django Backend:**
```python
# views.py
@csrf_exempt
@require_POST
def add_product_entry_ajax(request):
    name = strip_tags(request.POST.get("name"))
    price = request.POST.get("price")
    # ... validasi dan processing
    
    new_product = Product(
        name=name,
        price=price,
        user=request.user
    )
    new_product.save()
    return HttpResponse(b"CREATED", status=201)
```

**4. Response Kembali ke Flutter:**
- Django mengirim response (success/error)
- Flutter menerima dan memproses response
- Update UI berdasarkan hasil

**5. Refresh Data untuk Ditampilkan:**
```dart
// product_list.dart
Future<List<ProductEntry>> fetchProducts(CookieRequest request) async {
  final response = await request.get('http://localhost:8000/json/');
  // Convert JSON to ProductEntry objects
  List<ProductEntry> listProduct = [];
  for (var d in response) {
    if (d != null) {
      listProduct.add(ProductEntry.fromJson(d));
    }
  }
  return listProduct;
}
```

**6. Tampil di UI dengan FutureBuilder:**
```dart
FutureBuilder(
  future: fetchProducts(request),
  builder: (context, AsyncSnapshot snapshot) {
    if (snapshot.data == null) {
      return CircularProgressIndicator();
    } else {
      return ListView.builder(
        itemCount: snapshot.data!.length,
        itemBuilder: (_, index) => ProductCard(
          product: snapshot.data![index],
        ),
      );
    }
  },
)
```

**6. Jelaskan mekanisme autentikasi dari login, register, hingga logout. Mulai dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.**

**A. Mekanisme Register:**

**1. Input di Flutter (register.dart):**
```dart
final response = await request.postJson(
  "http://localhost:8000/auth/register/",
  jsonEncode({
    "username": username,
    "password1": password1,
    "password2": password2,
  })
);
```

**2. Proses di Django (authentication/views.py):**
```python
@csrf_exempt
def register(request):
    data = json.loads(request.body)
    username = data['username']
    password1 = data['password1']
    password2 = data['password2']
    
    # Validasi password match
    if password1 != password2:
        return JsonResponse({"status": False, "message": "Passwords do not match."})
    
    # Cek username exists
    if User.objects.filter(username=username).exists():
        return JsonResponse({"status": False, "message": "Username already exists."})
    
    # Create user
    user = User.objects.create_user(username=username, password=password1)
    user.save()
    
    return JsonResponse({"status": 'success', "message": "User created successfully!"})
```

**3. Response ke Flutter:**
- Jika sukses: Redirect ke LoginPage
- Jika gagal: Tampilkan error message

**B. Mekanisme Login:**

**1. Input di Flutter (login.dart):**
```dart
final response = await request.login(
  "http://localhost:8000/auth/login/",
  {
    'username': username,
    'password': password,
  }
);
```

**2. Proses di Django (authentication/views.py):**
```python
@csrf_exempt
def login(request):
    username = request.POST['username']
    password = request.POST['password']
    user = authenticate(username=username, password=password)
    
    if user is not None:
        if user.is_active:
            auth_login(request, user)
            return JsonResponse({
                "username": user.username,
                "status": True,
                "message": "Login successful!"
            }, status=200)
    else:
        return JsonResponse({
            "status": False,
            "message": "Invalid credentials."
        }, status=401)
```

**3. Session Management:**
- Django creates session dan set session cookie
- CookieRequest otomatis menyimpan cookies untuk request selanjutnya
- State `request.loggedIn` menjadi true

**4. Navigation ke HomePage:**
```dart
if (request.loggedIn) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => MyHomePage()),
  );
}
```

**C. Mekanisme Logout:**

**1. Trigger di Flutter (product_card.dart):**
```dart
final response = await request.logout(
  "http://localhost:8000/auth/logout/"
);
```

**2. Proses di Django (authentication/views.py):**
```python
@csrf_exempt
def logout(request):
    username = request.user.username
    try:
        auth_logout(request)
        return JsonResponse({
            "username": username,
            "status": True,
            "message": "Logged out successfully!"
        }, status=200)
    except:
        return JsonResponse({
            "status": False,
            "message": "Logout failed."
        }, status=401)
```

**3. Session Cleanup:**
- Django menghapus session data
- CookieRequest membersihkan stored cookies
- State `request.loggedIn` menjadi false

**4. Redirect ke LoginPage:**
```dart
if (response['status']) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const LoginPage()),
  );
}
```

**D. Persistent Authentication State:**

CookieRequest menyimpan authentication state dan otomatis menyertakan session cookies dalam setiap request:
```dart
// Setiap request otomatis include authentication
final products = await request.get('http://localhost:8000/json-filtered/');
```

**7. Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial).**

**Setup Autentikasi Django untuk Flutter:**

- **KickNGoal/authentication/apps.py**: Buat Django app authentication
- **KickNGoal/KickNGoal/settings.py**: Tambahkan authentication ke INSTALLED_APPS
- **Terminal**: Jalankan `pip install django-cors-headers` untuk install library CORS
- **KickNGoal/KickNGoal/settings.py**: Tambahkan corsheaders ke INSTALLED_APPS dan MIDDLEWARE
- **KickNGoal/KickNGoal/settings.py**: Tambahkan konfigurasi CORS dan cookie settings
```python
CORS_ALLOW_ALL_ORIGINS = True
CORS_ALLOW_CREDENTIALS = True
CSRF_COOKIE_SECURE = True
SESSION_COOKIE_SECURE = True
CSRF_COOKIE_SAMESITE = 'None'
SESSION_COOKIE_SAMESITE = 'None'
```
- **KickNGoal/KickNGoal/settings.py**: Tambahkan 10.0.2.2 ke ALLOWED_HOSTS untuk Android emulator
- **KickNGoal/authentication/views.py**: Buat method view untuk login dengan response JSON
- **KickNGoal/authentication/urls.py**: Buat file dan tambahkan URL routing untuk login endpoint
- **KickNGoal/KickNGoal/urls.py**: Tambahkan path authentication ke main urls

**Integrasi Sistem Autentikasi pada Flutter:**

- **Terminal**: Jalankan `flutter pub add provider` dan `flutter pub add pbp_django_auth`
- **MobileDev/kickngoal/lib/main.dart**: Modifikasi untuk menyediakan CookieRequest dengan Provider
- **MobileDev/kickngoal/lib/screens/login.dart**: Buat halaman login dengan UI card dan form
- **MobileDev/kickngoal/lib/main.dart**: Ubah home menjadi LoginPage()
- **KickNGoal/authentication/views.py**: Tambahkan method view register
- **KickNGoal/authentication/urls.py**: Tambahkan path register ke urls
- **MobileDev/kickngoal/lib/screens/register.dart**: Buat halaman register dengan form validation
- **MobileDev/kickngoal/lib/screens/login.dart**: Tambahkan import register dan update link ke RegisterPage

**Pembuatan Model Kustom:**

- **Quicktype Website**: Buka endpoint http://localhost:8000/json/ dan copy JSON data
- **Quicktype Website**: Paste JSON, set name: ProductEntry, source: JSON, language: Dart
- **MobileDev/kickngoal/lib/models/**: Buat folder models
- **MobileDev/kickngoal/lib/models/product_entry.dart**: Buat file dan paste kode dari Quicktype

**Fetch Data dari Django untuk Flutter:**

- **Terminal**: Jalankan `flutter pub add http` untuk menambahkan package HTTP
- **MobileDev/kickngoal/android/app/src/main/AndroidManifest.xml**: Tambahkan internet permission
- **MobileDev/kickngoal/lib/screens/product_entry_list.dart**: Buat halaman list produk dengan FutureBuilder
- **MobileDev/kickngoal/lib/widgets/left_drawer.dart**: Tambahkan navigation ke product list
- **MobileDev/kickngoal/lib/widgets/product_card.dart**: Update tombol "All Products" untuk navigasi ke ProductListPage
- **MobileDev/kickngoal/lib/screens/product_detail.dart**: Buat halaman detail produk dengan semua atribut
- **MobileDev/kickngoal/lib/screens/product_entry_list.dart**: Update onTap untuk navigasi ke detail page

**Integrasi Form Flutter dengan Django:**

- **KickNGoal/main/views.py**: Tambahkan import dan fungsi create_product_flutter untuk handle POST dari Flutter
- **KickNGoal/main/urls.py**: Tambahkan path 'create-flutter/' ke urls
- **MobileDev/kickngoal/lib/screens/product_form.dart**: Tambahkan import provider dan pbp_django_auth
- **MobileDev/kickngoal/lib/screens/product_form.dart**: Update onPressed button untuk kirim data via postJson
- **MobileDev/kickngoal/lib/screens/product_form.dart**: Tambahkan handling response dan navigation

**Implementasi Logout:**

- **KickNGoal/authentication/views.py**: Tambahkan method view untuk logout
- **KickNGoal/authentication/urls.py**: Tambahkan path logout ke urls
- **MobileDev/kickngoal/lib/widgets/product_card.dart**: Update handler untuk tombol Logout dengan confirmation dialog
- **MobileDev/kickngoal/lib/widgets/left_drawer.dart**: Tambahkan logout functionality di drawer

**Fitur Tambahan - Filtering Produk Berdasarkan User:**

- **KickNGoal/main/views.py**: Buat fungsi show_json_filtered untuk return produk user yang login
- **KickNGoal/main/urls.py**: Tambahkan path 'json-filtered/' ke urls
- **MobileDev/kickngoal/lib/screens/product_entry_list.dart**: Tambahkan filter buttons (All Products vs My Products)
- **MobileDev/kickngoal/lib/screens/product_entry_list.dart**: Implementasi state management untuk filter dengan ValueKey untuk force rebuild FutureBuilder
- **MobileDev/kickngoal/lib/screens/product_entry_list.dart**: Update fetchProducts method untuk handle different endpoints berdasarkan filter