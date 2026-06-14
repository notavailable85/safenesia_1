class Article {
  final String id;
  final String title;
  final String category;
  final String date;
  final String imageUrl;
  final String content;

  const Article({
    required this.id,
    required this.title,
    required this.category,
    required this.date,
    required this.imageUrl,
    required this.content,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'date': date,
      'imageUrl': imageUrl,
      'content': content,
    };
  }

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      id: map['id'] as String,
      title: map['title'] as String,
      category: map['category'] as String,
      date: map['date'] as String,
      imageUrl: map['imageUrl'] as String,
      content: map['content'] as String,
    );
  }
}

// Dummy Data
final List<Article> dummyArticles = [
  const Article(
    id: '1',
    title: 'Pentingnya APD di Sektor Konstruksi',
    category: 'Konstruksi',
    date: '12 Agustus 2026',
    imageUrl: 'https://picsum.photos/seed/k3_1/400/200',
    content:
        'Alat Pelindung Diri (APD) sangat penting untuk mencegah terjadinya kecelakaan kerja, terutama di sektor konstruksi. Penggunaan helm, sepatu safety, dan rompi reflektif harus menjadi standar wajib di setiap proyek.\n\nSelain itu, para pekerja juga harus diberikan pelatihan berkala mengenai cara pemakaian APD yang benar dan tepat sasaran. Kelalaian kecil dalam penggunaan APD bisa berdampak fatal pada keselamatan jiwa.',
  ),
  const Article(
    id: '2',
    title: 'Prosedur Evakuasi Kebakaran Gedung',
    category: 'Umum',
    date: '10 Agustus 2026',
    imageUrl: 'https://picsum.photos/seed/k3_2/400/200',
    content:
        'Saat terjadi kebakaran, hal yang paling utama adalah tetap tenang dan tidak panik. Segera ikuti petunjuk arah evakuasi yang menempel di dinding dan berjalanlah dengan cepat (jangan berlari).\n\nDilarang keras menggunakan lift saat evakuasi. Gunakan selalu tangga darurat. Setelah keluar dari gedung, segera menuju titik kumpul (assembly point) dan jangan kembali ke dalam gedung sampai ada instruksi aman dari petugas.',
  ),
  const Article(
    id: '3',
    title: 'Bahaya Listrik Tegangan Tinggi',
    category: 'Listrik',
    date: '08 Agustus 2026',
    imageUrl: 'https://picsum.photos/seed/k3_3/400/200',
    content:
        'Bekerja dengan instalasi listrik tegangan tinggi memiliki risiko fatal berupa tersengat listrik (electrocution) hingga kebakaran. Pekerja wajib menerapkan prosedur LOTO (Lock Out Tag Out) sebelum bekerja.\n\nPastikan juga menggunakan sarung tangan berbahan dielektrik, sepatu safety isolator, dan bekerja di area yang kering. Hindari bekerja sendirian pada panel listrik utama.',
  ),
  const Article(
    id: '4',
    title: 'Standar Keselamatan Area Tambang Terbuka',
    category: 'Tambang',
    date: '05 Agustus 2026',
    imageUrl: 'https://picsum.photos/seed/k3_4/400/200',
    content:
        'Aktivitas pertambangan terbuka melibatkan penggunaan alat-alat berat ekstrem seperti ekskavator raksasa dan truk angkut (haul truck). Jarak pandang (blind spot) dari alat-alat ini sangat besar.\n\nAturan jarak aman minimal 50 meter antar kendaraan harus dipatuhi dengan ketat. Pengemudi kendaraan ringan (LV) wajib menyalakan buggy whip dan berkomunikasi melalui radio dua arah sebelum mendekati alat berat.',
  ),
  const Article(
    id: '5',
    title: 'Penanganan Limbah Medis B3',
    category: 'Rumah Sakit',
    date: '02 Agustus 2026',
    imageUrl: 'https://picsum.photos/seed/k3_5/400/200',
    content:
        'Limbah medis yang dihasilkan dari kegiatan rumah sakit termasuk dalam kategori B3 (Bahan Berbahaya dan Beracun) yang dapat menularkan penyakit (infeksius).\n\nPenanganannya meliputi pemilahan langsung di sumbernya menggunakan plastik kuning untuk sampah infeksius, dan safety box untuk benda tajam seperti jarum suntik. Pemusnahan wajib menggunakan mesin insinerator dengan suhu minimal 800 derajat celcius.',
  ),
  const Article(
    id: '6',
    title: 'Keselamatan Kerja di Anjungan Lepas Pantai',
    category: 'Oil & Gas',
    date: '28 Juli 2026',
    imageUrl: 'https://picsum.photos/seed/k3_6/400/200',
    content:
        'Bekerja di anjungan minyak lepas pantai (offshore) memiliki tantangan tersendiri karena lokasi yang terisolasi dan cuaca laut yang tidak menentu.\n\nSetiap pekerja yang menuju ke rig wajib memiliki sertifikasi BOSIET (Basic Offshore Safety Induction and Emergency Training) yang mencakup teknik bertahan hidup di laut (Sea Survival) dan penyelamatan diri dari helikopter jatuh (HUET).',
  ),
];

final List<String> articleCategories = [
  'Semua',
  'Umum',
  'Listrik',
  'Konstruksi',
  'Tambang',
  'Rumah Sakit',
  'Oil & Gas',
  'Manufaktur',
];
