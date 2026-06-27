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

  // Ahli K3 Umum Online
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


  return [
    // ahli k3 umum
    Training(
      idPelatihan: '1',
      kodeBidang: '101',
      bidang: 'Keahlian K3 Umum',
      namaPelatihan: 'Ahli K3 Umum Online',
      namaPelatihanKapital: 'AHLI K3 UMUM ONLINE',
      kodePelatihan: 'AK3UOL',
      durasi: 'Sesuai Jadwal',
      hargaPromo: 5000000,
      hargaNormal: 6000000,
      sertifikasi: 'Kemnaker RI',
      status: 'Running',
      deskripsi:
          'Keselamatan dan Kesehatan Kerja (K3) merupakan bagian terpenting dalam sebuah perusahaan. Maka dari itu, tak heran jika banyak perusahaan yang membutuhkan seseorang yang memiliki keahlian dalam bidang tersebut atau disebut dengan Ahli K3 Umum. Ahli K3 Umum (AK3U) adalah tenaga ahli di bidang K3 yang hadir untuk membantu pemerintah maupun perusahaan dalam mengurangi risiko kecelakaan kerja dan penyakit akibat kerja di tempat kerja serta membantu mengawasi ditaatinya Undang-Undang K3. AK3U juga bertugas merancang program atau membuat rekomendasi yang tepat untuk menciptakan lingkungan kerja yang aman dan nyaman, serta tidak merusak ekosistem lingkungan.\n\nBerdasarkan Permenaker No. 4 Tahun 1987 tentang Panitia Pembina Keselamatan dan Kesehatan Kerja Serta Tata Cara Penunjukkan Ahli K3, Setiap tempat kerja dengan kriteria :\n• Memperkerjakan 100 orang atau lebih; atau\n• Mempunyai risiko yang besar akan terjadinya peledakan, kebakaran, keracunan dan\npenyinaran radioaktif\nWAJIB membentuk Panitia Pembina Keselamatan dan Kesehatan Kerja (P2K3). Dalam P2K3 terdapat seorang Sekretaris P2K3 dimana Sekretaris P2K3 ialah Ahli Keselamatan dan Kesehatan Kerja dari perusahaan yang bersangkutan. Untuk memenuhi peraturan tersebut, perusahaan dapat memberikan pembinaan dan sertifikasi kepada tenaga ahlinya melalui PJK3 bekerja sama dengan Kemnaker RI.',
      dasarHukum:
          '• UU No. 1 Tahun 1970\n• Permenaker No. 2 Tahun 1992\n• Kep. DJPPK No. 69 Tahun 2015',
      tujuan:
          '• Mendapatkan tenaga teknis berkeahlian khusus di bidang K3 yang dapat membantu pelaksanaan pembinaan dan pengawasan di tempat kerja\n• Meningkatkan pengetahuan dan pemahaman tentang peraturan perundang-undangan K3\n• Meningkatkan kemampuan dalam menerapkan K3 sesuai peraturan perundang-undangan di tempat kerja',
      materi:
          'KELOMPOK DASAR\n• Kebijakan K3\n• Undang-undang No.1 Tahun 1970\n\nKELOMPOK INTI\n• Pengawasan Norma Kelembagaan dan Keahlian K3\n• Pengawasan Norma Keselematan Kerja Listrik\n• Pengawasan Norma Penanggulangan Kebakaran\n• Pengawasan Norma Keselamatan Kerja Konstruksi dan Bangunan\n• Pengawasan Norma Keselamatan Kerja Mekanik\n• Pengawasan Norma Keselamatan Kerja Pesawat Uap dan Bejana Tekan\n• Pengawasan Norma Kesehatan Kerja\n• Pengawasan Norma Lingkungan Kerja\n• Pengawasan Norma Bahan Berbahaya\n• Pengawasan Norma SMK3\n• Laporan Kecelakaan Kerja\n\nKELOMPOK PENUNJANG\n• Dasar-dasar K3\n• Analisa Kecelakaan\n• Manajemen Risiko\n\nPRAKTIK PEMERIKSAAN K3\n\nEVALUASI\n• Ujian tertulis\n• Seminar\n\nTotal JP (Jam Pelajaran) = 120 JP',
      syaratAdministrasi:
          '1. KTP .pdf\n2. Ijazah .pdf\n3. Curriculum Vitae .pdf\n4. Pasfoto Latar Merah .jpg\n5. Surat Keterangan Sehat .pdf\n6. Surat Keterangan Bekerja .pdf\n7. Pakta Intergritas .pdf\n8. -',
      fasilitas:
          '• Sertifikat dari Kemnaker RI\n• SKP dan Lisensi dari Kemnaker RI\n• E-Certificate dan SK Lulus dari PJK3\n• E-Learning (Modul dan Video)\n• Kemeja Safety\n• Training Kit',
      metode: 'ONLINE TRAINING',
      detailMetode: 'Full Online Training via Zoom dan Google Classroom',
      syaratKetentuan:
          '• Harga tidak termasuk pajak\n• Pembayaran dilakukan selambat-lambatnya H-5 pelatihan\n• Perusahaan perlu menyediakan fasilitas pelatihan untuk metode Blended/Offline training',
      instruktur:
          'Instruktur Training merupakan Tenaga Ahli PJK3, Praktisi, Akademisi dan Pejabat Kemnaker/Disnaker.',
      keterangan: 'Pendidikan min. D3, harga tidak termasuk pajak',
      gambarPelatihan: 'assets/images/flayer_pelatihan/flayer_ahli_k3_umum.png',
    ),
    // Auditor SMK3
    Training(
      idPelatihan: '2',
      kodeBidang: '102',
      bidang: 'Sistem Manajemen K3',
      namaPelatihan: 'Auditor SMK3',
      namaPelatihanKapital: 'AUDITOR SMK3',
      kodePelatihan: 'ASMK3',
      durasi: 'Sesuai Jadwal',
      hargaPromo: 4500000,
      hargaNormal: 5500000,
      sertifikasi: 'Kemnaker RI',
      status: 'Running',
      deskripsi:
          'Auditor SMK3 ialah tenaga teknis yang berkeahlian khusus dan independen untuk melaksanakan audit SMK3 yang ditunjuk oleh Menteri atau pejabat yang ditunjuk. Sistem Manajemen Keselamatan dan Kesehatan Kerja yang selanjutnya disebut SMK3 adalah bagian dari sistem manajemen perusahaan secara keseluruhan dalam rangka pengendalian risiko yang berkaitan dengan kegiatan kerja guna terciptanya tempat kerja yang aman, efisien dan produktif.\n\nUntuk mengetahui sejauh mana penerapan sistem manajemen K3 berdasarkan Permenaker No. 26 Tahun 2014 tentang Penyelenggaraan Penilaian Penerapan Sistem Manajemen Keselamatan dan Kesehatan Kerja, dibutuhkan sebuah alat ukur berupa Audit SMK3. Yang dimaksud Audit SMK3 adalah pemeriksaan secara sistematis dan independen oleh Auditor SMK3 terhadap pemenuhan kriteria yang telah ditetapkan untuk mengukur suatu hasil kegiatan yang telah direncanakan dan dilaksanakan dalam penerapan SMK3 di perusahaan.',
      dasarHukum:
          '• UU No. 1 Tahun 1970\n• PP No. 50 Tahun 2012\n• Permenaker No. 26 Tahun 2014',
      tujuan:
          '• Mendapatkan tenaga teknis berkeahlian khusus di bidang K3 yang dapat membantu pelaksanaan pembinaan dan pengawasan di tempat kerja\n• Meningkatkan pengetahuan dan pemahaman tentang peraturan perundang-undangan K3\n• Meningkatkan kemampuan dalam menerapkan K3 sesuai peraturan perundang-undangan di tempat kerja',
      materi:
          '• Review Materi Keselamatan dan Kesehatan Kerja\n• Kebijakan Keselamatan dan Kesehatan Kerja\n• SMK3 (PP No. 50 Tahun 2012)\n• Penerapan SMK3 (Lampiran I PP No. 50 Tahun 2012)\n• Mekanisme, Teknik Audit SMK3, Tingkat Penerapan SMK3, dan Sertifikasi SMK3\n• Interpretasi Kriteria Audit\n• Pelaksana Audit SMK3 (Lembaga dan Auditor)\n• Simulasi Audit SMK3\n• Evaluasi\n\nTotal JP (Jam Pelajaran) = 40 JP',
      syaratAdministrasi:
          '1. KTP .pdf\n2. Ijazah .pdf\n3. Curriculum Vitae .pdf\n4. Pasfoto Latar Merah .jpg\n5. Surat Keterangan Sehat .pdf\n6. Surat Keterangan Bekerja .pdf\n7. Pakta Intergritas .pdf\n8. Sertifikat AK3U .pdf',
      fasilitas:
          '• Sertifikat dari Kemnaker RI\n• E-Certificate dan SK Lulus dari PJK3\n• E-Learning (Modul dan Video)\n• Kemeja Safety\n• Training Kit',
      metode: 'ONLINE TRAINING',
      detailMetode: 'Full Online Training via Zoom dan Google Classroom',
      syaratKetentuan:
          '• Harga tidak termasuk pajak\n• Pembayaran dilakukan selambat-lambatnya H-5 pelatihan\n• Perusahaan perlu menyediakan fasilitas pelatihan untuk metode Blended/Offline training',
      instruktur:
          'Instruktur Training merupakan Tenaga Ahli PJK3, Praktisi, Akademisi dan Pejabat Kemnaker/Disnaker.',
      keterangan:
          'Pendidikan min. D3, memiliki sertifikat Ahli K3 Umum (AK3U), harga tidak termasuk pajak',
      gambarPelatihan: 'assets/images/flayer_pelatihan/flayer_auditor_smk3.png',
    ),
    // Ahli K3 Listrik
    Training(
      idPelatihan: '3',
      kodeBidang: '103',
      bidang: 'Listrik',
      namaPelatihan: 'Ahli K3 Listrik',
      namaPelatihanKapital: 'AHLI K3 LISTRIK',
      kodePelatihan: 'AK3L',
      durasi: 'Sesuai Jadwal',
      hargaPromo: 15750000,
      hargaNormal: 17000000,
      sertifikasi: 'Kemnaker RI',
      status: 'Running',
      deskripsi:
          'Berdasarkan Permenaker No. 12 Tahun 2015 tentang Keselamatan dan Kesehatan Kerja Listrik di Tempat Kerja, Pengusaha dan/atau pengurus wajib melaksanakan K3 listrik di tempat kerja. Pelaksanaan persyaratan K3 listrik meliputi perencanaan, pemasangan, penggunaan, perubahan, pemeliharaan, pemeriksaan dan pengujian pada kegiatan pembangkitan listrik, transmisi listrik, distribusi listrik dan pemanfaatan listrik yang beroperasi dengan tegangan >50 volt arus bolak-balik (VAC) atau 120 volt arus searah (VDC).\n\nDalam hal Perencanaan, pemasangan, perubahan, pemeliharaan, hingga pemeriksaan dan pengujian harus dilakukan oleh Ahli K3 Listrik, Pada pasal 7 juga disebutkan untuk Perusahaan yang memiliki pembangkitan listrik >200 kilo Volt-Ampere (kVA) wajib mempunya Ahli K3 Listrik. Untuk memenuhi peraturan tersebut, perusahaan dapat memberikan pembinaan dan sertifikasi kepada tenaga ahlinya melalui PJK3 bekerja sama dengan Kemnaker RI.',
      dasarHukum:
          '• UU No. 1 Tahun 1970\n• Permenaker No. 12 Tahun 2015\n• Kep. DJPPK No. 47 Tahun 2015',
      tujuan:
          '• Mendapatkan tenaga teknis berkeahlian khusus di bidang K3 yang dapat membantu pelaksanaan pembinaan dan pengawasan di tempat kerja\n• Meningkatkan pengetahuan dan pemahaman tentang peraturan perundang-undangan K3\n• Meningkatkan kemampuan dalam menerapkan K3 sesuai peraturan perundang-undangan di tempat kerja',
      materi:
          'KELOMPOK DASAR\n• Kebijakan, pembinaan dan pengawasan K3\n• Pembinaan dan pengawasan norma K3 listrik\n\nKELOMPOK INTI\n• Persyaratan K3 perencanaan instalasi, perlengkapan dan peralatan listrik di pembangkitan listrik\n• Persyaratan K3 perencanaan instalasi, perlengkapan dan peralatan listrik di transmisi listrik\n• Persyaratan K3 perencanaan instalasi, perlengkapan dan peralatan listrik di distribusi listrik\n• Persyaratan K3 perencanaan instalasi, perlengkapan dan peralatan listrik di pemanfaatan listrik\n• Persyaratan K3 pemasangan instalasi, perlengkapan dan peralatan listrik di pembangkitan listrik\n• Persyaratan K3 pemasangan instalasi, perlengkapan dan peralatan listrik di transmisi listrik\n• Persyaratan K3 pemasangan instalasi, perlengkapan dan peralatan listrik di distribusi listrik\n• Persyaratan K3 pemasangan instalasi, perlengkapan dan peralatan listrik di pemanfaatan listrik\n• Persyaratan K3 pemeliharaan instalasi, perlengkapan dan peralatan listrik di pembangkitan listrik\n• Persyaratan K3 pemeliharaan instalasi, perlengkapan dan peralatan listrik di transmisi listrik\n• Persyaratan K3 pemeliharaan instalasi, perlengkapan dan peralatan listrik di distribusi listrik\n• Persyaratan K3 pemeliharaan instalasi, perlengkapan dan peralatan listrik di pemanfaatan listriklistrik\n• Persyaratan K3 sistem penyalur petir\n• Persyaratan K3 ruang khusus\n• Persyaratan K3 pemeriksaan dan pengujian instalasi, perlengkapan dan peralatan listrik pertama dan/atau perubahan\n• Persyaratan K3 pemeriksaan dan pengujian instalasi, perlengkapan dan peralatan listrik berkala\n• Praktik\n• Seminar\n\nKELOMPOK PENUNJANG\n• Pelaksanaan K3 listrik dalam penerapan sistem manajemen K3 (Peraturan Pemerintah No. 50 Tahun 2012)\n• Analisis dan pelaporan kecelakaan kerja listrik\n• Kesehatan kerja listrik\n\nEVALUASI\n• Teori\n\nTotal JP (Jam Pelajaran) = 165 JP',
      syaratAdministrasi:
          '1. KTP .pdf\n2. Ijazah .pdf\n3. Curriculum Vitae .pdf\n4. Pasfoto Latar Merah .jpg\n5. Surat Keterangan Sehat .pdf\n6. Surat Keterangan Bekerja .pdf\n7. Pakta Intergritas .pdf\n8. -',
      fasilitas:
          '• Sertifikat dari Kemnaker RI\n• SKP dan Lisensi dari Kemnaker RI\n• E-Certificate dan SK Lulus dari PJK3\n• E-Learning (Modul dan Video)\n• Kemeja Safety\n• Training Kit',
      metode: 'OFFLINE TRAINING',
      detailMetode:
          'Full Offline Training, Teori dan Praktik dilaksanakan secara Tatap Muka',
      syaratKetentuan:
          '• Harga tidak termasuk pajak\n• Pembayaran dilakukan selambat-lambatnya H-5 pelatihan\n• Perusahaan perlu menyediakan fasilitas pelatihan untuk metode Blended/Offline training',
      instruktur:
          'Instruktur Training merupakan Tenaga Ahli PJK3, Praktisi, Akademisi dan Pejabat Kemnaker/Disnaker.',
      keterangan: 'Pendidikan min. D3, harga tidak termasuk pajak',
      gambarPelatihan:
          'assets/images/flayer_pelatihan/flayer_ahli_k3_listrik.png',
    ),
    // Ahli Muda K3 Konstruksi
    Training(
      idPelatihan: '4',
      kodeBidang: '104',
      bidang: 'Konstruksi dan Bangunan',
      namaPelatihan: 'Ahli Muda K3 Konstruksi',
      namaPelatihanKapital: 'AHLI MUDA K3 KONSTRUKSI',
      kodePelatihan: 'AMK3K',
      durasi: 'Sesuai Jadwal',
      hargaPromo: 5500000,
      hargaNormal: 6500000,
      sertifikasi: 'Kemnaker RI',
      status: 'Running',
      deskripsi:
          'Konstruksi bangunan dapat disimpulkan sebagai suatu teknik dalam membangun sebuah bangunan. Teknik membangun sebuah bangunan akan dimulai melalui proses sketsa pada gambar teknik, kemudian perencanaan budget, penentuan konsep, proses pelaksanaan hingga pengawasan.\n\nPelaksanaan proyek konstruksi bangunan mengandung potensi bahaya yang dapat mengancam tenaga kerja dan/atau orang lain yang berada di tempat kerja proyek konstruksi bangunan dan mengancam seluruh tahapan pekerjaan beserta isinya.\n\nUntuk menjamin Keselamatan dan Kesehatan Kerja terhadap tempat kerja proyek konstruksi bangunan diperlukan adanya tenaga kerja yang berkompeten dan memiliki kewenangan. Adapun tenaga kerja tersebut sesuai Kepdirjen PPK No. 20 Tahun 2004 tentang Sertifikasi Kompetensi Keselamatan dan Kesehatan Kerja Bidang Konstruksi Bangunan diantaranya :\n• Ahli Muda K3 Konstruksi\n• Ahli Madya K3 Konstruksi\n• Ahli Utama K3 Konstruksi\n\nSetiap proyek konstruksi bangunan yang mempekerjakan tenaga kerja kurang 25 orang atau penyelenggaraan proyek dibawah 3 (tiga) bulan, harus memiliki sekurang-kurangnya 1 (satu) orang Ahli Muda K3 Konstruksi. Untuk memenuhi peraturan tersebut, perusahaan dapat memberikan pembinaan dan sertifikasi kepada tenaga ahlinya melalui PJK3 bekerja sama dengan Kemnaker RI.',
      dasarHukum:
          '• UU No. 1 Tahun 1970\n• Permenaker No. 1 Tahun 1980\n• Kep. DJPPK No. 20 Tahun 2004',
      tujuan:
          '• Mendapatkan tenaga teknis berkeahlian khusus di bidang K3 yang dapat membantu pelaksanaan pembinaan dan pengawasan di tempat kerja\n• Meningkatkan pengetahuan dan pemahaman tentang peraturan perundang-undangan K3\n• Meningkatkan kemampuan dalam menerapkan K3 sesuai peraturan perundang-undangan di tempat kerja',
      materi:
          '• Undang-Undang No. 01 Tahun 1970\n• Permenakertrans No. 01 Tahun 1980\n• Pengetahuan Teknik Konstruksi\n• Pengetahuan Dasar K3\n• Manajemen dan Administrasi K3\n• K3 Pekerjaan Konstruksi\n• Manajemen Lingkungan\n• K3 Peralatan Konstruksi\n• Sistem Pemadam Kebakaran\n• Kesiagaan dan Sistem Tanggap Darurat\n• Hygiene Perusahaan dan Proyek\n• Manajemen Pelatihan dan Kompetensi K3\n• Penegtahuan Inspeksi K3 Konstruksi\n• Observasi Lapangan & Penyusunan Makalah\n• Seminar\n• Evaluasi Akhir\n\nTotal JP (Jam Pelajaran) = 50 JP',
      syaratAdministrasi:
          '1. KTP .pdf\n2. Ijazah .pdf\n3. Curriculum Vitae .pdf\n4. Pasfoto Latar Merah .jpg\n5. Surat Keterangan Sehat .pdf\n6. Surat Keterangan Bekerja .pdf\n7. Pakta Intergritas .pdf\n8. -',
      fasilitas:
          '• Sertifikat dari Kemnaker RI\n• Lisensi dari Kemnaker RI\n• E-Certificate dan SK Lulus dari PJK3\n• E-Learning (Modul dan Video)\n• Kemeja Safety\n• Training Kit',
      metode: 'ONLINE TRAINING',
      detailMetode: 'Full Online Training via Zoom dan Google Classroom',
      syaratKetentuan:
          '• Harga tidak termasuk pajak\n• Pembayaran dilakukan selambat-lambatnya H-5 pelatihan\n• Perusahaan perlu menyediakan fasilitas pelatihan untuk metode Blended/Offline training',
      instruktur:
          'Instruktur Training merupakan Tenaga Ahli PJK3, Praktisi, Akademisi dan Pejabat Kemnaker/Disnaker.',
      keterangan: 'Pendidikan min. SMA, harga tidak termasuk pajak',
      gambarPelatihan:
          'assets/images/flayer_pelatihan/flayer_ahli_muda_k3_konstruksi.png',
    ),
    // Petugas Peran Kebakaran Kelas D
    Training(
      idPelatihan: '5',
      kodeBidang: '105',
      bidang: 'Penanggulangan Kebakaran',
      namaPelatihan: 'Petugas Peran Kebakaran Kelas D',
      namaPelatihanKapital: 'PETUGAS PERAN KEBAKARAN KELAS D',
      kodePelatihan: 'PPKD',
      durasi: 'Sesuai Jadwal',
      hargaPromo: 4500000,
      hargaNormal: 5500000,
      sertifikasi: 'Kemnaker RI',
      status: 'Running',
      deskripsi:
          'Penanggulangan kebakaran ialah segala upaya untuk mencegah timbulnya kabakaran dengan berbagai upaya pengendalan setiap perwujudan energi, pengadaan sarana proteksi kebakaran dan sarana penyelamatan serta pembentukan organisasi tanggap darurat untuk memberantas kebakaran.\n\nTidak jarang kita mendengar terjadinya kebakaran di tempat kerja ataupun perumahan. Untuk menghindari hal tersebut pada dasarnya terdapat tindakan-tindakan yang harus dilakukan untuk mencegah dan menanggulangi kondisi tersebut yaitu :\n__Tindakan Preventive yaitu tindakan yang dilakukan sebelum terjadi kebakaran dengan maksud menekan atau mengurangi faktor-faktor yang dapat menyebabkan timbulnya kebakaran\n__Tindakan Represive yaitu tindakan yang dilakukan saat terjadi kebakaran dengan maksud untuk mengurangi atau memperkecil kerugian-kerugian yang timbul akibat dari kebakaran.\n__Tindakan Rehabilitative yaitu tindakan yang dilakukan setelah terjadi kebakaran dengan maksud mengevaluasi dan menganalisa peristiwa kebakaran untuk mendapatkan informasi faktor penyebab kebakaran sebagai bahan pengusutan, pemulihan dan penyampaian ke publik\n\nBerdasarkan Kepmenaker No. 186 Tahun 1999 tentang Unit Penanggulangan Kebakaran di Tempat Kerja, Pengurus atau pengusaha wajib mencegah, mengurangi dan memadamkan kebakaran serta latihan penanggulanggan kebakaran di tempat kerja. salah satu kewajiban tersebut yaitu membentuk unit penanggulangan kebakaran di tempat kerja yang terdiri dari :\n• Petugas Peran Kebakaran;\n• Regu Penanggulangan Kebakaran;\n• Koordinator Unit Penanggulangan Kabakaran;\n• Ahli K3 Spesialis Penaggulangan Kebakaran\n\nPetugas Peran Kebakaran wajib dimiliki perusahaan sekurang-kurangnya 2 (dua) orang untuk setiap jumlah tenaga kerja 25 (dua puluh lima) orang. Untuk memenuhi peraturan tersebut, perusahaan dapat memberikan pembinaan dan sertifikasi kepada tenaga teknisnya melalui PJK3 bekerja sama dengan Kemnaker RI.',
      dasarHukum:
          '• UU No. 1 Tahun 1970\n• Permenaker No. 4 Tahun 1980\n• Kepmenaker No. 186 Tahun 1999',
      tujuan:
          '• Mendapatkan tenaga teknis berkeahlian khusus di bidang K3 yang dapat membantu pelaksanaan pembinaan dan pengawasan di tempat kerja\n• Meningkatkan pengetahuan dan pemahaman tentang peraturan perundang-undangan K3\n• Meningkatkan kemampuan dalam menerapkan K3 sesuai peraturan perundang-undangan di tempat kerja',
      materi:
          '• Norma K3 Penanggulangan Kebakaran\n• Manajemen Penanggulangan Kebakaran\n• Teori Api dan Anatomi Kebakaran I\n• Pengenalan Sistem Proteksi Kebakaran\n• Prosedur Darurat Bahaya Kebakaran\n• Praktik Pemadaman\n• Evaluasi\n\nTotal JP (Jam Pelajaran) = 25 JP',
      syaratAdministrasi:
          '1. KTP .pdf\n2. Ijazah .pdf\n3. Curriculum Vitae .pdf\n4. Pasfoto Latar Merah .jpg\n5. Surat Keterangan Sehat .pdf\n6. Surat Keterangan Bekerja .pdf\n7. Pakta Intergritas .pdf\n8. -',
      fasilitas:
          '• Sertifikat dari Kemnaker RI\n• Lisensi dari Kemnaker RI\n• E-Certificate dan SK Lulus dari PJK3\n• E-Learning (Modul dan Video)\n• Kemeja Safety\n• Training Kit',
      metode: 'BLENDED TRAINING',
      detailMetode:
          'Teori via Zoom dan Google Classroom, Praktik WAJIB Tatap Muka',
      syaratKetentuan:
          '• Harga tidak termasuk pajak\n• Pembayaran dilakukan selambat-lambatnya H-5 pelatihan\n• Perusahaan perlu menyediakan fasilitas pelatihan untuk metode Blended/Offline training',
      instruktur:
          'Instruktur Training merupakan Tenaga Ahli PJK3, Praktisi, Akademisi dan Pejabat Kemnaker/Disnaker.',
      keterangan: 'Pendidikan min. SMA, harga tidak termasuk pajak',
      gambarPelatihan:
          'assets/images/flayer_pelatihan/flayer_petugas_peran_kebakaran_kelas_d.png',
    ),
    // Ahli K3 Elevator dan Eskalator
    Training(
      idPelatihan: '6',
      kodeBidang: '106',
      bidang: 'Elevator dan Eskalator',
      namaPelatihan: 'Ahli K3 Elevator dan Eskalator',
      namaPelatihanKapital: 'AHLI K3 ELEVATOR DAN ESKALATOR',
      kodePelatihan: 'AK3EE',
      durasi: 'Sesuai Jadwal',
      hargaPromo: 12000000,
      hargaNormal: 13250000,
      sertifikasi: 'Kemnaker RI',
      status: 'Running',
      deskripsi:
          'Elevator adalah pesawat lift yang mempunyai kereta dan bobot imbang bergerak naik turun mengikuti rel-rel pemandu yang dipasang secara permanen pada bangunan, memiliki governor dan digunakan untuk mengangkut orang dan/atau barang. Adapun Eskalator adalah pesawat transportasi untuk memindahkan orang dan/atau barang, mengikuti jalur lintasan rel yang digerakkan oleh motor listrik.\n\nPenggunaan Elevator dan Eskalator dapat mengakibatkan kerugian baik terhadap harta maupun jiwa manusia sehingga perlu diusahakan pencegahannya, adapun risiko bahaya yang akan dihadapi adalah sengatan listik sehingga penting dilakukan pengecekkan pada seluruh konduktor aliran listrik secara berkala, beban berlebih yang yang dapat membuat mesin roboh atau terputus, malfungsi alat dan human error akibat tidak memperhatikan instruksi penggunaan elevator atau eskalaor yang terkadang melakukan keteledoran sehingga menyebabkan cidera\n\nBerdasarkan Permenaker No. 6 Tahun 2017 tentang Keselamatan dan Kesehatan Kerja Elevator dan Eskalator, Pengurus dan/atau Pengusaha wajib menerapkan syarat K3 Elevator dan Eskalator meliputi kegiatan perencanaan, pembuatan, pemasangan, perakitan, pemakaian, perawatan, pemeliharaan, perbaikan, pemeriksaan dan pengujian. Adapun pemeriksaan dan/atau pengujian Elevator dan Eskalator dilakukan oleh :\n• Pengawas Ketenagakerjaan Spesialis; dan/atau\n• Ahli K3 Elevator dan Eskalator\nUntuk memenuhi peraturan tersebut, perusahaan dapat memberikan pembinaan dan sertifikasi kepada tenaga teknisnya melalui PJK3 bekerja sama dengan Kemnaker RI.',
      dasarHukum: '• UU No. 1 Tahun 1970\n• Permenaker No. 6 Tahun 2017',
      tujuan:
          '• Mendapatkan tenaga teknis berkeahlian khusus di bidang K3 yang dapat membantu pelaksanaan pembinaan dan pengawasan di tempat kerja\n• Meningkatkan pengetahuan dan pemahaman tentang peraturan perundang-undangan K3\n• Meningkatkan kemampuan dalam menerapkan K3 sesuai peraturan perundang-undangan di tempat kerja',
      materi:
          'KELOMPOK DASAR\n• Kebijakan & Peraturan Perundangan K3\n• Dasar- Dasar K3\n• Pengetahuan Dasar Elevator & Eskalator\n\nKELOMPOK INTI\n• Manajemen Resiko Elevator & Eskalator\n• Komponen & Pelengkapan Keamanan\n• Teknik Perencanaan\n• Konstruksi & Tata Letak\n• Kelistrikan & Pengkabelan\n• Standar Teknik Pemasangan\n• Standar Teknik Pengoperasian\n• Standar Teknik Pemeliharaan & Perawatan\n• Pemeriksaan & Pengujian\n• Prosedur Kerja Aman & Penyelamatan\n• Observasi & Praktek Lapangan\n\nEVALUASI\n• Ujian tertulis\n• Seminar\n\nTotal JP (Jam Pelajaran) = 120 JP',
      syaratAdministrasi:
          '1. KTP .pdf\n2. Ijazah .pdf\n3. Curriculum Vitae .pdf\n4. Pasfoto Latar Merah .jpg\n5. Surat Keterangan Sehat .pdf\n6. Surat Keterangan Bekerja .pdf\n7. Pakta Intergritas .pdf\n8. -',
      fasilitas:
          '• Sertifikat dari Kemnaker RI\n• SKP dan Lisensi dari Kemnaker RI\n• E-Certificate dan SK Lulus dari PJK3\n• E-Learning (Modul dan Video)\n• Kemeja Safety\n• Training Kit',
      metode: 'OFFLINE TRAINING',
      detailMetode:
          'Full Offline Training, Teori dan Praktik dilaksanakan secara Tatap Muka',
      syaratKetentuan:
          '• Harga tidak termasuk pajak\n• Pembayaran dilakukan selambat-lambatnya H-5 pelatihan\n• Perusahaan perlu menyediakan fasilitas pelatihan untuk metode Blended/Offline training',
      instruktur:
          'Instruktur Training merupakan Tenaga Ahli PJK3, Praktisi, Akademisi dan Pejabat Kemnaker/Disnaker.',
      keterangan: 'Pendidikan min. D3, harga tidak termasuk pajak',
      gambarPelatihan:
          'assets/images/flayer_pelatihan/flayer_ahli_k3_elevator_dan_eskalator.png',
    ),
    // Ahli K3 Muda Lingkungan Kerja
    Training(
      idPelatihan: '7',
      kodeBidang: '107',
      bidang: 'Lingkungan Kerja dan Bahan Berbahaya',
      namaPelatihan: 'Ahli K3 Muda Lingkungan Kerja',
      namaPelatihanKapital: 'AHLI K3 MUDA LINGKUNGAN KERJA',
      kodePelatihan: 'AK3MLK',
      durasi: 'Sesuai Jadwal',
      hargaPromo: 8500000,
      hargaNormal: 9500000,
      sertifikasi: 'Kemnaker RI',
      status: 'Running',
      deskripsi:
          'Lingkungan Kerja adalah aspek Higiene di tempat kerja yang di dalamnya mencakup faktor fisika, kimia, biologi, ergonomi dan psikologi yang keberadaannya di tempat kerja dapat mempengaruhi keselamatan dan kesehatan tenaga kerja. Keselamatan dan Kesehatan Kerja Lingkungan Kerja yang selanjutnya disebut dengan K3 Lingkungan Kerja adalah segala kegiatan untuk menjamin dan melindungi keselamatan dan kesehatan Tenaga Kerja melalui pengendalian Lingkungan Kerja dan penerapan Higiene Sanitasi di Tempat Kerja.\n\nUntuk mewujudkan lingkungan kerja yang aman, sehat, dan nyaman serta mencegah kecelakaan kerja dan penyakit akibat kerja, Pemerintah telah menerbitkan Permenaker No. 5 Tahun 2018 tentang Keselamatan dan Kesehatan Kerja Lingkungan Kerja yang salah satunya mengatur pelaksanaan syarat-syarat K3 lingkungan kerja melalui kegiatan pengukuran dan pengendalian lingkungan kerja dan penerapan higiene dan sanitasi. Pengukuran dan pengendalian lingkungan kerja harus dilakukan oleh :\n• Ahli K3 Muda Lingkungan Kerja\n• Ahli K3 Madya Lingkungan Kerja\n• Ahli K3 Utama Lingkungan Kerja\nUntuk memenuhi peraturan tersebut, perusahaan dapat memberikan pembinaan dan sertifikasi kepada tenaga ahlinya melalui PJK3 bekerja sama dengan Kemnaker RI',
      dasarHukum: '• UU No. 1 Tahun 1970\n• Permenaker No. 5 Tahun 2018',
      tujuan:
          '• Mendapatkan tenaga teknis berkeahlian khusus di bidang K3 yang dapat membantu pelaksanaan pembinaan dan pengawasan di tempat kerja\n• Meningkatkan pengetahuan dan pemahaman tentang peraturan perundang-undangan K3\n• Meningkatkan kemampuan dalam menerapkan K3 sesuai peraturan perundang-undangan di tempat kerja',
      materi:
          '• Peraturan Perundang-undangan K3\n• Program Higiene Industri: Antisipasi, rekognisi, evaluasi dan pengendalian bahaya di tempat kerja\n• Pengenalan risiko kesehatan dan promosi kesehatan kerja\n• Sistim inforrnasi lingkungan kerja\n• Teknik pengumpulan sampel faktor fisika, kimia, biologi, ergonomi dan psikologi\n• Ventilasi industri\n• Evaluasi\n• Praktik dan Uji Kompetensi\n\nTotal JP (Jam Pelajaran) = 90 JP',
      syaratAdministrasi:
          '1. KTP .pdf\n2. Ijazah .pdf\n3. Curriculum Vitae .pdf\n4. Pasfoto Latar Merah .jpg\n5. Surat Keterangan Sehat .pdf\n6. Surat Keterangan Bekerja .pdf\n7. Pakta Intergritas .pdf\n8. -',
      fasilitas:
          '• Sertifikat dari Kemnaker RI\n• SKP dan Lisensi dari Kemnaker RI\n• E-Certificate dan SK Lulus dari PJK3\n• E-Learning (Modul dan Video)\n• Kemeja Safety\n• Training Kit',
      metode: 'OFFLINE TRAINING',
      detailMetode:
          'Teori via Zoom dan Google Classroom, Praktik WAJIB Tatap Muka',
      syaratKetentuan:
          '• Harga tidak termasuk pajak\n• Pembayaran dilakukan selambat-lambatnya H-5 pelatihan\n• Perusahaan perlu menyediakan fasilitas pelatihan untuk metode Blended/Offline training',
      instruktur:
          'Instruktur Training merupakan Tenaga Ahli PJK3, Praktisi, Akademisi dan Pejabat Kemnaker/Disnaker.',
      keterangan: 'Pendidikan min. D3, harga tidak termasuk pajak',
      gambarPelatihan:
          'assets/images/flayer_pelatihan/flayer_ahli_k3_muda_lingkungan_kerja.png',
    ),
    // Tenaga Kerja Bangunan Tinggi Tingkat 2
    Training(
      idPelatihan: '8',
      kodeBidang: '108',
      bidang: 'Bekerja Pada Ketinggian',
      namaPelatihan: 'Tenaga Kerja Bangunan Tinggi Tingkat 2',
      namaPelatihanKapital: 'TENAGA KERJA BANGUNAN TINGGI TINGKAT 2',
      kodePelatihan: 'TKBT2',
      durasi: 'Sesuai Jadwal',
      hargaPromo: 4750000,
      hargaNormal: 5750000,
      sertifikasi: 'Kemnaker RI',
      status: 'Running',
      deskripsi:
          'Bekerja di Ketinggian adalah kegiatan atau aktifitas pekerjaan yang dilakukan oleh tenaga kerja pada tempat kerja di permukaan tanah atau perairan yang terdapat perbedaan ketinggian dan memiliki potensi jatuh yang menyebabkan tenaga kerja atau orang lain yang berada di tempat kerja cidera atau meninggal dunia atau menyebabkan kerusakan harta benda.\n\nUntuk mengantisipasi kerugian tersebut, sesuai dengan Permenaker No. 9 Tahun 2016 tentang Keselamatan dan Kesehatan Kerja dalam Pekerjaan pada Ketinggian, Pengusaha dan/atau Pengurus wajib menyediakan tenaga kerja yang kompeten dan berwenang di bidang K3 dalam pekerjaan pada ketinggian. Tenaga kerja tersebut meliputi :\n• Tenaga Kerja Bangunan Tinggi Tingkat 1\n• Tenaga Kerja Bangunan Tinggi Tingkat 2\n• Tenaga Kerja Pada Ketinggian Tingkat 1\n• Tenaga Kerja Pada Ketinggian Tingkat 2\n• Tenaga Kerja Pada Ketinggian Tingkat 3\n\nTenaga Kerja Pada Ketinggian merupakan tenaga kerja yang mampu bekerja dan berwenang bekerja pada lantai kerja tetap , lantai kerja sementara, bergerak menuju dan meninggalkan lantai kerja tetap atau lantai kerja sementara secara horisontal dan vertikal pada struktur bangunan, bekerja pada posisi atau tempat kerja miring, akses tali dan/atau menaikkan dan menurunkan barang dengan sistem katrol atau dengan bantuan tenaga mesin. Untuk memenuhi peraturan tersebut, perusahaan dapat memberikan pembinaan dan sertifikasi kepada tenaga Para Medisnya melalui PJK3 bekerja sama dengan Kemnaker RI',
      dasarHukum: '• UU No. 1 Tahun 1970\n• Permenaker No. 9 Tahun 2016',
      tujuan:
          '• Mendapatkan tenaga teknis berkeahlian khusus di bidang K3 yang dapat membantu pelaksanaan pembinaan dan pengawasan di tempat kerja\n• Meningkatkan pengetahuan dan pemahaman tentang peraturan perundang-undangan K3\n• Meningkatkan kemampuan dalam menerapkan K3 sesuai peraturan perundang-undangan di tempat kerja',
      materi:
          'KELOMPOK DASAR\n• Perundang-undangan K3 dalam pekerjaan pada ketinggian\n\nKELOMPOK INTI\n• Identifikasi bahaya dalam kegiatan akses tali\n• Pengetahuan kondisi ketidaktahanan tergantung (suspension intolerance) dan penanganannya\n• Penerapan prinsip-prinsip faktor jatuh (fall factor) dalam akses tali\n• Pemilihan, pemeriksaan dan pemakaian peralatan akses tali yang sesuai\n• Simpul dan angkur dasar\n• Teknik manuver pergerakan pada tali\n• Teknik pemanjatan pada struktur\n\nKELOMPOK PENUNJANG\n• Teknik penyelamatan diri sendiri dan korban menuju arah turun dengan alat turun\n\nEVALUASI\n• Teori\n• Praktik\n\nTotal JP (Jam Pelajaran) = 30 JP',
      syaratAdministrasi:
          '1. KTP .pdf\n2. Ijazah .pdf\n3. Curriculum Vitae .pdf\n4. Pasfoto Latar Merah .jpg\n5. Surat Keterangan Sehat .pdf\n6. Surat Keterangan Bekerja .pdf\n7. Pakta Intergritas .pdf\n8. -',
      fasilitas:
          '• Sertifikat dari Kemnaker RI\n• Lisensi dari Kemnaker RI\n• E-Certificate dan SK Lulus dari PJK3\n• E-Learning (Modul dan Video)\n• Kemeja Safety\n• Training Kit',
      metode: 'BLENDED TRAINING',
      detailMetode:
          'Teori via Zoom dan Google Classroom, Praktik WAJIB Tatap Muka',
      syaratKetentuan:
          '• Harga tidak termasuk pajak\n• Pembayaran dilakukan selambat-lambatnya H-5 pelatihan\n• Perusahaan perlu menyediakan fasilitas pelatihan untuk metode Blended/Offline training',
      instruktur:
          'Instruktur Training merupakan Tenaga Ahli PJK3, Praktisi, Akademisi dan Pejabat Kemnaker/Disnaker.',
      keterangan: 'Pendidikan min. SMA, harga tidak termasuk pajak',
      gambarPelatihan:
          'assets/images/flayer_pelatihan/flayer_tenaga_kerja_bangunan_tinggi_tingkat_2.png',
    ),
    // Petugas P3K
    Training(
      idPelatihan: '9',
      kodeBidang: '109',
      bidang: 'Kesehatan Kerja',
      namaPelatihan: 'Petugas P3K',
      namaPelatihanKapital: 'PETUGAS P3K',
      kodePelatihan: 'PP3K',
      durasi: 'Sesuai Jadwal',
      hargaPromo: 5000000,
      hargaNormal: 6000000,
      sertifikasi: 'Kemnaker RI',
      status: 'Running',
      deskripsi:
          'Pertolongan Pertama Pada Kecelakaan (P3K) adalah pertolongan dan perawatan sementara yang dilakukan kepada korban kecelakaan di tempat kerja menggunakan peralatan sederhana sebelum korban mendapatkan pertolongan yang sempurna. Meski hanya menggunakan peralatan sederhana, P3K bisa menjadi salah satu solusi untuk memberi pertolongan secara cepat dan tepat dalam mencegah keparahan cidera, mengurangi penderitaan dan bahkan menyelamatkan nyawa korban. Jika tindakan P3K tidak dilakukan saat terjadi kecelakaan di tempat kerja, akibatnya dapat memperburuk keadaan korban bahkan menimbulkan kematian.\n\nBerdasarkan Permenaker No. 15 Tahun 2008 tentang Pertolongan Pertama Pada Kecelakaan di Tempat Kerja, Pengusaha wajib menyediakan petugas P3K dan fasilitas P3K di tempat kerja. Petugas P3K di tempat kerja ditentukan berdasarkan jumlah pekerja/buruh dan potensi bahaya di tempat kerja, dengan rasio sebagai berikut :\n• 1 Petugas P3K : 150 Pekerja, untuk klasifikasi tempat kerja dengan potensi bahaya rendah\n• 1 Petugas P3K : 100 Pekerja, untuk klasifikasi tempat kerja dengan potensi bahaya tinggi\nUntuk memenuhi peraturan tersebut, perusahaan dapat memberikan pembinaan dan sertifikasi kepada tenaga kerjanya melalui PJK3 bekerja sama dengan Kemnaker RI',
      dasarHukum:
          '• UU No. 1 Tahun 1970\n• Permenaker No. 15 Tahun 2008\n• Kep. DJPPK No. 53 Tahun 2009',
      tujuan:
          '• Mendapatkan tenaga teknis berkeahlian khusus di bidang K3 yang dapat membantu pelaksanaan pembinaan dan pengawasan di tempat kerja\n• Meningkatkan pengetahuan dan pemahaman tentang peraturan perundang-undangan K3\n• Meningkatkan kemampuan dalam menerapkan K3 sesuai peraturan perundang-undangan di tempat kerja',
      materi:
          'KELOMPOK DASAR\n• Dasar-Dasar Kesehatan Kerja dan Peraturan Perundangan Bidang P3K di Tempat Kerja\n• Dasar-Dasar P3K di Tempat Kerja\n\nKELOMPOK INTI\n• Anatomi dan Fisiologi Manusia\n• Pertolongan Pertama pada Gangguan Umum\n• Resusitasi Jantung Paru\n• Pertolongan Pertama pada Gangguan Lokal\n• Pertolongan Pertama pada Gangguan Kejang, Pajanan Suhu Lingkungan dan Bahan Kimia\n• Pertolongan Pertama pada Keadaan Khusus\n• Tanggap Darurat dan Evakuasi Korban dalam Pertolongan Pertama\n\nKELOMPOK PENUNJANG\n• Evaluasi\n\nTotal JP (Jam Pelajaran) = 30 JP',
      syaratAdministrasi:
          '1. KTP .pdf\n2. Ijazah .pdf\n3. Curriculum Vitae .pdf\n4. Pasfoto Latar Merah .jpg\n5. Surat Keterangan Sehat .pdf\n6. Surat Keterangan Bekerja .pdf\n7. Pakta Intergritas .pdf\n8. -',
      fasilitas:
          '• Sertifikat dari Kemnaker RI\n• E-Certificate dan SK Lulus dari PJK3\n• E-Learning (Modul dan Video)\n• Kemeja Safety\n• Training Kit',
      metode: 'BLENDED TRAINING',
      detailMetode:
          'Teori via Zoom dan Google Classroom, Praktik WAJIB Tatap Muka',
      syaratKetentuan:
          '• Harga tidak termasuk pajak\n• Pembayaran dilakukan selambat-lambatnya H-5 pelatihan\n• Perusahaan perlu menyediakan fasilitas pelatihan untuk metode Blended/Offline training',
      instruktur:
          'Instruktur Training merupakan Tenaga Ahli PJK3, Praktisi, Akademisi dan Pejabat Kemnaker/Disnaker.',
      keterangan: 'Pendidikan min. SMA, harga tidak termasuk pajak',
      gambarPelatihan: 'assets/images/flayer_pelatihan/flayer_petugas_p3k.png',
    ),
    // K3 Rumah Sakit
    Training(
      idPelatihan: '10',
      kodeBidang: '109',
      bidang: 'Kesehatan Kerja',
      namaPelatihan: 'K3 Rumah Sakit',
      namaPelatihanKapital: 'K3 RUMAH SAKIT',
      kodePelatihan: 'K3RS',
      durasi: 'Sesuai Jadwal',
      hargaPromo: 5000000,
      hargaNormal: 6000000,
      sertifikasi: 'Kemnaker RI',
      status: 'Running',
      deskripsi: '-',
      dasarHukum: '-',
      tujuan: '-',
      materi: '-',
      syaratAdministrasi: '-',
      fasilitas: '-',
      metode: 'ONLINE TRAINING',
      detailMetode: '-',
      syaratKetentuan: '-',
      instruktur: '-',
      keterangan: '-',
      gambarPelatihan:
          'assets/images/flayer_pelatihan/flayer_k3_rumah_sakit.png',
    ),
    // Ahli K3 Pesawat Angkat dan Pesawat Angkut
    Training(
      idPelatihan: '11',
      kodeBidang: '110',
      bidang: 'Pesawat Angkat dan Pesawat Angkut',
      namaPelatihan: 'Ahli K3 Pesawat Angkat dan Pesawat Angkut',
      namaPelatihanKapital: 'AHLI K3 PESAWAT ANGKAT DAN PESAWAT ANGKUT',
      kodePelatihan: 'AK3PAPA',
      durasi: 'Sesuai Jadwal',
      hargaPromo: 28000000,
      hargaNormal: 29500000,
      sertifikasi: 'Kemnaker RI',
      status: 'Running',
      deskripsi:
          'Pesawat Angkat adalah pesawat atau peralatan yang dibuat dan dipasang untuk mengangkat, menurunkan, mengatur posisi dan/atau menahan benda kerja dan/atau muatan. Adapun Pesawat Angkut adalah pesawat atau peralatan yang dibuat dan dibangun untuk memindahkan benda, muatan atau orang secara horisontal, vertikal, diagonal dengan menggunakan kemudi baik di dalam atau di luar pesawatnya, ataupun tidak menggunakan kemudi dan bergerak di atas landasan, permukaan maupun rel atau secara terus menerus dengan menggunakan bantuan ban, atau rantai atau rol.\n\nBerdasarkan Permenaker No. 8 Tahun 2020 tentang Keselamatan dan Kesehatan Pesawat Angkat dan Pesawat Angkut : Setiap kegiatan perencanaan, pembuatan, pemasangan dan/atau perakitan, pemakaian atau pengoperasian, perbaikan, perubahan atau modifikasi Pesawat Angkat dan Pesawat Angkut harus dilakukan pemeriksaan dan pengujian oleh :\n• Pengawas Ketenagakerjaan Spesialis K3 Pesawat Angkat dan Pesawat Angkut;\n• Penguji K3 yang mempunyai kompetensi di bidang Pesawat Angkat dan Pesawat Angkut; atau\n• Ahli K3 Bidang Pesawat Pesawat Angkat dan Pesawat Angkut\nUntuk dapat ditunjuk sebagai Ahli K3 Bidang Pesawat Angkat dan Pesawat Angkut sesuai dengan ketentuan peraturan perundang-undangan, perusahaan dapat memberikan pembinaan dan sertifikasi kepada tenaga ahlinya melalui PJK3 bekerjasama dengan Kemnaker RI.',
      dasarHukum: '• UU No. 1 Tahun 1970\n• Permenaker No. 8 Tahun 2020',
      tujuan:
          '• Mendapatkan tenaga teknis berkeahlian khusus di bidang K3 yang dapat membantu pelaksanaan pembinaan dan pengawasan di tempat kerja\n• Meningkatkan pengetahuan dan pemahaman tentang peraturan perundang-undangan K3\n• Meningkatkan kemampuan dalam menerapkan K3 sesuai peraturan perundang-undangan di tempat kerja',
      materi:
          'KELOMPOK DASAR\n• Kebijakan K3\n• Peraturan perundang-undangan K3 di bidang pesawat angkat dan pesawat angkut\n• Dasar-dasar K3\n• Sistem Manajemen K3\n• Investigasi Kecelakaan Kerja\n\nKELOMPOK INTI\n• Jenis-jenis dan proses kerja pesawat angkat dan pesawat angkut\n• Perlengkapan dan pengamanan pesawat angkat dan pesawat angkut (safety device) dan APD\n• Sistem hidraulik dan pneumatik\n• Perhitungan kekuatan konstruksi pesawat angkat dan pesawat angkut\n• Tali kawat baja dan alat bantu angkut dan angkut\n• Pengikatan (rigging) untuk pengujian beban\n• Stabilitas dan daftar beban\n• Penyusunan Inspection Test Plan (ITP)\n• Pengelasan dan pengujian tidak merusak (Non Destructive Test)\n• Pemeriksaan dan pengujian pesawat angkat dan pesawat angkut\n• Praktik pemeriksaan dan pengujian pesawat angkat dan pesawat angkut\n\nKELOMPOK PENUNJANG\n• Mekanika teknik terapan\n• Kelistrikan\n• Pengetahuan motor penggerak\n• Pengetahuan bahan\n• Pengetahuan korosi dan pencegahannya\n• Membaca gambar teknik\n\nEVALUASI\n• Penulisan kertas kerja\n• Evaluasi teori\n• Seminar\n\nTotal JP (Jam Pelajaran) = 250 JP',
      syaratAdministrasi:
          '1. KTP .pdf\n2. Ijazah .pdf\n3. Curriculum Vitae .pdf\n4. Pasfoto Latar Merah .jpg\n5. Surat Keterangan Sehat .pdf\n6. Surat Keterangan Bekerja .pdf\n7. Pakta Intergritas .pdf\n8. -',
      fasilitas:
          '• Sertifikat dari Kemnaker RI\n• SKP dan Lisensi dari Kemnaker RI\n• E-Certificate dan SK Lulus dari PJK3\n• E-Learning (Modul dan Video)\n• Kemeja Safety\n• Training Kit',
      metode: 'OFFLINE TRAINING',
      detailMetode:
          'Full Offline Training, Teori dan Praktik dilaksanakan secara Tatap Muka',
      syaratKetentuan:
          '• Harga tidak termasuk pajak\n• Pembayaran dilakukan selambat-lambatnya H-5 pelatihan\n• Perusahaan perlu menyediakan fasilitas pelatihan untuk metode Blended/Offline training',
      instruktur:
          'Instruktur Training merupakan Tenaga Ahli PJK3, Praktisi, Akademisi dan Pejabat Kemnaker/Disnaker.',
      keterangan: 'Pendidikan min. D3, harga tidak termasuk pajak',
      gambarPelatihan: 'assets/images/flayer_pelatihan/flayer_ahli_k3_papa.png',
    ),
    // Ahli K3 Pesawat Tenaga dan Produksi
    Training(
      idPelatihan: '12',
      kodeBidang: '111',
      bidang: 'Pesawat Tenaga dan Produksi',
      namaPelatihan: 'Ahli K3 Pesawat Tenaga dan Produksi',
      namaPelatihanKapital: 'AHLI K3 PESAWAT TENAGA DAN PRODUKSI',
      kodePelatihan: 'AK3PTP',
      durasi: 'Sesuai Jadwal',
      hargaPromo: 28000000,
      hargaNormal: 29500000,
      sertifikasi: 'Kemnaker RI',
      status: 'Running',
      deskripsi:
          'Pesawat Tenaga dan Produksi adalah pesawat atau alat yang tetap atau berpindah-pindah, dipakai atau dipasang untuk membangkitkan atau memindahkan daya / tenaga, mengolah, membuat : bahan, barang, produk teknis dan komponen alat produksi. Adapun jenis-jenis Pesawat Tenaga dan Produksi meliputi penggerak mula, mesin perkakas dan produksi, transmisi tenaga mekanik dan tanur (furnace)\n\nBerdasarkan Permenaker No. 38 Tahun 2016 tentang Keselamatan dan Kesehatan Pesawat Tenaga dan Produksi : Setiap kegiatan perencanaan, pembuatan, pemasangan atau perakitan, pengoperasian, pemeliharaan, perbaikan, perubahaan atau modifikasi Pesawat Tenaga dan Produksi harus dilakukan pemeriksaan dan/atau pengujian oleh :\n• Pengawas Ketenagakerjaan Spesialis; atau\n• Ahli K3 Bidang Pesawat Tenaga dan Produksi\nUntuk dapat ditunjuk sebagai Ahli K3 Bidang Pesawat Tenaga dan Produksi sesuai dengan ketentuan peraturan perundang-undangan, perusahaan dapat memberikan pembinaan dan sertifikasi kepada tenaga ahlinya melalui PJK3 bekerjasama dengan Kemnaker RI.',
      dasarHukum: '• UU No. 1 Tahun 1970\n• Permenaker No. 38 Tahun 2016',
      tujuan:
          '• Mendapatkan tenaga teknis berkeahlian khusus di bidang K3 yang dapat membantu pelaksanaan pembinaan dan pengawasan di tempat kerja\n• Meningkatkan pengetahuan dan pemahaman tentang peraturan perundang-undangan K3\n• Meningkatkan kemampuan dalam menerapkan K3 sesuai peraturan perundang-undangan di tempat kerja',
      materi:
          'KELOMPOK DASAR\n• Kebijakan K3\n• Undang-Undang No. 1 Tahun 1970\n• Dasar-dasar K3\n• Sistem Manajemen K3\n• Investigasi Kecelakaan Kerja\n\nKELOMPOK INTI\n• Peraturan perundang-undangan K3 di Bidang Pesawat Tenaga dan Produksi\n• Penggerak Mula (Turbin Uap, Turbin Gas, Turbin Air, Kincir Angin, Motor Bakar dan Motor Gas) termasuk Transmisi Tenaga Mekanik\n• Mesin Perkakas\n• Mesin Produksi\n• Tanur dan Dapur\n• Teknik Pondasi\n• Dasar-dasar penilaian perhitungan konstruksi pesawat tenaga dan produksi\n• Sumber Bahaya Pesawat Tenaga dan Produksi\n• Pengelasan dan Pengujian Tidak Merusak (Non Destruktive Test)\n• Pemeriksaan / Pengujian Motor Bakar\n• Pemeriksaan / Pengujian Turbin\n• Pemeriksaan / Pengujian Kincir Angin\n• Pemeriksaan / Pengujian Perlengkapan Transmisi Tenaga Mekanik\n• Pemeriksaan / Pengujian Mesin Produksi\n• Pemeriksaan / Pengujian Mesin Perkakas\n• Pemeriksaan / Pengujian Dapur / Tanur\n• Pemeriksaan / Pengujian Pondasi\n• Praktik Kerja Lapangan\n\nKELOMPOK PENUNJANG\n• Mekanika Teknik Terapan\n• Kelistrikan\n• Pengetahuan Bahan\n• Pengetahuan Korosi dan Pencegahannya\n\nEVALUASI\n• Penulisan kertas kerja\n• Evaluasi teori\n• Seminar\n\nTotal JP (Jam Pelajaran) = 250 JP',
      syaratAdministrasi:
          '1. KTP .pdf\n2. Ijazah .pdf\n3. Curriculum Vitae .pdf\n4. Pasfoto Latar Merah .jpg\n5. Surat Keterangan Sehat .pdf\n6. Surat Keterangan Bekerja .pdf\n7. Pakta Intergritas .pdf\n8. -',
      fasilitas:
          '• Sertifikat dari Kemnaker RI\n• SKP dan Lisensi dari Kemnaker RI\n• E-Certificate dan SK Lulus dari PJK3\n• E-Learning (Modul dan Video)\n• Kemeja Safety\n• Training Kit',
      metode: 'OFFLINE TRAINING',
      detailMetode:
          'Full Offline Training, Teori dan Praktik dilaksanakan secara Tatap Muka',
      syaratKetentuan:
          '• Harga tidak termasuk pajak\n• Pembayaran dilakukan selambat-lambatnya H-5 pelatihan\n• Perusahaan perlu menyediakan fasilitas pelatihan untuk metode Blended/Offline training',
      instruktur:
          'Instruktur Training merupakan Tenaga Ahli PJK3, Praktisi, Akademisi dan Pejabat Kemnaker/Disnaker.',
      keterangan: 'Pendidikan min. D3, harga tidak termasuk pajak',
      gambarPelatihan: 'assets/images/flayer_pelatihan/flayer_ahli_k3_ptp.png',
    ),
    // Ahli K3 Pesawat Uap, Bejana Tekanan dan Tangki Timbun
    Training(
      idPelatihan: '13',
      kodeBidang: '112',
      bidang: 'Pesawat Uap, Bejana Tekanan dan Tangki Timbun',
      namaPelatihan: 'Ahli K3 Pesawat Uap, Bejana Tekanan dan Tangki Timbun',
      namaPelatihanKapital:
          'AHLI K3 PESAWAT UAP, BEJANA TEKANAN DAN TANGKI TIMBUN',
      kodePelatihan: 'AK3PUBT',
      durasi: 'Sesuai Jadwal',
      hargaPromo: 28000000,
      hargaNormal: 29500000,
      sertifikasi: 'Kemnaker RI',
      status: 'Running',
      deskripsi:
          'Pesawat Uap atau biasa disebut dengan ketel uap merupakan suatu pesawat yang dibuat untuk mengubah air didalannya, sebagian menjadi uap dengan jalan pemanasan menggunakan pembakaran dari bahan bakar. Untuk ketel uap sendiri merupakan bejana yang tertutup dan tidak berhubungan dengan udara dari luar selama pemanasannya, maka air akan mendidih. Selanjutnya berubah menjadi uap panas dan bertekanan, sehingga berpotensi terjadinya ledakan jika terjadi kelebihan tekanan. Adapun Bejana Tekan merupakan suatu wadah untuk menampung energi berupa zat cair atau gas yang melebihi tekanan udara luar (Atmosfer).\n\nPemanfaatan Pesawat Uap dan Bejana Tekan telah berkembang pesat di berbagai proses industri barang dan jasa maupun untuk fasilitas umum. Keduanya merupakan peralatan teknik yang mengandung resiko bahaya tinggi yang dapat menyebabkan terjadinya kecelakaan atau peledakan. Tingginya resiko kecelakaan kerja dibidang Pesawat Uap dan Bejana Tekan (PUBT) membuat perusahaan semakin waspada akan bahaya yang mungkin ditimbulkan dari kecelakaan kerja PUBT.\n\nOleh karena itu, guna menghindari agar tidak terjadi kecelakaan atau peledakan, sangat penting untuk melakukan prosedur pengoperasian PUBT sesuai dengan standar yang berlaku. Sebelum dalam periode pemakaian setiap bejana tekan dan alat pengaman/perlengkapannya harus dilakukan pemeriksaan, pengujian, serta dirawat dengan baik dan teratur. Adanya tenaga kerja yang telah memiliki sertifikat Ahli K3 PUBT juga merupakan faktor penting dalam menunjang pencegahan kecelakaan kerja PUBT yang mungkin terjadi karena dapat meminimalisir faktor – faktor yang dapat menjadi sumber kecelakaan kerja PUBT terutama human error dalam pengoperasian PUBT, sebagaimana diketahui bahwa human error berdampak besar sebagai asal mula terjadinya sebuah kecelakaan kerja.',
      dasarHukum:
          '• UU No. 1 Tahun 1970\n• Peraturan Uap Tahun 1930\n• Permenaker No. 37 Tahun 2016',
      tujuan:
          '• Mendapatkan tenaga teknis berkeahlian khusus di bidang K3 yang dapat membantu pelaksanaan pembinaan dan pengawasan di tempat kerja\n• Meningkatkan pengetahuan dan pemahaman tentang peraturan perundang-undangan K3\n• Meningkatkan kemampuan dalam menerapkan K3 sesuai peraturan perundang-undangan di tempat kerja',
      materi:
          'KELOMPOK DASAR\n• Kebijakan K3\n• Dasar-dasar K3\n• Undang-Undang No. 1 Tahun 1970\n• Sistem Manajemen K3\n• Investigasi Kecelakaan Kerja\n\nKELOMPOK INTI\n• Peraturan perundang-undangan K3 di Bidang Pesawat Uap dan Bejana Tekan\n• Jenis- Jenis Pesawat Uap dan Perlengkapannya\n• Jenis- Jenis Bejana Tekan dan Perlengkapannya\n• Perhitungan Kekuatan Konstruksi Pesawat Uap dan Bejana tekan\n• Pipa Penyalur\n• Pengetahuan Bahan\n• Teknik Pengelasan dan Pengujian Tidak Merusak (Non Destructive Test)\n• Air Pengisi Ketel Uap\n• Pembuatan, Pemasangan dan Reparasi / Modifikasi\n• Pemeriksaan dan Pengujian Pesawat Uap dan Pipa Penyalur\n• Pemeriksaan dan Pengujian Bejana tekan\n• Praktik Kerja Lapangan\n\nKELOMPOK PENUNJANG\n• K3 Nuklir\n• Korosi dan Pencegahannya\n• Kelistrikan dan Alat Kontrol Otomatis\n• Pondasi dan Kerangka Dudukan\n\nEVALUASI\n• Ujian Teori\n• Penulisan kertas kerja dan Seminar\n\nTotal JP (Jam Pelajaran) = 250 JP',
      syaratAdministrasi:
          '1. KTP .pdf\n2. Ijazah .pdf\n3. Curriculum Vitae .pdf\n4. Pasfoto Latar Merah .jpg\n5. Surat Keterangan Sehat .pdf\n6. Surat Keterangan Bekerja .pdf\n7. Pakta Intergritas .pdf\n8. -',
      fasilitas:
          '• Sertifikat dari Kemnaker RI\n• SKP dan Lisensi dari Kemnaker RI\n• E-Certificate dan SK Lulus dari PJK3\n• E-Learning (Modul dan Video)\n• Kemeja Safety\n• Training Kit',
      metode: 'OFFLINE TRAINING',
      detailMetode:
          'Full Offline Training, Teori dan Praktik dilaksanakan secara Tatap Muka',
      syaratKetentuan:
          '• Harga tidak termasuk pajak\n• Pembayaran dilakukan selambat-lambatnya H-5 pelatihan\n• Perusahaan perlu menyediakan fasilitas pelatihan untuk metode Blended/Offline training',
      instruktur:
          'Instruktur Training merupakan Tenaga Ahli PJK3, Praktisi, Akademisi dan Pejabat Kemnaker/Disnaker.',
      keterangan: 'Pendidikan min. D3, harga tidak termasuk pajak',
      gambarPelatihan: 'assets/images/flayer_pelatihan/flayer_ahli_k3_pubt.png',
    ),
    // Juru Las (Welder) SMAW Kelas 1
    Training(
      idPelatihan: '14',
      kodeBidang: '113',
      bidang: 'Pengelasan',
      namaPelatihan: 'Juru Las (Welder) SMAW Kelas 1',
      namaPelatihanKapital: 'JURU LAS (WELDER) SMAW KELAS 1',
      kodePelatihan: 'JLWSM1',
      durasi: 'Sesuai Jadwal',
      hargaPromo: 15500000,
      hargaNormal: 16750000,
      sertifikasi: 'Kemnaker RI',
      status: 'Running',
      deskripsi:
          'Pengelasan adalah suatu proses penyambungan dua material / lebih, biasanya berupa logam, dengan menggunakan energi panas sampai material yang akan disambung tersebut meleleh (melted) kemudian menyatu / berpadu (fused), dengan memberikan tekanan atau dengan memberikan bahan tambahan (consumable).\n\nPengelasan merupakan pekerjaan yang memiliki risiko tinggi seperti menghasilkan suara yang keras, dehidrasi karena lingkungan yang panas, sengatan listrik, cedera pada mata, posisi kerja yang tidak nyaman, kebakaran, dan ledakan. Pengelasan menghasilkan efek yang dapat mencemari lingkungan seperti debu, asap, dan polutan gas.\n\nDalam hal ini Juru Las (Welder) memegang peranan penting dalam menggunakan las untuk mencegah terjadinya kecelakaan dan peledakan. Berdasarkan Permenaker No. 2 Tahun 1982 tentang kwalifikasi juru las di tempat kerja. Kwalifikasi juru las terdiri dari 3 kelas :\n• Juru Las (Welder) Kelas 1, mampu melakukan percobaan pengelasan 1G, 2G, 3G, 4G, 5G dan 6G\n• Juru Las (Welder) Kelas 2, mampu melakukan percobaan pengelasan 1G, 2G, 3G dan 4G\n• Juru Las (Welder) Kelas 3, mampu melakukan percobaan pengelasan 1G dan 2G\nUntuk memenuhi peraturan tersebut, perusahaan dapat memberikan pembinaan dan sertifikasi kepada operatornya melalui PJK3 bekerja sama dengan Kemnaker RI',
      dasarHukum:
          '• UU No. 1 Tahun 1970\n• Permenaker No. 37 Tahun 2016\n• Permenaker No. 2 Tahun 1982',
      tujuan:
          '• Mendapatkan tenaga teknis berkeahlian khusus di bidang K3 yang dapat membantu pelaksanaan pembinaan dan pengawasan di tempat kerja\n• Meningkatkan pengetahuan dan pemahaman tentang peraturan perundang-undangan K3\n• Meningkatkan kemampuan dalam menerapkan K3 sesuai peraturan perundang-undangan di tempat kerja',
      materi:
          'KELOMPOK DASAR\n• Kebijakan K3 dan Dasar-dasar K3\n• Peraturan Perundangan-undangan K3 dibidang K3\n\nKELOMPOK INTI\n• Pengetahuan Bahan\n• pengetahuan tentang Teknik Pengelasan Busur (SMAW/GMAW/GTAW/FCAW)\n• Teknik Pengelasan\n• Cacat-cacat Las, Pencegahan dan Perbaikan\n• Sebab-sebab Kecelakaan dan Pencegahannya\n\nEVALUASI\n• Teori\n• Praktik\n\nTotal JP (Jam Pelajaran) = 60 JP',
      syaratAdministrasi:
          '1. KTP .pdf\n2. Ijazah .pdf\n3. Curriculum Vitae .pdf\n4. Pasfoto Latar Merah .jpg\n5. Surat Keterangan Sehat .pdf\n6. Surat Keterangan Bekerja .pdf\n7. Pakta Intergritas .pdf\n8. -',
      fasilitas:
          '• Sertifikat dari Kemnaker RI\n• Lisensi dari Kemnaker RI\n• E-Certificate dan SK Lulus dari PJK3\n• E-Learning (Modul dan Video)\n• Kemeja Safety\n• Training Kit',
      metode: 'OFFLINE TRAINING',
      detailMetode:
          'Full Offline Training, Teori dan Praktik dilaksanakan secara Tatap Muka',
      syaratKetentuan:
          '• Harga tidak termasuk pajak\n• Pembayaran dilakukan selambat-lambatnya H-5 pelatihan\n• Perusahaan perlu menyediakan fasilitas pelatihan untuk metode Blended/Offline training',
      instruktur:
          'Instruktur Training merupakan Tenaga Ahli PJK3, Praktisi, Akademisi dan Pejabat Kemnaker/Disnaker.',
      keterangan: 'Pendidikan min. SMA, harga tidak termasuk pajak',
      gambarPelatihan:
          'assets/images/flayer_pelatihan/flayer_juru_las_kelas_1.png',
    ),
  ];
}
