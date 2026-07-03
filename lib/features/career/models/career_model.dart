class CareerModel {
  final String id;
  final String positionTitle;
  final String category;
  final String companyName;
  final String location;
  final String salaryRange;
  final bool isSaved;

  CareerModel({
    required this.id,
    required this.positionTitle,
    required this.category,
    required this.companyName,
    required this.location,
    required this.salaryRange,
    this.isSaved = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'positionTitle': positionTitle,
      'category': category,
      'companyName': companyName,
      'location': location,
      'salaryRange': salaryRange,
      'isSaved': isSaved,
    };
  }

  factory CareerModel.fromMap(Map<String, dynamic> map) {
    return CareerModel(
      id: map['id'] ?? '',
      positionTitle: map['positionTitle'] ?? '',
      category: map['category'] ?? '',
      companyName: map['companyName'] ?? '',
      location: map['location'] ?? '',
      salaryRange: map['salaryRange'] ?? '',
      isSaved: map['isSaved'] ?? false,
    );
  }
}
