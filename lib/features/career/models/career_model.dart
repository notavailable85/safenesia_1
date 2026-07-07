import 'dart:convert';

class CareerModel {
  final String id;

  // Basic Information
  final String title;
  final String slug;
  final String description;
  final String requirements;
  final String responsibilities;
  final String benefits;

  // Company
  final String companyId;
  final String companyName;
  final String companyLogo;

  // Job Information
  final String employmentType;
  final String workplaceType;
  final String level;

  // Location
  final String province;
  final String city;
  final String address;

  // Salary
  final bool salaryVisible;
  final double? salaryMin;
  final double? salaryMax;
  final String salaryPeriod;

  // Qualification
  final String education;
  final int minimumExperience;

  // Skills
  final List<String> skills;

  // Certificate
  final List<String> certificates;

  // Contact
  final String applyUrl;
  final String email;
  final String phone;

  // Statistics
  final int applicants;
  final int bookmarks;
  final int shares;

  // Status
  final bool isFeatured;
  final bool isUrgent;
  final bool isActive;

  // Dates
  final DateTime postedAt;
  final DateTime expiredAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CareerModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.requirements,
    required this.responsibilities,
    required this.benefits,
    required this.companyId,
    required this.companyName,
    required this.companyLogo,
    required this.employmentType,
    required this.workplaceType,
    required this.level,
    required this.province,
    required this.city,
    required this.address,
    required this.salaryVisible,
    this.salaryMin,
    this.salaryMax,
    required this.salaryPeriod,
    required this.education,
    required this.minimumExperience,
    required this.skills,
    required this.certificates,
    required this.applyUrl,
    required this.email,
    required this.phone,
    required this.applicants,
    required this.bookmarks,
    required this.shares,
    required this.isFeatured,
    required this.isUrgent,
    required this.isActive,
    required this.postedAt,
    required this.expiredAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CareerModel.fromMap(Map<String, dynamic> map) {
    return CareerModel(
      id: map['id'],
      title: map['title'],
      slug: map['slug'],
      description: map['description'],
      requirements: map['requirements'],
      responsibilities: map['responsibilities'],
      benefits: map['benefits'],
      companyId: map['company_id'],
      companyName: map['company_name'],
      companyLogo: map['company_logo'],
      employmentType: map['employment_type'],
      workplaceType: map['workplace_type'],
      level: map['level'],
      province: map['province'],
      city: map['city'],
      address: map['address'],
      salaryVisible: map['salary_visible'] == 1 || map['salary_visible'] == true,
      salaryMin: map['salary_min']?.toDouble(),
      salaryMax: map['salary_max']?.toDouble(),
      salaryPeriod: map['salary_period'],
      education: map['education'],
      minimumExperience: map['minimum_experience'],
      skills: List<String>.from(
          map['skills'] is String ? jsonDecode(map['skills']) : (map['skills'] ?? [])),
      certificates: List<String>.from(
          map['certificates'] is String ? jsonDecode(map['certificates']) : (map['certificates'] ?? [])),
      applyUrl: map['apply_url'],
      email: map['email'],
      phone: map['phone'],
      applicants: map['applicants'],
      bookmarks: map['bookmarks'],
      shares: map['shares'],
      isFeatured: map['is_featured'] == 1 || map['is_featured'] == true,
      isUrgent: map['is_urgent'] == 1 || map['is_urgent'] == true,
      isActive: map['is_active'] == 1 || map['is_active'] == true,
      postedAt: DateTime.parse(map['posted_at']),
      expiredAt: DateTime.parse(map['expired_at']),
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'description': description,
      'requirements': requirements,
      'responsibilities': responsibilities,
      'benefits': benefits,
      'company_id': companyId,
      'company_name': companyName,
      'company_logo': companyLogo,
      'employment_type': employmentType,
      'workplace_type': workplaceType,
      'level': level,
      'province': province,
      'city': city,
      'address': address,
      'salary_visible': salaryVisible ? 1 : 0,
      'salary_min': salaryMin,
      'salary_max': salaryMax,
      'salary_period': salaryPeriod,
      'education': education,
      'minimum_experience': minimumExperience,
      'skills': jsonEncode(skills),
      'certificates': jsonEncode(certificates),
      'apply_url': applyUrl,
      'email': email,
      'phone': phone,
      'applicants': applicants,
      'bookmarks': bookmarks,
      'shares': shares,
      'is_featured': isFeatured ? 1 : 0,
      'is_urgent': isUrgent ? 1 : 0,
      'is_active': isActive ? 1 : 0,
      'posted_at': postedAt.toIso8601String(),
      'expired_at': expiredAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory CareerModel.fromJson(Map<String, dynamic> json) =>
      CareerModel.fromMap(json);

  Map<String, dynamic> toJson() => toMap();

  CareerModel copyWith({
    String? id,
    String? title,
    String? slug,
    String? description,
    String? requirements,
    String? responsibilities,
    String? benefits,
    String? companyId,
    String? companyName,
    String? companyLogo,
    String? employmentType,
    String? workplaceType,
    String? level,
    String? province,
    String? city,
    String? address,
    bool? salaryVisible,
    double? salaryMin,
    double? salaryMax,
    String? salaryPeriod,
    String? education,
    int? minimumExperience,
    List<String>? skills,
    List<String>? certificates,
    String? applyUrl,
    String? email,
    String? phone,
    int? applicants,
    int? bookmarks,
    int? shares,
    bool? isFeatured,
    bool? isUrgent,
    bool? isActive,
    DateTime? postedAt,
    DateTime? expiredAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CareerModel(
      id: id ?? this.id,
      title: title ?? this.title,
      slug: slug ?? this.slug,
      description: description ?? this.description,
      requirements: requirements ?? this.requirements,
      responsibilities: responsibilities ?? this.responsibilities,
      benefits: benefits ?? this.benefits,
      companyId: companyId ?? this.companyId,
      companyName: companyName ?? this.companyName,
      companyLogo: companyLogo ?? this.companyLogo,
      employmentType: employmentType ?? this.employmentType,
      workplaceType: workplaceType ?? this.workplaceType,
      level: level ?? this.level,
      province: province ?? this.province,
      city: city ?? this.city,
      address: address ?? this.address,
      salaryVisible: salaryVisible ?? this.salaryVisible,
      salaryMin: salaryMin ?? this.salaryMin,
      salaryMax: salaryMax ?? this.salaryMax,
      salaryPeriod: salaryPeriod ?? this.salaryPeriod,
      education: education ?? this.education,
      minimumExperience: minimumExperience ?? this.minimumExperience,
      skills: skills ?? this.skills,
      certificates: certificates ?? this.certificates,
      applyUrl: applyUrl ?? this.applyUrl,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      applicants: applicants ?? this.applicants,
      bookmarks: bookmarks ?? this.bookmarks,
      shares: shares ?? this.shares,
      isFeatured: isFeatured ?? this.isFeatured,
      isUrgent: isUrgent ?? this.isUrgent,
      isActive: isActive ?? this.isActive,
      postedAt: postedAt ?? this.postedAt,
      expiredAt: expiredAt ?? this.expiredAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

// Dummy Data
final List<CareerModel> dummyCareers = [
  CareerModel(
    id: 'c1',
    title: 'HSE Officer',
    slug: 'hse-officer',
    description: 'Kami mencari HSE Officer yang berpengalaman untuk mengawasi implementasi K3 di proyek konstruksi.',
    requirements: '- Minimal lulusan S1 Teknik K3 atau terkait\n- Memiliki sertifikat AK3U dari Kemnaker\n- Pengalaman minimal 2 tahun',
    responsibilities: '- Melakukan inspeksi harian\n- Membuat laporan K3\n- Memberikan toolbox meeting',
    benefits: '- BPJS Kesehatan & Tenaga Kerja\n- Tunjangan Transportasi\n- Bonus Tahunan',
    companyId: 'comp1',
    companyName: 'PT Waskita Karya',
    companyLogo: 'https://picsum.photos/seed/c1/100/100',
    employmentType: 'Full-time',
    workplaceType: 'On-site',
    level: 'Middle',
    province: 'DKI Jakarta',
    city: 'Jakarta Selatan',
    address: 'Jl. MT Haryono No. 10',
    salaryVisible: true,
    salaryMin: 6000000,
    salaryMax: 9000000,
    salaryPeriod: 'Bulan',
    education: 'S1',
    minimumExperience: 2,
    skills: ['Hazard Identification', 'Risk Assessment', 'ISO 45001'],
    certificates: ['Ahli K3 Umum'],
    applyUrl: 'https://example.com/apply/c1',
    email: 'hr@example.com',
    phone: '08123456789',
    applicants: 45,
    bookmarks: 12,
    shares: 5,
    isFeatured: true,
    isUrgent: false,
    isActive: true,
    postedAt: DateTime.now().subtract(const Duration(days: 2)),
    expiredAt: DateTime.now().add(const Duration(days: 30)),
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    updatedAt: DateTime.now().subtract(const Duration(days: 2)),
  ),
  CareerModel(
    id: 'c2',
    title: 'Safety Inspector',
    slug: 'safety-inspector',
    description: 'Dicari Safety Inspector untuk area pertambangan.',
    requirements: '- Pendidikan minimal D3\n- Memahami standar K3 Pertambangan',
    responsibilities: '- Inspeksi alat berat\n- Investigasi kecelakaan',
    benefits: '- Mess karyawan\n- Uang makan',
    companyId: 'comp2',
    companyName: 'PT Freeport Indonesia',
    companyLogo: 'https://picsum.photos/seed/c2/100/100',
    employmentType: 'Contract',
    workplaceType: 'On-site',
    level: 'Entry Level',
    province: 'Papua',
    city: 'Mimika',
    address: 'Tembagapura',
    salaryVisible: false,
    salaryMin: 8000000,
    salaryMax: 12000000,
    salaryPeriod: 'Bulan',
    education: 'D3',
    minimumExperience: 1,
    skills: ['Mining Safety', 'First Aid'],
    certificates: ['POP'],
    applyUrl: 'https://example.com/apply/c2',
    email: 'hr.papua@example.com',
    phone: '08987654321',
    applicants: 120,
    bookmarks: 34,
    shares: 10,
    isFeatured: false,
    isUrgent: true,
    isActive: true,
    postedAt: DateTime.now().subtract(const Duration(days: 1)),
    expiredAt: DateTime.now().add(const Duration(days: 14)),
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
    updatedAt: DateTime.now().subtract(const Duration(days: 1)),
  ),
];
