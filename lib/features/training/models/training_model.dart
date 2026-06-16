class Training {
  final String idPelatihan; // Primary Key
  final String kodeBidang;
  final String bidang; // Kategori
  final String namaPelatihan; // Judul
  final String namaPelatihanKapital;
  final String kodePelatihan;
  final String durasi;
  final int hargaPromo;
  final int hargaNormal; // Harga
  final String sertifikasi;
  final String status;
  final String deskripsi;
  final String dasarHukum;
  final String tujuan;
  final String materi;
  final String syaratAdministrasi;
  final String fasilitas;
  final String metode;
  final String detailMetode;
  final String syaratKetentuan;
  final String instruktur;
  final String keterangan;
  final String gambarPelatihan;
  final String? namaLokasi;
  final String? linkPetaLokasi;

  Training({
    required this.idPelatihan,
    required this.kodeBidang,
    required this.bidang,
    required this.namaPelatihan,
    required this.namaPelatihanKapital,
    required this.kodePelatihan,
    required this.durasi,
    required this.hargaPromo,
    required this.hargaNormal,
    required this.sertifikasi,
    required this.status,
    required this.deskripsi,
    required this.dasarHukum,
    required this.tujuan,
    required this.materi,
    required this.syaratAdministrasi,
    required this.fasilitas,
    required this.metode,
    required this.detailMetode,
    required this.syaratKetentuan,
    required this.instruktur,
    required this.keterangan,
    required this.gambarPelatihan,
    this.namaLokasi,
    this.linkPetaLokasi,
  });

  Map<String, dynamic> toMap() {
    return {
      'idPelatihan': idPelatihan,
      'kodeBidang': kodeBidang,
      'bidang': bidang,
      'namaPelatihan': namaPelatihan,
      'namaPelatihanKapital': namaPelatihanKapital,
      'kodePelatihan': kodePelatihan,
      'durasi': durasi,
      'hargaPromo': hargaPromo,
      'hargaNormal': hargaNormal,
      'sertifikasi': sertifikasi,
      'status': status,
      'deskripsi': deskripsi,
      'dasarHukum': dasarHukum,
      'tujuan': tujuan,
      'materi': materi,
      'syaratAdministrasi': syaratAdministrasi,
      'fasilitas': fasilitas,
      'metode': metode,
      'detailMetode': detailMetode,
      'syaratKetentuan': syaratKetentuan,
      'instruktur': instruktur,
      'keterangan': keterangan,
      'gambarPelatihan': gambarPelatihan,
      'namaLokasi': namaLokasi,
      'linkPetaLokasi': linkPetaLokasi,
    };
  }

  factory Training.fromMap(Map<String, dynamic> map) {
    return Training(
      idPelatihan: map['idPelatihan'] as String,
      kodeBidang: map['kodeBidang'] as String,
      bidang: map['bidang'] as String,
      namaPelatihan: map['namaPelatihan'] as String,
      namaPelatihanKapital: map['namaPelatihanKapital'] as String,
      kodePelatihan: map['kodePelatihan'] as String,
      durasi: map['durasi'] as String,
      hargaPromo: map['hargaPromo'] as int,
      hargaNormal: map['hargaNormal'] as int,
      sertifikasi: map['sertifikasi'] as String,
      status: map['status'] as String,
      deskripsi: map['deskripsi'] as String,
      dasarHukum: map['dasarHukum'] as String,
      tujuan: map['tujuan'] as String,
      materi: map['materi'] as String,
      syaratAdministrasi: map['syaratAdministrasi'] as String,
      fasilitas: map['fasilitas'] as String,
      metode: map['metode'] as String,
      detailMetode: map['detailMetode'] as String,
      syaratKetentuan: map['syaratKetentuan'] as String,
      instruktur: map['instruktur'] as String,
      keterangan: map['keterangan'] as String,
      gambarPelatihan: map['gambarPelatihan'] as String,
      namaLokasi: map['namaLokasi'] as String?,
      linkPetaLokasi: map['linkPetaLokasi'] as String?,
    );
  }
}

