import 'package:safenesia_1/features/training/models/training_model.dart';

class TrainingSchedule {
  final String idJadwal;
  final String idPelatihan; // FK to Training
  final String tanggalStart; // ISO8601
  final String tanggalEnd; // ISO8601
  final String gambar;
  final String? namaLokasi;
  final String? linkPetaLokasi;
  
  // Joined property
  final Training? trainingData;

  TrainingSchedule({
    required this.idJadwal,
    required this.idPelatihan,
    required this.tanggalStart,
    required this.tanggalEnd,
    required this.gambar,
    this.namaLokasi,
    this.linkPetaLokasi,
    this.trainingData,
  });

  Map<String, dynamic> toMap() {
    return {
      'idJadwal': idJadwal,
      'idPelatihan': idPelatihan,
      'tanggalStart': tanggalStart,
      'tanggalEnd': tanggalEnd,
      'gambar': gambar,
      'namaLokasi': namaLokasi,
      'linkPetaLokasi': linkPetaLokasi,
    };
  }

  factory TrainingSchedule.fromMap(Map<String, dynamic> map, {Training? trainingData}) {
    return TrainingSchedule(
      idJadwal: map['idJadwal'] as String,
      idPelatihan: map['idPelatihan'] as String,
      tanggalStart: map['tanggalStart'] as String,
      tanggalEnd: map['tanggalEnd'] as String,
      gambar: map['gambar'] as String,
      namaLokasi: map['namaLokasi'] as String?,
      linkPetaLokasi: map['linkPetaLokasi'] as String?,
      trainingData: trainingData,
    );
  }

  // Helper method to get formatted date string easily
  String get tanggalStr {
    if (tanggalStart.isEmpty || tanggalEnd.isEmpty) return '';
    try {
      final start = DateTime.parse(tanggalStart);
      final end = DateTime.parse(tanggalEnd);
      
      String getShortMonthName(int month) {
        const months = ['', 'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Ags', 'Sep', 'Okt', 'Nov', 'Des'];
        return months[month];
      }

      return '${start.day} ${getShortMonthName(start.month)} - ${end.day} ${getShortMonthName(end.month)} ${end.year}';
    } catch (e) {
      return '';
    }
  }
}
