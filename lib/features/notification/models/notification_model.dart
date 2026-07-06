class NotificationModel {
  final String id;
  final String title;
  final String subtitle;
  final String type; // 'warning', 'payment', 'info'

  NotificationModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'type': type,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] as String,
      title: map['title'] as String,
      subtitle: map['subtitle'] as String,
      type: map['type'] as String,
    );
  }
}

final List<NotificationModel> dummyNotifications = [
  NotificationModel(
    id: '1',
    title: 'Sertifikat Berakhir',
    subtitle: 'Sertifikat Ahli K3 Umum Anda akan kadaluarsa dalam 30 hari.',
    type: 'warning',
  ),
  NotificationModel(
    id: '2',
    title: 'Transaksi Berhasil',
    subtitle: 'Pembayaran Riksa Uji Crane telah diverifikasi.',
    type: 'payment',
  ),
  NotificationModel(
    id: '3',
    title: 'Update Aplikasi',
    subtitle: 'Versi terbaru Safenesia kini tersedia dengan fitur baru!',
    type: 'info',
  ),
];
