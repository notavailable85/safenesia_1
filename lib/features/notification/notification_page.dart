import 'package:flutter/material.dart';
import 'package:safenesia_1/features/notification/models/notification_model.dart';
import 'package:safenesia_1/core/database/database_helper.dart';

// ==========================================
// 2. SEARCH & NOTIFICATION PAGE
// ==========================================
class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late Future<List<NotificationModel>> _notificationsFuture;

  @override
  void initState() {
    super.initState();
    _notificationsFuture = DatabaseHelper.instance.readAllNotifications();
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case 'warning':
        return Icons.warning;
      case 'payment':
        return Icons.payment;
      case 'info':
      default:
        return Icons.info;
    }
  }

  Color _getColorForType(String type) {
    switch (type) {
      case 'warning':
        return Colors.red;
      case 'payment':
        return Colors.green;
      case 'info':
      default:
        return Colors.blue;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifikasi')),
      body: FutureBuilder<List<NotificationModel>>(
        future: _notificationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada notifikasi.'));
          }

          final notifications = snapshot.data!;
          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, i) {
              final notif = notifications[i];
              return ListTile(
                leading: Icon(
                  _getIconForType(notif.type),
                  color: _getColorForType(notif.type),
                ),
                title: Text(notif.title),
                subtitle: Text(notif.subtitle),
              );
            },
          );
        },
      ),
    );
  }
}
