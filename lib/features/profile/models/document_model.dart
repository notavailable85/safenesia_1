class DocumentModel {
  final String id;
  final String jenis;
  final String namaFile;
  final String pathFile;
  final String tanggalUpload;

  DocumentModel({
    required this.id,
    required this.jenis,
    required this.namaFile,
    required this.pathFile,
    required this.tanggalUpload,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'jenis': jenis,
      'nama_file': namaFile,
      'path_file': pathFile,
      'tanggal_upload': tanggalUpload,
    };
  }

  factory DocumentModel.fromMap(Map<String, dynamic> map) {
    return DocumentModel(
      id: map['id'] ?? '',
      jenis: map['jenis'] ?? '',
      namaFile: map['nama_file'] ?? '',
      pathFile: map['path_file'] ?? '',
      tanggalUpload: map['tanggal_upload'] ?? '',
    );
  }
}
