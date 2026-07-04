class CareerModel {
  final String id;
  final String title;
  final String company;
  final String field;
  final String location;
  final String jobType;
  final String experienceLevel;
  final int salaryMin;
  final int salaryMax;
  final String description;
  final String requirements;
  final String benefits;
  final String postedDate;
  final String companyLogoUrl;
  final int isSaved; // 0 for false, 1 for true
  final int isApplied; // 0 for false, 1 for true

  CareerModel({
    required this.id,
    required this.title,
    required this.company,
    required this.field,
    required this.location,
    required this.jobType,
    required this.experienceLevel,
    required this.salaryMin,
    required this.salaryMax,
    required this.description,
    required this.requirements,
    required this.benefits,
    required this.postedDate,
    required this.companyLogoUrl,
    this.isSaved = 0,
    this.isApplied = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'company': company,
      'field': field,
      'location': location,
      'jobType': jobType,
      'experienceLevel': experienceLevel,
      'salaryMin': salaryMin,
      'salaryMax': salaryMax,
      'description': description,
      'requirements': requirements,
      'benefits': benefits,
      'postedDate': postedDate,
      'companyLogoUrl': companyLogoUrl,
      'isSaved': isSaved,
      'isApplied': isApplied,
    };
  }

  factory CareerModel.fromMap(Map<String, dynamic> map) {
    return CareerModel(
      id: map['id'] as String,
      title: map['title'] as String,
      company: map['company'] as String,
      field: map['field'] as String,
      location: map['location'] as String,
      jobType: map['jobType'] as String? ?? 'Full-time',
      experienceLevel: map['experienceLevel'] as String? ?? 'Entry Level',
      salaryMin: map['salaryMin'] as int,
      salaryMax: map['salaryMax'] as int,
      description: map['description'] as String? ?? 'Deskripsi tidak tersedia.',
      requirements: map['requirements'] as String? ?? '-',
      benefits: map['benefits'] as String? ?? '-',
      postedDate: map['postedDate'] as String? ?? DateTime.now().toIso8601String(),
      companyLogoUrl: map['companyLogoUrl'] as String? ?? '',
      isSaved: map['isSaved'] as int? ?? 0,
      isApplied: map['isApplied'] as int? ?? 0,
    );
  }
}

final List<CareerModel> dummyCareers = [
  CareerModel(
    id: '1',
    title: 'HSE Officer',
    company: 'PT Maju Jaya',
    field: 'Manufaktur',
    location: 'Jakarta',
    jobType: 'Full-time',
    experienceLevel: 'Entry Level',
    salaryMin: 8000000,
    salaryMax: 12000000,
    description: 'Kami mencari HSE Officer yang berdedikasi untuk bergabung dengan tim kami di Jakarta. Anda akan bertanggung jawab untuk memantau keselamatan di lingkungan kerja dan memastikan kepatuhan terhadap standar HSE nasional.',
    requirements: '• Minimal S1 Teknik Lingkungan / K3\n• Memiliki sertifikat AK3 Umum\n• Pengalaman minimal 1 tahun di bidang manufaktur\n• Mampu membuat laporan investigasi kecelakaan',
    benefits: '• Asuransi Kesehatan Pribadi & Keluarga\n• BPJS Ketenagakerjaan\n• Uang Makan & Transport\n• Bonus Tahunan',
    postedDate: DateTime.now().subtract(const Duration(days: 2)).toIso8601String(),
    companyLogoUrl: '',
    isSaved: 0,
    isApplied: 0,
  ),
  CareerModel(
    id: '2',
    title: 'Safety Inspector',
    company: 'PT Konstruksi Hebat',
    field: 'Konstruksi',
    location: 'Surabaya',
    jobType: 'Contract',
    experienceLevel: 'Mid Level',
    salaryMin: 6000000,
    salaryMax: 9000000,
    description: 'Dibutuhkan segera Safety Inspector untuk proyek konstruksi gedung bertingkat di Surabaya. Anda akan bekerja langsung di lapangan untuk memastikan prosedur kerja aman diterapkan oleh seluruh pekerja.',
    requirements: '• Minimal D3/S1 Teknik Sipil / K3\n• Pengalaman minimal 3 tahun di konstruksi\n• Memiliki sertifikat K3 Konstruksi\n• Bersedia bekerja shifting',
    benefits: '• Asuransi Kesehatan\n• Akomodasi/Mess disediakan\n• Uang Lembur',
    postedDate: DateTime.now().subtract(const Duration(days: 5)).toIso8601String(),
    companyLogoUrl: '',
    isSaved: 1,
    isApplied: 0,
  ),
  CareerModel(
    id: '3',
    title: 'Ahli K3 Umum',
    company: 'PT Tambang Emas',
    field: 'Tambang',
    location: 'Papua',
    jobType: 'Full-time',
    experienceLevel: 'Senior',
    salaryMin: 15000000,
    salaryMax: 25000000,
    description: 'Peluang emas bergabung dengan perusahaan pertambangan multinasional. Kandidat akan memimpin dan mengawasi implementasi Sistem Manajemen K3 di area tambang.',
    requirements: '• S1 semua jurusan (diutamakan Teknik)\n• Memiliki sertifikat AK3 Umum dari Kemnaker\n• Pengalaman di industri tambang minimal 5 tahun\n• Memiliki leadership yang kuat',
    benefits: '• Tiket pesawat cuti roster\n• Fasilitas mess lengkap\n• Asuransi Internasional\n• Jenjang karir yang jelas',
    postedDate: DateTime.now().subtract(const Duration(days: 10)).toIso8601String(),
    companyLogoUrl: '',
    isSaved: 0,
    isApplied: 1,
  ),
  CareerModel(
    id: '4',
    title: 'HSE Manager',
    company: 'PT Oil & Gas Nusantara',
    field: 'Oil & Gas',
    location: 'Balikpapan',
    jobType: 'Full-time',
    experienceLevel: 'Senior',
    salaryMin: 20000000,
    salaryMax: 35000000,
    description: 'Mencari HSE Manager yang berpengalaman untuk memimpin departemen HSE di sektor Oil & Gas. Anda akan bertanggung jawab untuk strategi HSE, audit, dan hubungan dengan regulator.',
    requirements: '• S1 Teknik/Kesehatan Masyarakat\n• Pengalaman HSE Manager >7 tahun\n• Menguasai ISO 45001 & ISO 14001\n• Kemampuan bahasa Inggris yang sangat baik',
    benefits: '• Mobil Dinas\n• Asuransi Premium\n• Saham Perusahaan\n• Dana Pensiun',
    postedDate: DateTime.now().subtract(const Duration(hours: 5)).toIso8601String(),
    companyLogoUrl: '',
    isSaved: 1,
    isApplied: 0,
  ),
];