// Data Dummy Awal
List<Training> getDummyTrainings() {
  final now = DateTime.now();

  String getShortMonthName(int month) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Ags',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];
    return months[month];
  }

  return [
    // ================= DATA 1 =================
    Training(
      idPelatihan: 'KKRI-101-AK3UOL',
      kodeBidang: '101',
      bidang: 'Keahlian K3 Umum',
      namaPelatihan: 'Ahli K3 Umum Online',
      namaPelatihanKapital: 'AHLI K3 UMUM ONLINE',
      kodePelatihan: 'AK3UOL',
      durasi: '12 Hari',
      hargaPromo: 5000000,
      hargaNormal: 6000000,
      sertifikasi: 'Kemnaker RI',
      status: 'Running',
      deskripsi:
          '''Keselamatan dan Kesehatan Kerja (K3) merupakan bagian terpenting dalam sebuah perusahaan. Maka dari itu, tak heran jika banyak perusahaan yang membutuhkan seseorang yang memiliki keahlian dalam bidang tersebut atau disebut dengan Ahli K3 Umum. Ahli K3 Umum (AK3U) adalah tenaga ahli di bidang K3 yang hadir untuk membantu pemerintah maupun perusahaan dalam mengurangi risiko kecelakaan kerja dan penyakit akibat kerja di tempat kerja serta membantu mengawasi ditaatinya Undang-Undang K3. AK3U juga bertugas merancang program atau membuat rekomendasi yang tepat untuk menciptakan lingkungan kerja yang aman dan nyaman, serta tidak merusak ekosistem lingkungan.

Berdasarkan Permenaker No. 4 Tahun 1987 tentang Panitia Pembina Keselamatan dan Kesehatan Kerja Serta Tata Cara Penunjukkan Ahli K3, Setiap tempat kerja dengan kriteria :
● Memperkerjakan 100 orang atau lebih; atau
● Mempunyai risiko yang besar akan terjadinya peledakan, kebakaran, keracunan dan penyinaran radioaktif
WAJIB membentuk Panitia Pembina Keselamatan dan Kesehatan Kerja (P2K3). Dalam P2K3 terdapat seorang Sekretaris P2K3 dimana Sekretaris P2K3 ialah Ahli Keselamatan dan Kesehatan Kerja dari perusahaan yang bersangkutan. Untuk memenuhi peraturan tersebut, perusahaan dapat memberikan pembinaan dan sertifikasi kepada tenaga ahlinya melalui PJK3 bekerja sama dengan Kemnaker RI.''',
      dasarHukum: '''● UU No. 1 Tahun 1970
● Permenaker No. 2 Tahun 1992
● Kep. DJPPK No. 69 Tahun 2015''',
      tujuan:
          '''● Mendapatkan tenaga teknis berkeahlian khusus di bidang K3 yang dapat membantu pelaksanaan pembinaan dan pengawasan di tempat kerja
● Meningkatkan pengetahuan dan pemahaman tentang peraturan perundang-undangan K3
● Meningkatkan kemampuan dalam menerapkan K3 sesuai peraturan perundang-undangan di tempat kerja''',
      materi: '''KELOMPOK DASAR
● Kebijakan K3
● Undang-undang No.1 Tahun 1970

KELOMPOK INTI
● Pengawasan Norma Kelembagaan dan Keahlian K3
● Pengawasan Norma Keselematan Kerja Listrik
● Pengawasan Norma Penanggulangan Kebakaran
● Pengawasan Norma Keselamatan Kerja Konstruksi dan Bangunan
● Pengawasan Norma Keselamatan Kerja Mekanik
● Pengawasan Norma Keselamatan Kerja Pesawat Uap dan Bejana Tekan
● Pengawasan Norma Kesehatan Kerja
● Pengawasan Norma Lingkungan Kerja
● Pengawasan Norma Bahan Berbahaya
● Pengawasan Norma SMK3
● Laporan Kecelakaan Kerja

KELOMPOK PENUNJANG
● Dasar-dasar K3
● Analisa Kecelakaan
● Manajemen Risiko

PRAKTIK PEMERIKSAAN K3

EVALUASI
● Ujian tertulis
● Seminar

Total JP (Jam Pelajaran) = 120 JP''',
      syaratAdministrasi: '''1. KTP .pdf
2. Ijazah .pdf
3. Curriculum Vitae .pdf
4. Pasfoto Latar Merah .jpg
5. Surat Keterangan Sehat .pdf
6. Surat Keterangan Bekerja .pdf
7. Pakta Intergritas .pdf
8. -''',
      fasilitas: '''● Sertifikat dari Kemnaker RI
● SKP dan Lisensi dari Kemnaker RI
● E-Certificate dan SK Lulus dari PJK3
● E-Learning (Modul dan Video)
● Kemeja Safety
● Training Kit''',
      metode: 'ONLINE TRAINING',
      detailMetode: 'Full Online Training via Zoom dan Google Classroom',
      syaratKetentuan: '''● Harga tidak termasuk pajak
● Pembayaran dilakukan selambat-lambatnya H-5 pelatihan
● Perusahaan perlu menyediakan fasilitas pelatihan untuk metode Blended/Offline training''',
      instruktur:
          'Instruktur Training merupakan Tenaga Ahli PJK3, Praktisi, Akademisi dan Pejabat Kemnaker/Disnaker.',
      keterangan: 'Pendidikan min. D3, harga tidak termasuk pajak',
      gambarPelatihan:
          'https://drive.google.com/thumbnail?sz=w500&id=10EQ0guF7o9bRD7PTEcoUuFGKjp1jdP9o',
    ),

    // ================= DATA 2 =================
    Training(
      idPelatihan: 'KKRI-101-AK3UJKT',
      kodeBidang: '101',
      bidang: 'Keahlian K3 Umum',
      namaPelatihan: 'Ahli K3 Umum Jakarta',
      namaPelatihanKapital: 'AHLI K3 UMUM JAKARTA',
      kodePelatihan: 'AK3UJKT',
      durasi: '12 Hari',
      hargaPromo: 6000000,
      hargaNormal: 7000000,
      sertifikasi: 'Kemnaker RI',
      status: 'Running',
      deskripsi:
          '''Keselamatan dan Kesehatan Kerja (K3) merupakan bagian terpenting dalam sebuah perusahaan. Maka dari itu, tak heran jika banyak perusahaan yang membutuhkan seseorang yang memiliki keahlian dalam bidang tersebut atau disebut dengan Ahli K3 Umum. Ahli K3 Umum (AK3U) adalah tenaga ahli di bidang K3 yang hadir untuk membantu pemerintah maupun perusahaan dalam mengurangi risiko kecelakaan kerja dan penyakit akibat kerja di tempat kerja serta membantu mengawasi ditaatinya Undang-Undang K3. AK3U juga bertugas merancang program atau membuat rekomendasi yang tepat untuk menciptakan lingkungan kerja yang aman dan nyaman, serta tidak merusak ekosistem lingkungan.

Berdasarkan Permenaker No. 4 Tahun 1987 tentang Panitia Pembina Keselamatan dan Kesehatan Kerja Serta Tata Cara Penunjukkan Ahli K3, Setiap tempat kerja dengan kriteria :
● Memperkerjakan 100 orang atau lebih; atau
● Mempunyai risiko yang besar akan terjadinya peledakan, kebakaran, keracunan dan penyinaran radioaktif
WAJIB membentuk Panitia Pembina Keselamatan dan Kesehatan Kerja (P2K3). Dalam P2K3 terdapat seorang Sekretaris P2K3 dimana Sekretaris P2K3 ialah Ahli Keselamatan dan Kesehatan Kerja dari perusahaan yang bersangkutan. Untuk memenuhi peraturan tersebut, perusahaan dapat memberikan pembinaan dan sertifikasi kepada tenaga ahlinya melalui PJK3 bekerja sama dengan Kemnaker RI.''',
      dasarHukum: '''● UU No. 1 Tahun 1970
● Permenaker No. 2 Tahun 1992
● Kep. DJPPK No. 69 Tahun 2015''',
      tujuan:
          '''● Mendapatkan tenaga teknis berkeahlian khusus di bidang K3 yang dapat membantu pelaksanaan pembinaan dan pengawasan di tempat kerja
● Meningkatkan pengetahuan dan pemahaman tentang peraturan perundang-undangan K3
● Meningkatkan kemampuan dalam menerapkan K3 sesuai peraturan perundang-undangan di tempat kerja''',
      materi: '''KELOMPOK DASAR
● Kebijakan K3
● Undang-undang No.1 Tahun 1970

KELOMPOK INTI
● Pengawasan Norma Kelembagaan dan Keahlian K3
● Pengawasan Norma Keselematan Kerja Listrik
● Pengawasan Norma Penanggulangan Kebakaran
● Pengawasan Norma Keselamatan Kerja Konstruksi dan Bangunan
● Pengawasan Norma Keselamatan Kerja Mekanik
● Pengawasan Norma Keselamatan Kerja Pesawat Uap dan Bejana Tekan
● Pengawasan Norma Kesehatan Kerja
● Pengawasan Norma Lingkungan Kerja
● Pengawasan Norma Bahan Berbahaya
● Pengawasan Norma SMK3
● Laporan Kecelakaan Kerja

KELOMPOK PENUNJANG
● Dasar-dasar K3
● Analisa Kecelakaan
● Manajemen Risiko

PRAKTIK PEMERIKSAAN K3

EVALUASI
● Ujian tertulis
● Seminar

Total JP (Jam Pelajaran) = 120 JP''',
      syaratAdministrasi: '''1. KTP .pdf
2. Ijazah .pdf
3. Curriculum Vitae .pdf
4. Pasfoto Latar Merah .jpg
5. Surat Keterangan Sehat .pdf
6. Surat Keterangan Bekerja .pdf
7. Pakta Intergritas .pdf
8. -''',
      fasilitas: '''● Sertifikat dari Kemnaker RI
● SKP dan Lisensi dari Kemnaker RI
● E-Certificate dan SK Lulus dari PJK3
● E-Learning (Modul dan Video)
● Kemeja Safety
● Training Kit''',
      metode: 'OFFLINE TRAINING',
      detailMetode:
          'Full Offline Training, Teori dan Praktik dilaksanakan secara Tatap Muka',
      syaratKetentuan: '''● Harga tidak termasuk pajak
● Pembayaran dilakukan selambat-lambatnya H-5 pelatihan
● Perusahaan perlu menyediakan fasilitas pelatihan untuk metode Blended/Offline training''',
      instruktur:
          'Instruktur Training merupakan Tenaga Ahli PJK3, Praktisi, Akademisi dan Pejabat Kemnaker/Disnaker.',
      keterangan: 'Pendidikan min. D3, harga tidak termasuk pajak',
      gambarPelatihan:
          'https://drive.google.com/thumbnail?sz=w500&id=10EQ0guF7o9bRD7PTEcoUuFGKjp1jdP9o',
    ),

    // ================= DATA 3 =================
    Training(
      idPelatihan: 'KKRI-101-AK3USBY',
      kodeBidang: '101',
      bidang: 'Keahlian K3 Umum',
      namaPelatihan: 'Ahli K3 Umum Surabaya',
      namaPelatihanKapital: 'AHLI K3 UMUM SURABAYA',
      kodePelatihan: 'AK3USBY',
      durasi: '12 Hari',
      hargaPromo: 6000000,
      hargaNormal: 7000000,
      sertifikasi: 'Kemnaker RI',
      status: 'Running',
      deskripsi:
          '''Keselamatan dan Kesehatan Kerja (K3) merupakan bagian terpenting dalam sebuah perusahaan. Maka dari itu, tak heran jika banyak perusahaan yang membutuhkan seseorang yang memiliki keahlian dalam bidang tersebut atau disebut dengan Ahli K3 Umum. Ahli K3 Umum (AK3U) adalah tenaga ahli di bidang K3 yang hadir untuk membantu pemerintah maupun perusahaan dalam mengurangi risiko kecelakaan kerja dan penyakit akibat kerja di tempat kerja serta membantu mengawasi ditaatinya Undang-Undang K3. AK3U juga bertugas merancang program atau membuat rekomendasi yang tepat untuk menciptakan lingkungan kerja yang aman dan nyaman, serta tidak merusak ekosistem lingkungan.

Berdasarkan Permenaker No. 4 Tahun 1987 tentang Panitia Pembina Keselamatan dan Kesehatan Kerja Serta Tata Cara Penunjukkan Ahli K3, Setiap tempat kerja dengan kriteria :
● Memperkerjakan 100 orang atau lebih; atau
● Mempunyai risiko yang besar akan terjadinya peledakan, kebakaran, keracunan dan penyinaran radioaktif
WAJIB membentuk Panitia Pembina Keselamatan dan Kesehatan Kerja (P2K3). Dalam P2K3 terdapat seorang Sekretaris P2K3 dimana Sekretaris P2K3 ialah Ahli Keselamatan dan Kesehatan Kerja dari perusahaan yang bersangkutan. Untuk memenuhi peraturan tersebut, perusahaan dapat memberikan pembinaan dan sertifikasi kepada tenaga ahlinya melalui PJK3 bekerja sama dengan Kemnaker RI.''',
      dasarHukum: '''● UU No. 1 Tahun 1970
● Permenaker No. 2 Tahun 1992
● Kep. DJPPK No. 69 Tahun 2015''',
      tujuan:
          '''● Mendapatkan tenaga teknis berkeahlian khusus di bidang K3 yang dapat membantu pelaksanaan pembinaan dan pengawasan di tempat kerja
● Meningkatkan pengetahuan dan pemahaman tentang peraturan perundang-undangan K3
● Meningkatkan kemampuan dalam menerapkan K3 sesuai peraturan perundang-undangan di tempat kerja''',
      materi: '''KELOMPOK DASAR
● Kebijakan K3
● Undang-undang No.1 Tahun 1970

KELOMPOK INTI
● Pengawasan Norma Kelembagaan dan Keahlian K3
● Pengawasan Norma Keselematan Kerja Listrik
● Pengawasan Norma Penanggulangan Kebakaran
● Pengawasan Norma Keselamatan Kerja Konstruksi dan Bangunan
● Pengawasan Norma Keselamatan Kerja Mekanik
● Pengawasan Norma Keselamatan Kerja Pesawat Uap dan Bejana Tekan
● Pengawasan Norma Kesehatan Kerja
● Pengawasan Norma Lingkungan Kerja
● Pengawasan Norma Bahan Berbahaya
● Pengawasan Norma SMK3
● Laporan Kecelakaan Kerja

KELOMPOK PENUNJANG
● Dasar-dasar K3
● Analisa Kecelakaan
● Manajemen Risiko

PRAKTIK PEMERIKSAAN K3

EVALUASI
● Ujian tertulis
● Seminar

Total JP (Jam Pelajaran) = 120 JP''',
      syaratAdministrasi: '''1. KTP .pdf
2. Ijazah .pdf
3. Curriculum Vitae .pdf
4. Pasfoto Latar Merah .jpg
5. Surat Keterangan Sehat .pdf
6. Surat Keterangan Bekerja .pdf
7. Pakta Intergritas .pdf
8. -''',
      fasilitas: '''● Sertifikat dari Kemnaker RI
● SKP dan Lisensi dari Kemnaker RI
● E-Certificate dan SK Lulus dari PJK3
● E-Learning (Modul dan Video)
● Kemeja Safety
● Training Kit''',
      metode: 'OFFLINE TRAINING',
      detailMetode:
          'Full Offline Training, Teori dan Praktik dilaksanakan secara Tatap Muka',
      syaratKetentuan: '''● Harga tidak termasuk pajak
● Pembayaran dilakukan selambat-lambatnya H-5 pelatihan
● Perusahaan perlu menyediakan fasilitas pelatihan untuk metode Blended/Offline training''',
      instruktur:
          'Instruktur Training merupakan Tenaga Ahli PJK3, Praktisi, Akademisi dan Pejabat Kemnaker/Disnaker.',
      keterangan: 'Pendidikan min. D3, harga tidak termasuk pajak',
      gambarPelatihan:
          'https://drive.google.com/thumbnail?sz=w500&id=10EQ0guF7o9bRD7PTEcoUuFGKjp1jdP9o',
    ),

    // ================= DATA 4 =================
    Training(
      idPelatihan: 'KKRI-101-AK3UBDG',
      kodeBidang: '101',
      bidang: 'Keahlian K3 Umum',
      namaPelatihan: 'Ahli K3 Umum Bandung',
      namaPelatihanKapital: 'AHLI K3 UMUM BANDUNG',
      kodePelatihan: 'AK3UBDG',
      durasi: '12 Hari',
      hargaPromo: 6000000,
      hargaNormal: 7000000,
      sertifikasi: 'Kemnaker RI',
      status: 'Running',
      deskripsi:
          '''Keselamatan dan Kesehatan Kerja (K3) merupakan bagian terpenting dalam sebuah perusahaan. Maka dari itu, tak heran jika banyak perusahaan yang membutuhkan seseorang yang memiliki keahlian dalam bidang tersebut atau disebut dengan Ahli K3 Umum. Ahli K3 Umum (AK3U) adalah tenaga ahli di bidang K3 yang hadir untuk membantu pemerintah maupun perusahaan dalam mengurangi risiko kecelakaan kerja dan penyakit akibat kerja di tempat kerja serta membantu mengawasi ditaatinya Undang-Undang K3. AK3U juga bertugas merancang program atau membuat rekomendasi yang tepat untuk menciptakan lingkungan kerja yang aman dan nyaman, serta tidak merusak ekosistem lingkungan.

Berdasarkan Permenaker No. 4 Tahun 1987 tentang Panitia Pembina Keselamatan dan Kesehatan Kerja Serta Tata Cara Penunjukkan Ahli K3, Setiap tempat kerja dengan kriteria :
● Memperkerjakan 100 orang atau lebih; atau
● Mempunyai risiko yang besar akan terjadinya peledakan, kebakaran, keracunan dan penyinaran radioaktif
WAJIB membentuk Panitia Pembina Keselamatan dan Kesehatan Kerja (P2K3). Dalam P2K3 terdapat seorang Sekretaris P2K3 dimana Sekretaris P2K3 ialah Ahli Keselamatan dan Kesehatan Kerja dari perusahaan yang bersangkutan. Untuk memenuhi peraturan tersebut, perusahaan dapat memberikan pembinaan dan sertifikasi kepada tenaga ahlinya melalui PJK3 bekerja sama dengan Kemnaker RI.''',
      dasarHukum: '''● UU No. 1 Tahun 1970
● Permenaker No. 2 Tahun 1992
● Kep. DJPPK No. 69 Tahun 2015''',
      tujuan:
          '''● Mendapatkan tenaga teknis berkeahlian khusus di bidang K3 yang dapat membantu pelaksanaan pembinaan dan pengawasan di tempat kerja
● Meningkatkan pengetahuan dan pemahaman tentang peraturan perundang-undangan K3
● Meningkatkan kemampuan dalam menerapkan K3 sesuai peraturan perundang-undangan di tempat kerja''',
      materi: '''KELOMPOK DASAR
● Kebijakan K3
● Undang-undang No.1 Tahun 1970

KELOMPOK INTI
● Pengawasan Norma Kelembagaan dan Keahlian K3
● Pengawasan Norma Keselematan Kerja Listrik
● Pengawasan Norma Penanggulangan Kebakaran
● Pengawasan Norma Keselamatan Kerja Konstruksi dan Bangunan
● Pengawasan Norma Keselamatan Kerja Mekanik
● Pengawasan Norma Keselamatan Kerja Pesawat Uap dan Bejana Tekan
● Pengawasan Norma Kesehatan Kerja
● Pengawasan Norma Lingkungan Kerja
● Pengawasan Norma Bahan Berbahaya
● Pengawasan Norma SMK3
● Laporan Kecelakaan Kerja

KELOMPOK PENUNJANG
● Dasar-dasar K3
● Analisa Kecelakaan
● Manajemen Risiko

PRAKTIK PEMERIKSAAN K3

EVALUASI
● Ujian tertulis
● Seminar

Total JP (Jam Pelajaran) = 120 JP''',
      syaratAdministrasi: '''1. KTP .pdf
2. Ijazah .pdf
3. Curriculum Vitae .pdf
4. Pasfoto Latar Merah .jpg
5. Surat Keterangan Sehat .pdf
6. Surat Keterangan Bekerja .pdf
7. Pakta Intergritas .pdf
8. -''',
      fasilitas: '''● Sertifikat dari Kemnaker RI
● SKP dan Lisensi dari Kemnaker RI
● E-Certificate dan SK Lulus dari PJK3
● E-Learning (Modul dan Video)
● Kemeja Safety
● Training Kit''',
      metode: 'OFFLINE TRAINING',
      detailMetode:
          'Full Offline Training, Teori dan Praktik dilaksanakan secara Tatap Muka',
      syaratKetentuan: '''● Harga tidak termasuk pajak
● Pembayaran dilakukan selambat-lambatnya H-5 pelatihan
● Perusahaan perlu menyediakan fasilitas pelatihan untuk metode Blended/Offline training''',
      instruktur:
          'Instruktur Training merupakan Tenaga Ahli PJK3, Praktisi, Akademisi dan Pejabat Kemnaker/Disnaker.',
      keterangan: 'Pendidikan min. D3, harga tidak termasuk pajak',
      gambarPelatihan:
          'https://drive.google.com/thumbnail?sz=w500&id=10EQ0guF7o9bRD7PTEcoUuFGKjp1jdP9o',
    ),

    // ================= DATA 5 =================
    Training(
      idPelatihan: 'KKRI-102-ASMK3',
      kodeBidang: '102',
      bidang: 'Sistem Manajemen K3',
      namaPelatihan: 'Auditor SMK3',
      namaPelatihanKapital: 'AUDITOR SMK3',
      kodePelatihan: 'ASMK3',
      durasi: '6 Hari',
      hargaPromo: 4500000,
      hargaNormal: 5500000,
      sertifikasi: 'Kemnaker RI',
      status: 'Running',
      deskripsi:
          '''Auditor SMK3 ialah tenaga teknis yang berkeahlian khusus dan independen untuk melaksanakan audit SMK3 yang ditunjuk oleh Menteri atau pejabat yang ditunjuk. Sistem Manajemen Keselamatan dan Kesehatan Kerja yang selanjutnya disebut SMK3 adalah bagian dari sistem manajemen perusahaan secara keseluruhan dalam rangka pengendalian risiko yang berkaitan dengan kegiatan kerja guna terciptanya tempat kerja yang aman, efisien dan produktif.

Untuk mengetahui sejauh mana penerapan sistem manajemen K3 berdasarkan Permenaker No. 26 Tahun 2014 tentang Penyelenggaraan Penilaian Penerapan Sistem Manajemen Keselamatan dan Kesehatan Kerja, dibutuhkan sebuah alat ukur berupa Audit SMK3. Yang dimaksud Audit SMK3 adalah pemeriksaan secara sistematis dan independen oleh Auditor SMK3 terhadap pemenuhan kriteria yang telah ditetapkan untuk mengukur suatu hasil kegiatan yang telah direncanakan dan dilaksanakan dalam penerapan SMK3 di perusahaan.''',
      dasarHukum: '''● UU No. 1 Tahun 1970
● PP No. 50 Tahun 2012
● Permenaker No. 26 Tahun 2014''',
      tujuan:
          '''● Mendapatkan tenaga teknis berkeahlian khusus di bidang K3 yang dapat membantu pelaksanaan pembinaan dan pengawasan di tempat kerja
● Meningkatkan pengetahuan dan pemahaman tentang peraturan perundang-undangan K3
● Meningkatkan kemampuan dalam menerapkan K3 sesuai peraturan perundang-undangan di tempat kerja''',
      materi: '''● Review Materi Keselamatan dan Kesehatan Kerja
● Kebijakan Keselamatan dan Kesehatan Kerja
● SMK3 (PP No. 50 Tahun 2012)
● Penerapan SMK3 (Lampiran I PP No. 50 Tahun 2012)
● Mekanisme, Teknik Audit SMK3, Tingkat Penerapan SMK3, dan Sertifikasi SMK3
● Interpretasi Kriteria Audit
● Pelaksana Audit SMK3 (Lembaga dan Auditor)
● Simulasi Audit SMK3
● Evaluasi

Total JP (Jam Pelajaran) = 40 JP''',
      syaratAdministrasi: '''1. KTP .pdf
2. Ijazah .pdf
3. Curriculum Vitae .pdf
4. Pasfoto Latar Merah .jpg
5. Surat Keterangan Sehat .pdf
6. Surat Keterangan Bekerja .pdf
7. Pakta Intergritas .pdf
8. Sertifikat AK3U .pdf''',
      fasilitas: '''● Sertifikat dari Kemnaker RI
● E-Certificate dan SK Lulus dari PJK3
● E-Learning (Modul dan Video)
● Kemeja Safety
● Training Kit''',
      metode: 'ONLINE TRAINING',
      detailMetode: 'Full Online Training via Zoom dan Google Classroom',
      syaratKetentuan: '''● Harga tidak termasuk pajak
● Pembayaran dilakukan selambat-lambatnya H-5 pelatihan
● Perusahaan perlu menyediakan fasilitas pelatihan untuk metode Blended/Offline training''',
      instruktur:
          'Instruktur Training merupakan Tenaga Ahli PJK3, Praktisi, Akademisi dan Pejabat Kemnaker/Disnaker.',
      keterangan:
          'Pendidikan min. D3, memiliki sertifikat Ahli K3 Umum (AK3U), harga tidak termasuk pajak',
      gambarPelatihan:
          'https://drive.google.com/thumbnail?sz=w500&id=10EQ0guF7o9bRD7PTEcoUuFGKjp1jdP9o',
    ),
    // ================= DATA 1 =================
    Training(
      idPelatihan: 'KKRI-105-PPKD',
      kodeBidang: '105',
      bidang: 'Penanggulangan Kebakaran',
      namaPelatihan: 'Petugas Peran Kebakaran Kelas D',
      namaPelatihanKapital: 'PETUGAS PERAN KEBAKARAN KELAS D',
      kodePelatihan: 'PPKD',
      durasi: '4 Hari',
      hargaPromo: 4500000,
      hargaNormal: 5500000,
      sertifikasi: 'Kemnaker RI',
      status: 'Running',
      deskripsi:
          '''Penanggulangan kebakaran ialah segala upaya untuk mencegah timbulnya kabakaran dengan berbagai upaya pengendalan setiap perwujudan energi, pengadaan sarana proteksi kebakaran dan sarana penyelamatan serta pembentukan organisasi tanggap darurat untuk memberantas kebakaran.

Tidak jarang kita mendengar terjadinya kebakaran di tempat kerja ataupun perumahan. Untuk menghindari hal tersebut pada dasarnya terdapat tindakan-tindakan yang harus dilakukan untuk mencegah dan menanggulangi kondisi tersebut yaitu :
__Tindakan Preventive yaitu tindakan yang dilakukan sebelum terjadi kebakaran dengan maksud menekan atau mengurangi faktor-faktor yang dapat menyebabkan timbulnya kebakaran
__Tindakan Represive yaitu tindakan yang dilakukan saat terjadi kebakaran dengan maksud untuk mengurangi atau memperkecil kerugian-kerugian yang timbul akibat dari kebakaran.
__Tindakan Rehabilitative yaitu tindakan yang dilakukan setelah terjadi kebakaran dengan maksud mengevaluasi dan menganalisa peristiwa kebakaran untuk mendapatkan informasi faktor penyebab kebakaran sebagai bahan pengusutan, pemulihan dan penyampaian ke publik

Berdasarkan Kepmenaker No. 186 Tahun 1999 tentang Unit Penanggulangan Kebakaran di Tempat Kerja, Pengurus atau pengusaha wajib mencegah, mengurangi dan memadamkan kebakaran serta latihan penanggulanggan kebakaran di tempat kerja. salah satu kewajiban tersebut yaitu membentuk unit penanggulangan kebakaran di tempat kerja yang terdiri dari :
● Petugas Peran Kebakaran;
● Regu Penanggulangan Kebakaran;
● Koordinator Unit Penanggulangan Kabakaran;
● Ahli K3 Spesialis Penaggulangan Kebakaran

Petugas Peran Kebakaran wajib dimiliki perusahaan sekurang-kurangnya 2 (dua) orang untuk setiap jumlah tenaga kerja 25 (dua puluh lima) orang. Untuk memenuhi peraturan tersebut, perusahaan dapat memberikan pembinaan dan sertifikasi kepada tenaga teknisnya melalui PJK3 bekerja sama dengan Kemnaker RI.''',
      dasarHukum: '''● UU No. 1 Tahun 1970
● Permenaker No. 4 Tahun 1980
● Kepmenaker No. 186 Tahun 1999''',
      tujuan:
          '''● Mendapatkan tenaga teknis berkeahlian khusus di bidang K3 yang dapat membantu pelaksanaan pembinaan dan pengawasan di tempat kerja
● Meningkatkan pengetahuan dan pemahaman tentang peraturan perundang-undangan K3
● Meningkatkan kemampuan dalam menerapkan K3 sesuai peraturan perundang-undangan di tempat kerja''',
      materi: '''● Norma K3 Penanggulangan Kebakaran
● Manajemen Penanggulangan Kebakaran
● Teori Api dan Anatomi Kebakaran I
● Pengenalan Sistem Proteksi Kebakaran
● Prosedur Darurat Bahaya Kebakaran
● Praktik Pemadaman
● Evaluasi

Total JP (Jam Pelajaran) = 25 JP''',
      syaratAdministrasi: '''1. KTP .pdf
2. Ijazah .pdf
3. Curriculum Vitae .pdf
4. Pasfoto Latar Merah .jpg
5. Surat Keterangan Sehat .pdf
6. Surat Keterangan Bekerja .pdf
7. Pakta Intergritas .pdf
8. -''',
      fasilitas: '''● Sertifikat dari Kemnaker RI
● Lisensi dari Kemnaker RI
● E-Certificate dan SK Lulus dari PJK3
● E-Learning (Modul dan Video)
● Kemeja Safety
● Training Kit''',
      metode: 'BLENDED TRAINING',
      detailMetode:
          'Teori via Zoom dan Google Classroom, Praktik WAJIB Tatap Muka',
      syaratKetentuan: '''● Harga tidak termasuk pajak
● Pembayaran dilakukan selambat-lambatnya H-5 pelatihan
● Perusahaan perlu menyediakan fasilitas pelatihan untuk metode Blended/Offline training''',
      instruktur:
          'Instruktur Training merupakan Tenaga Ahli PJK3, Praktisi, Akademisi dan Pejabat Kemnaker/Disnaker.',
      keterangan: 'Pendidikan min. SMA, harga tidak termasuk pajak',
      gambarPelatihan:
          'https://drive.google.com/thumbnail?sz=w500&id=10EQ0guF7o9bRD7PTEcoUuFGKjp1jdP9o',
    ),

    // ================= DATA 2 =================
    Training(
      idPelatihan: 'KKRI-106-AK3EE',
      kodeBidang: '106',
      bidang: 'Elevator dan Eskalator',
      namaPelatihan: 'Ahli K3 Elevator dan Eskalator',
      namaPelatihanKapital: 'AHLI K3 ELEVATOR DAN ESKALATOR',
      kodePelatihan: 'AK3EE',
      durasi: '12 Hari',
      hargaPromo: 12000000,
      hargaNormal: 13250000,
      sertifikasi: 'Kemnaker RI',
      status: 'Running',
      deskripsi:
          '''Elevator adalah pesawat lift yang mempunyai kereta dan bobot imbang bergerak naik turun mengikuti rel-rel pemandu yang dipasang secara permanen pada bangunan, memiliki governor dan digunakan untuk mengangkut orang dan/atau barang. Adapun Eskalator adalah pesawat transportasi untuk memindahkan orang dan/atau barang, mengikuti jalur lintasan rel yang digerakkan oleh motor listrik.

Penggunaan Elevator dan Eskalator dapat mengakibatkan kerugian baik terhadap harta maupun jiwa manusia sehingga perlu diusahakan pencegahannya, adapun risiko bahaya yang akan dihadapi adalah sengatan listik sehingga penting dilakukan pengecekkan pada seluruh konduktor aliran listrik secara berkala, beban berlebih yang yang dapat membuat mesin roboh atau terputus, malfungsi alat dan human error akibat tidak memperhatikan instruksi penggunaan elevator atau eskalaor yang terkadang melakukan keteledoran sehingga menyebabkan cidera

Berdasarkan Permenaker No. 6 Tahun 2017 tentang Keselamatan dan Kesehatan Kerja Elevator dan Eskalator, Pengurus dan/atau Pengusaha wajib menerapkan syarat K3 Elevator dan Eskalator meliputi kegiatan perencanaan, pembuatan, pemasangan, perakitan, pemakaian, perawatan, pemeliharaan, perbaikan, pemeriksaan dan pengujian. Adapun pemeriksaan dan/atau pengujian Elevator dan Eskalator dilakukan oleh :
● Pengawas Ketenagakerjaan Spesialis; dan/atau
● Ahli K3 Elevator dan Eskalator
Untuk memenuhi peraturan tersebut, perusahaan dapat memberikan pembinaan dan sertifikasi kepada tenaga ahlinya melalui PJK3 bekerja sama dengan Kemnaker RI.''',
      dasarHukum: '''● UU No. 1 Tahun 1970
● Permenaker No. 6 Tahun 2017''',
      tujuan:
          '''● Mendapatkan tenaga teknis berkeahlian khusus di bidang K3 yang dapat membantu pelaksanaan pembinaan dan pengawasan di tempat kerja
● Meningkatkan pengetahuan dan pemahaman tentang peraturan perundang-undangan K3
● Meningkatkan kemampuan dalam menerapkan K3 sesuai peraturan perundang-undangan di tempat kerja''',
      materi: '''KELOMPOK DASAR
● Kebijakan & Peraturan Perundangan K3
● Dasar- Dasar K3
● Pengetahuan Dasar Elevator & Eskalator

KELOMPOK INTI
● Manajemen Resiko Elevator & Eskalator
● Komponen & Pelengkapan Keamanan
● Teknik Perencanaan
● Konstruksi & Tata Letak
● Kelistrikan & Pengkabelan
● Standar Teknik Pemasangan
● Standar Teknik Pengoperasian
● Standar Teknik Pemeliharaan & Perawatan
● Pemeriksaan & Pengujian
● Prosedur Kerja Aman & Penyelamatan
● Observasi & Praktek Lapangan

EVALUASI
● Ujian tertulis
● Seminar

Total JP (Jam Pelajaran) = 120 JP''',
      syaratAdministrasi: '''1. KTP .pdf
2. Ijazah .pdf
3. Curriculum Vitae .pdf
4. Pasfoto Latar Merah .jpg
5. Surat Keterangan Sehat .pdf
6. Surat Keterangan Bekerja .pdf
7. Pakta Intergritas .pdf
8. -''',
      fasilitas: '''● Sertifikat dari Kemnaker RI
● SKP dan Lisensi dari Kemnaker RI
● E-Certificate dan SK Lulus dari PJK3
● E-Learning (Modul dan Video)
● Kemeja Safety
● Training Kit''',
      metode: 'OFFLINE TRAINING',
      detailMetode:
          'Full Offline Training, Teori dan Praktik dilaksanakan secara Tatap Muka',
      syaratKetentuan: '''● Harga tidak termasuk pajak
● Pembayaran dilakukan selambat-lambatnya H-5 pelatihan
● Perusahaan perlu menyediakan fasilitas pelatihan untuk metode Blended/Offline training''',
      instruktur:
          'Instruktur Training merupakan Tenaga Ahli PJK3, Praktisi, Akademisi dan Pejabat Kemnaker/Disnaker.',
      keterangan: 'Pendidikan min. D3, harga tidak termasuk pajak',
      gambarPelatihan:
          'https://drive.google.com/thumbnail?sz=w500&id=10EQ0guF7o9bRD7PTEcoUuFGKjp1jdP9o',
    ),

    // ================= DATA 3 =================
    Training(
      idPelatihan: 'KKRI-106-TK3EE',
      kodeBidang: '106',
      bidang: 'Elevator dan Eskalator',
      namaPelatihan: 'Teknisi K3 Elevator dan Eskalator',
      namaPelatihanKapital: 'TEKNISI K3 ELEVATOR DAN ESKALATOR',
      kodePelatihan: 'TK3EE',
      durasi: '6 Hari',
      hargaPromo: 6750000,
      hargaNormal: 7750000,
      sertifikasi: 'Kemnaker RI',
      status: 'Running',
      deskripsi:
          '''Elevator adalah pesawat lift yang mempunyai kereta dan bobot imbang bergerak naik turun mengikuti rel-rel pemandu yang dipasang secara permanen pada bangunan, memiliki governor dan digunakan untuk mengangkut orang dan/atau barang. Adapun Eskalator adalah pesawat transportasi untuk memindahkan orang dan/atau barang, mengikuti jalur lintasan rel yang digerakkan oleh motor listrik.

Penggunaan Elevator dan Eskalator dapat mengakibatkan kerugian baik terhadap harta maupun jiwa manusia sehingga perlu diusahakan pencegahannya, adapun risiko bahaya yang akan dihadapi adalah sengatan listik sehingga penting dilakukan pengecekkan pada seluruh konduktor aliran listrik secara berkala, beban berlebih yang yang dapat membuat mesin roboh atau terputus, malfungsi alat dan human error akibat tidak memperhatikan instruksi penggunaan elevator atau eskalaor yang terkadang melakukan keteledoran sehingga menyebabkan cidera.

Berdasarkan Permenaker No. 6 Tahun 2017 tentang Keselamatan dan Kesehatan Kerja Elevator dan Eskalator, Pengurus dan/atau Pengusaha wajib menerapkan syarat K3 Elevator dan Eskalator meliputi kegiatan perencanaan, pembuatan, pemasangan, perakitan, pemakaian, perawatan, pemeliharaan, perbaikan, pemeriksaan dan pengujian. Adapun pemasangan, perakitan, perbaikan, perawatan, pemeliharaan dan pengoperasian Elevator dan Eskalator dilakukan oleh Teknisi K3 Elevator dan Eskalator. Untuk memenuhi peraturan tersebut, perusahaan dapat memberikan pembinaan dan sertifikasi kepada tenaga teknisnya melalui PJK3 bekerja sama dengan Kemnaker RI.''',
      dasarHukum: '''● UU No. 1 Tahun 1970
● Permenaker No. 6 Tahun 2017''',
      tujuan:
          '''● Mendapatkan tenaga teknis berkeahlian khusus di bidang K3 yang dapat membantu pelaksanaan pembinaan dan pengawasan di tempat kerja
● Meningkatkan pengetahuan dan pemahaman tentang peraturan perundang-undangan K3
● Meningkatkan kemampuan dalam menerapkan K3 sesuai peraturan perundang-undangan di tempat kerja''',
      materi: '''● Peraturan Perundang-undangan K3
● Identifikasi, analisis dan penilaian resiko serta pengendalian potensi bahaya pada pekerjaan pemasangan, perakitan, perawatan, perbaikan, pemeliharaan dan pengoperasian Elevator dan Eskalator
● Pengetahuan dasar teknik Elevator dan Eskalator
● Persyaratan K3 bagian dan komponen serta perlengkapan pengaman Elevator
● Persyaratan K3 bagian dan komponen serta perlengkapan pengaman Eskalator
● Standar teknik pemasangan, perakitan, perawatan, perbaikan, pemeliharaan dan pengoperasian Elevator
● Standar teknik pemasangan, perakitan, perawatan, perbaikan, pemeliharaan dan pengoperasian Eskalator
● Prosedur kerja aman pada pemasangan, perakitan, perawatan, perbaikan, pemeliharaan dan pengoperasian Elevator dan Eskalator
● Pelaksanaan pertolongan pada kecelakaan Elevator dan Eskalator
● Evaluasi

Total JP (Jam Pelajaran) = 65 JP''',
      syaratAdministrasi: '''1. KTP .pdf
2. Ijazah .pdf
3. Curriculum Vitae .pdf
4. Pasfoto Latar Merah .jpg
5. Surat Keterangan Sehat .pdf
6. Surat Keterangan Bekerja .pdf
7. Pakta Intergritas .pdf
8. -''',
      fasilitas: '''● Sertifikat dari Kemnaker RI
● Lisensi dari Kemnaker RI
● E-Certificate dan SK Lulus dari PJK3
● E-Learning (Modul dan Video)
● Kemeja Safety
● Training Kit''',
      metode: 'BLENDED TRAINING',
      detailMetode:
          'Teori via Zoom dan Google Classroom, Praktik WAJIB Tatap Muka',
      syaratKetentuan: '''● Harga tidak termasuk pajak
● Pembayaran dilakukan selambat-lambatnya H-5 pelatihan
● Perusahaan perlu menyediakan fasilitas pelatihan untuk metode Blended/Offline training''',
      instruktur:
          'Instruktur Training merupakan Tenaga Ahli PJK3, Praktisi, Akademisi dan Pejabat Kemnaker/Disnaker.',
      keterangan: 'Pendidikan min. SMA, harga tidak termasuk pajak',
      gambarPelatihan:
          'https://drive.google.com/thumbnail?sz=w500&id=10EQ0guF7o9bRD7PTEcoUuFGKjp1jdP9o',
    ),

    // ================= DATA 4 =================
    Training(
      idPelatihan: 'KKRI-106-OEE',
      kodeBidang: '106',
      bidang: 'Elevator dan Eskalator',
      namaPelatihan: 'Operator Elevator dan Eskalator',
      namaPelatihanKapital: 'OPERATOR ELEVATOR DAN ESKALATOR',
      kodePelatihan: 'OEE',
      durasi: '5 Hari',
      hargaPromo: 6500000,
      hargaNormal: 7500000,
      sertifikasi: 'Kemnaker RI',
      status: 'Running',
      deskripsi:
          '''Elevator adalah pesawat lift yang mempunyai kereta dan bobot imbang bergerak naik turun mengikuti rel-rel pemandu yang dipasang secara permanen pada bangunan, memiliki governor dan digunakan untuk mengangkut orang dan/atau barang. Adapun Eskalator adalah pesawat transportasi untuk memindahkan orang dan/atau barang, mengikuti jalur lintasan rel yang digerakkan oleh motor listrik.

Penggunaan Elevator dan Eskalator dapat mengakibatkan kerugian baik terhadap harta maupun jiwa manusia sehingga perlu diusahakan pencegahannya, adapun risiko bahaya yang akan dihadapi adalah sengatan listik sehingga penting dilakukan pengecekkan pada seluruh konduktor aliran listrik secara berkala, beban berlebih yang yang dapat membuat mesin roboh atau terputus, malfungsi alat dan human error akibat tidak memperhatikan instruksi penggunaan elevator atau eskalaor yang terkadang melakukan keteledoran sehingga menyebabkan cidera.

Berdasarkan Permenaker No. 6 Tahun 2017 tentang Keselamatan dan Kesehatan Kerja Elevator dan Eskalator, Pengurus dan/atau Pengusaha wajib menerapkan syarat K3 Elevator dan Eskalator meliputi kegiatan perencanaan, pembuatan, pemasangan, perakitan, pemakaian, perawatan, pemeliharaan, perbaikan, pemeriksaan dan pengujian. Adapun pemeliharaan dan pengoperasian Elevator dan Eskalator dapat dilakukan oleh Operator K3 Elevator dan Eskalator. Untuk memenuhi peraturan tersebut, perusahaan dapat memberikan pembinaan dan sertifikasi kepada operatornya melalui PJK3 bekerja sama dengan Kemnaker RI.''',
      dasarHukum: '''● UU No. 1 Tahun 1970
● Permenaker No. 6 Tahun 2017''',
      tujuan:
          '''● Mendapatkan tenaga teknis berkeahlian khusus di bidang K3 yang dapat membantu pelaksanaan pembinaan dan pengawasan di tempat kerja
● Meningkatkan pengetahuan dan pemahaman tentang peraturan perundang-undangan K3
● Meningkatkan kemampuan dalam menerapkan K3 sesuai peraturan perundang-undangan di tempat kerja''',
      materi: '''● Peraturan Perundang-undangan K3
● Identifikasi, analisis dan penilaian resiko serta pengendalian potensi bahaya pada pekerjaan pemeliharaan dan pengoperasian ● Elevator dan Eskalator
● Pengetahuan dasar teknik Elevator dan Eskalator
● Persyaratan K3 bagian dan komponen serta perlengkapan pengaman Elevator
● Persyaratan K3 bagian dan komponen serta perlengkapan pengaman Eskalator
● Standar teknik pemeliharaan dan pengoperasian Elevator dan Eskalator
● Prosedur kerja aman pada pemeliharaan dan pengoperasian Elevator dan Eskalator
● Pelaksanaan pertolongan pada kecelakaan Elevator dan Eskalator
● Evaluasi

Total JP (Jam Pelajaran) = 45 JP''',
      syaratAdministrasi: '''1. KTP .pdf
2. Ijazah .pdf
3. Curriculum Vitae .pdf
4. Pasfoto Latar Merah .jpg
5. Surat Keterangan Sehat .pdf
6. Surat Keterangan Bekerja .pdf
7. Pakta Intergritas .pdf
8. -''',
      fasilitas: '''● Sertifikat dari Kemnaker RI
● Lisensi dari Kemnaker RI
● E-Certificate dan SK Lulus dari PJK3
● E-Learning (Modul dan Video)
● Kemeja Safety
● Training Kit''',
      metode: 'BLENDED TRAINING',
      detailMetode:
          'Teori via Zoom dan Google Classroom, Praktik WAJIB Tatap Muka',
      syaratKetentuan: '''● Harga tidak termasuk pajak
● Pembayaran dilakukan selambat-lambatnya H-5 pelatihan
● Perusahaan perlu menyediakan fasilitas pelatihan untuk metode Blended/Offline training''',
      instruktur:
          'Instruktur Training merupakan Tenaga Ahli PJK3, Praktisi, Akademisi dan Pejabat Kemnaker/Disnaker.',
      keterangan: 'Pendidikan min. SMA, harga tidak termasuk pajak',
      gambarPelatihan:
          'https://drive.google.com/thumbnail?sz=w500&id=10EQ0guF7o9bRD7PTEcoUuFGKjp1jdP9o',
    ),
    Training(
      idPelatihan: '1',
      kodeBidang: 'UMM',
      bidang: 'Umum',
      namaPelatihan: 'Ahli K3 Umum',
      namaPelatihanKapital: 'AHLI K3 UMUM',
      kodePelatihan: 'AK3U-01',
      durasi: '12 Hari',
      hargaPromo: 5000000,
      hargaNormal: 5500000,
      sertifikasi: 'Sertifikasi Kemnaker RI',
      status: 'Aktif',
      deskripsi: 'Pelatihan Ahli K3 Umum sesuai dengan regulasi Kemnaker RI.',
      dasarHukum: 'UU No. 1 Tahun 1970 tentang Keselamatan Kerja',
      tujuan: 'Mencetak Ahli K3 Umum yang kompeten di perusahaan.',
      materi:
          '• Peraturan Perundangan K3\n• Dasar-dasar K3\n• Manajemen Risiko',
      syaratAdministrasi: 'Scan KTP, Ijazah minimal D3',
      fasilitas: 'Sertifikat, Modul, Makan Siang, Kemeja',
      metode: 'Blended Learning',
      detailMetode: 'Online via Zoom dan Praktik Offline',
      syaratKetentuan: 'Pembayaran lunas sebelum H-7',
      instruktur: 'Instruktur Kemnaker RI',
      keterangan: 'Kuota terbatas 30 peserta',
      gambarPelatihan: '',
    ),
    Training(
      idPelatihan: '2',
      kodeBidang: 'UMM',
      bidang: 'Umum',
      namaPelatihan: 'Petugas Pemadam Kebakaran Kelas D',
      namaPelatihanKapital: 'PETUGAS PEMADAM KEBAKARAN KELAS D',
      kodePelatihan: 'PMK-D-01',
      durasi: '3 Hari',
      hargaPromo: 3000000,
      hargaNormal: 3500000,
      sertifikasi: 'Sertifikasi Kemnaker RI',
      status: 'Aktif',
      deskripsi: 'Pelatihan dasar pemadaman kebakaran.',
      dasarHukum: 'Kepmenaker No. 186 Tahun 1999',
      tujuan: 'Membekali keterampilan memadamkan api kelas awal.',
      materi: '• Fenomena Api\n• Penggunaan APAR\n• Penyelamatan Diri',
      syaratAdministrasi: 'Scan KTP, Surat Sehat',
      fasilitas: 'Sertifikat, Modul, APAR Praktik',
      metode: 'Offline',
      detailMetode: 'Praktik langsung di lapangan',
      syaratKetentuan: 'Wajib membawa baju ganti',
      instruktur: 'Praktisi Damkar',
      keterangan: 'Tersedia asrama',
      gambarPelatihan: '',
    ),
    Training(
      idPelatihan: '3',
      kodeBidang: 'KONS',
      bidang: 'Konstruksi',
      namaPelatihan: 'K3 Bekerja di Ketinggian',
      namaPelatihanKapital: 'K3 BEKERJA DI KETINGGIAN',
      kodePelatihan: 'TKBT-01',
      durasi: '4 Hari',
      hargaPromo: 3500000,
      hargaNormal: 4000000,
      sertifikasi: 'Sertifikasi Kemnaker RI',
      status: 'Aktif',
      deskripsi: 'Pelatihan tingkat dasar bekerja di ketinggian.',
      dasarHukum: 'Permenaker No. 9 Tahun 2016',
      tujuan: 'Mencegah kecelakaan jatuh dari ketinggian.',
      materi: '• Penggunaan Full Body Harness\n• Teknik Anchor\n• Rescue',
      syaratAdministrasi: 'Scan KTP, Ijazah minimal SMA',
      fasilitas: 'Sertifikat, Lisensi K3, Modul',
      metode: 'Offline',
      detailMetode: 'Teori dan Praktik di Tower',
      syaratKetentuan: 'Tidak phobia ketinggian',
      instruktur: 'Instruktur PJK3',
      keterangan: 'Alat pelindung diri disediakan',
      gambarPelatihan: '',
    ),
  ];
}
