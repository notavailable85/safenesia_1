class RegulationModel {
  final String id;
  final String title;
  final String category;
  final String pdfUrl;

  RegulationModel({
    required this.id,
    required this.title,
    required this.category,
    required this.pdfUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'pdfUrl': pdfUrl,
    };
  }

  factory RegulationModel.fromMap(Map<String, dynamic> map) {
    return RegulationModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      category: map['category'] ?? '',
      pdfUrl: map['pdfUrl'] ?? '',
    );
  }
}
