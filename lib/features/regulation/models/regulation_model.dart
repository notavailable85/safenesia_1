class RegulationModel {
  final String id;
  final String category;
  final String title;
  final String nomor;
  final String tahun;
  final String deskripsi;
  final String fileUrl;
  final int isSaved;

  RegulationModel({
    required this.id,
    required this.category,
    required this.title,
    this.nomor = '',
    this.tahun = '',
    this.deskripsi = '',
    this.fileUrl = '',
    this.isSaved = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'title': title,
      'nomor': nomor,
      'tahun': tahun,
      'deskripsi': deskripsi,
      'fileUrl': fileUrl,
      'isSaved': isSaved,
    };
  }

  factory RegulationModel.fromMap(Map<String, dynamic> map) {
    return RegulationModel(
      id: map['id'] as String,
      category: map['category'] as String,
      title: map['title'] as String,
      nomor: map['nomor'] as String? ?? '',
      tahun: map['tahun'] as String? ?? '',
      deskripsi: map['deskripsi'] as String? ?? '',
      fileUrl: map['fileUrl'] as String? ?? '',
      isSaved: map['isSaved'] as int? ?? 0,
    );
  }
}

final List<RegulationModel> dummyRegulations = [
  RegulationModel(
    id: 'reg-1',
    category: 'Undang-Undang',
    title: 'Keselamatan Kerja',
    nomor: 'UU No. 1',
    tahun: '1970',
    deskripsi:
        'Undang-undang yang mengatur tentang prinsip dasar keselamatan kerja bagi tenaga kerja di segala tempat kerja.',
    fileUrl: 'https://example.com/pdf/uu-1-1970.pdf',
    isSaved: 1,
  ),
  RegulationModel(
    id: 'reg-2',
    category: 'Undang-Undang',
    title: 'Ketenagakerjaan',
    nomor: 'UU No. 13',
    tahun: '2003',
    deskripsi:
        'Undang-undang komprehensif tentang hak, kewajiban, dan perlindungan tenaga kerja di Indonesia.',
    fileUrl: 'https://example.com/pdf/uu-13-2003.pdf',
    isSaved: 0,
  ),
  RegulationModel(
    id: 'reg-3',
    category: 'Peraturan Pemerintah',
    title: 'Penerapan Sistem Manajemen Keselamatan dan Kesehatan Kerja',
    nomor: 'PP No. 50',
    tahun: '2012',
    deskripsi:
        'Aturan turunan mengenai penerapan SMK3 bagi perusahaan dengan jumlah pekerja tertentu.',
    fileUrl: 'https://example.com/pdf/pp-50-2012.pdf',
    isSaved: 0,
  ),
  RegulationModel(
    id: 'reg-4',
    category: 'Peraturan Menteri',
    title: 'Keselamatan dan Kesehatan Kerja Lingkungan Kerja',
    nomor: 'Permenaker No. 5',
    tahun: '2018',
    deskripsi:
        'Mengatur standar NAB (Nilai Ambang Batas) faktor fisika dan kimia di lingkungan kerja.',
    fileUrl: 'https://example.com/pdf/permen-5-2018.pdf',
    isSaved: 0,
  ),
  RegulationModel(
    id: 'reg-5',
    category: 'Peraturan Menteri',
    title: 'Panitia Pembina Keselamatan dan Kesehatan Kerja (P2K3)',
    nomor: 'Permenaker No. 4',
    tahun: '1987',
    deskripsi:
        'Peraturan tentang tata cara pembentukan P2K3 serta pengangkatan Ahli K3.',
    fileUrl: 'https://example.com/pdf/permen-4-1987.pdf',
    isSaved: 1,
  ),
];
