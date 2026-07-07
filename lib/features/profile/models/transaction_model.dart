class TransactionModel {
  final String id;
  final String layanan;
  final String judul;
  final String status;
  final String tanggal;
  final int? totalBayar;

  TransactionModel({
    required this.id,
    required this.layanan,
    required this.judul,
    required this.status,
    required this.tanggal,
    this.totalBayar,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'layanan': layanan,
      'judul': judul,
      'status': status,
      'tanggal': tanggal,
      'totalBayar': totalBayar,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] ?? '',
      layanan: map['layanan'] ?? '',
      judul: map['judul'] ?? '',
      status: map['status'] ?? '',
      tanggal: map['tanggal'] ?? '',
      totalBayar: map['totalBayar'],
    );
  }
}
