class InspectionModel {
  final String id;
  final String companyName;
  final String equipmentType;
  final String location;
  final String scheduledDate;
  final String notes;
  final String status;

  InspectionModel({
    required this.id,
    required this.companyName,
    required this.equipmentType,
    required this.location,
    required this.scheduledDate,
    required this.notes,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'companyName': companyName,
      'equipmentType': equipmentType,
      'location': location,
      'scheduledDate': scheduledDate,
      'notes': notes,
      'status': status,
    };
  }

  factory InspectionModel.fromMap(Map<String, dynamic> map) {
    return InspectionModel(
      id: map['id'] as String,
      companyName: map['companyName'] as String,
      equipmentType: map['equipmentType'] as String,
      location: map['location'] as String,
      scheduledDate: map['scheduledDate'] as String,
      notes: map['notes'] as String,
      status: map['status'] as String,
    );
  }
}

final List<InspectionModel> dummyInspections = [
  InspectionModel(
    id: 'ins-1',
    companyName: 'PT. Maju Mundur',
    equipmentType: 'Pesawat Angkat Angkut (Crane)',
    location: 'Jl. Industri No. 45, Jakarta',
    scheduledDate: DateTime.now().add(const Duration(days: 3)).toIso8601String(),
    notes: 'Mohon hubungi Bapak Budi saat tiba di lokasi.',
    status: 'Pending',
  ),
  InspectionModel(
    id: 'ins-2',
    companyName: 'PT. Sejahtera Abadi',
    equipmentType: 'Bejana Tekan (Boiler)',
    location: 'Kawasan Industri MM2100, Bekasi',
    scheduledDate: DateTime.now().subtract(const Duration(days: 2)).toIso8601String(),
    notes: 'Perpanjangan suket disnaker.',
    status: 'Completed',
  ),
];
