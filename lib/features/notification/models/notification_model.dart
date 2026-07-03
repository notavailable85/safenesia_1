class NotificationModel {
  final String id;
  final String type; // e.g., 'warning', 'payment', 'info'
  final String title;
  final String message;
  final DateTime date;
  final bool isRead;

  NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.date,
    this.isRead = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'message': message,
      'date': date.toIso8601String(),
      'isRead': isRead,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] ?? '',
      type: map['type'] ?? 'info',
      title: map['title'] ?? '',
      message: map['message'] ?? '',
      date: map['date'] != null ? DateTime.parse(map['date']) : DateTime.now(),
      isRead: map['isRead'] ?? false,
    );
  }
}
