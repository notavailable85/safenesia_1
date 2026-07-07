class CertModel {
  final String id;
  final String title;
  final String category; // 'SMK3' atau 'ISO'
  final String level; // Awal/Transisi/Lanjutan atau KAN/UKAS/EGAC
  final int basePrice;
  final String? bannerUrl;

  CertModel({
    required this.id,
    required this.title,
    required this.category,
    required this.level,
    required this.basePrice,
    this.bannerUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'level': level,
      'basePrice': basePrice,
      'bannerUrl': bannerUrl,
    };
  }

  factory CertModel.fromMap(Map<String, dynamic> map) {
    return CertModel(
      id: map['id'] as String,
      title: map['title'] as String,
      category: map['category'] as String,
      level: map['level'] as String,
      basePrice: map['basePrice'] as int,
      bannerUrl: map['bannerUrl'] as String?,
    );
  }
}

final List<CertModel> dummyCertifications = [
  CertModel(
    id: '1',
    title: 'Sertifikasi SMK3 PP 50/2012',
    category: 'SMK3',
    level: 'Kriteria: Awal (64 Kriteria)',
    basePrice: 15000000,
    bannerUrl:
        'https://dummyimage.com/600x400/0055ff/ffffff.png&text=Dummy+Sertifikasi+1',
  ),
  CertModel(
    id: '2',
    title: 'Sertifikasi SMK3 Konstruksi',
    category: 'SMK3',
    level: 'Kriteria: Lanjutan (166 Kriteria)',
    basePrice: 25000000,
    bannerUrl:
        'https://dummyimage.com/600x400/0055ff/ffffff.png&text=Dummy+Sertifikasi+2',
  ),
  CertModel(
    id: '3',
    title: 'Sertifikasi SMK3 Manufaktur',
    category: 'SMK3',
    level: 'Kriteria: Transisi (122 Kriteria)',
    basePrice: 20000000,
    bannerUrl:
        'https://dummyimage.com/600x400/0055ff/ffffff.png&text=Dummy+Sertifikasi+3',
  ),
  CertModel(
    id: '4',
    title: 'Sertifikasi ISO 9001:2015',
    category: 'ISO',
    level: 'Akreditasi: KAN',
    basePrice: 12000000,
    bannerUrl:
        'https://dummyimage.com/600x400/0055ff/ffffff.png&text=Dummy+Sertifikasi+4',
  ),
  CertModel(
    id: '5',
    title: 'Sertifikasi ISO 45001:2018',
    category: 'ISO',
    level: 'Akreditasi: UKAS',
    basePrice: 18000000,
    bannerUrl:
        'https://dummyimage.com/600x400/0055ff/ffffff.png&text=Dummy+Sertifikasi+5',
  ),
  CertModel(
    id: '6',
    title: 'Sertifikasi ISO 14001:2015',
    category: 'ISO',
    level: 'Akreditasi: EGAC',
    basePrice: 16000000,
    bannerUrl:
        'https://dummyimage.com/600x400/0055ff/ffffff.png&text=Dummy+Sertifikasi+6',
  ),
];
