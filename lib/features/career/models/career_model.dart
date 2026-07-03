class CareerModel {
  final String id;
  final String title;
  final String company;
  final String field;
  final String location;
  final int salaryMin;
  final int salaryMax;
  final int isSaved; // 0 for false, 1 for true

  CareerModel({
    required this.id,
    required this.title,
    required this.company,
    required this.field,
    required this.location,
    required this.salaryMin,
    required this.salaryMax,
    this.isSaved = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'company': company,
      'field': field,
      'location': location,
      'salaryMin': salaryMin,
      'salaryMax': salaryMax,
      'isSaved': isSaved,
    };
  }

  factory CareerModel.fromMap(Map<String, dynamic> map) {
    return CareerModel(
      id: map['id'] as String,
      title: map['title'] as String,
      company: map['company'] as String,
      field: map['field'] as String,
      location: map['location'] as String,
      salaryMin: map['salaryMin'] as int,
      salaryMax: map['salaryMax'] as int,
      isSaved: map['isSaved'] as int,
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
    salaryMin: 8000000,
    salaryMax: 12000000,
    isSaved: 0,
  ),
  CareerModel(
    id: '2',
    title: 'Safety Inspector',
    company: 'PT Konstruksi Hebat',
    field: 'Konstruksi',
    location: 'Surabaya',
    salaryMin: 6000000,
    salaryMax: 9000000,
    isSaved: 1,
  ),
  CareerModel(
    id: '3',
    title: 'Ahli K3 Umum',
    company: 'PT Tambang Emas',
    field: 'Tambang',
    location: 'Papua',
    salaryMin: 15000000,
    salaryMax: 25000000,
    isSaved: 0,
  ),
  CareerModel(
    id: '4',
    title: 'HSE Manager',
    company: 'PT Oil & Gas Nusantara',
    field: 'Oil & Gas',
    location: 'Balikpapan',
    salaryMin: 20000000,
    salaryMax: 35000000,
    isSaved: 1,
  ),
];
