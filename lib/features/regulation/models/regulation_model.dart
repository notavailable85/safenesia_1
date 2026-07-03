class RegulationModel {
  final String id;
  final String category;
  final String title;

  RegulationModel({
    required this.id,
    required this.category,
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'title': title,
    };
  }

  factory RegulationModel.fromMap(Map<String, dynamic> map) {
    return RegulationModel(
      id: map['id'] as String,
      category: map['category'] as String,
      title: map['title'] as String,
    );
  }
}

final List<RegulationModel> dummyRegulations = [
  RegulationModel(id: '1', category: 'Undang-undang', title: 'File PDF Undang-undang No.1'),
  RegulationModel(id: '2', category: 'Peraturan Presiden', title: 'File PDF Peraturan Presiden No.1'),
  RegulationModel(id: '3', category: 'Peraturan Pemerintah', title: 'File PDF Peraturan Pemerintah No.1'),
  RegulationModel(id: '4', category: 'Peraturan Menteri', title: 'File PDF Peraturan Menteri No.1'),
  RegulationModel(id: '5', category: 'Keputusan Menteri', title: 'File PDF Keputusan Menteri No.1'),
  RegulationModel(id: '6', category: 'Instruksi Menteri', title: 'File PDF Instruksi Menteri No.1'),
  RegulationModel(id: '7', category: 'Keputusan Dirjen', title: 'File PDF Keputusan Dirjen No.1'),
  RegulationModel(id: '8', category: 'Surat Edaran Menteri', title: 'File PDF Surat Edaran Menteri No.1'),
  RegulationModel(id: '9', category: 'Keputusan Bersama Menteri', title: 'File PDF Keputusan Bersama Menteri No.1'),
];
