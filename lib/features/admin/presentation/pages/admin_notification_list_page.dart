import 'package:flutter/material.dart';
import 'package:safenesia_1/core/database/database_helper.dart';
import 'package:safenesia_1/features/notification/models/notification_model.dart';
import 'package:safenesia_1/features/admin/presentation/pages/admin_notification_form_page.dart';

class AdminNotificationListPage extends StatefulWidget {
  const AdminNotificationListPage({super.key});

  @override
  State<AdminNotificationListPage> createState() =>
      _AdminNotificationListPageState();
}

class _AdminNotificationListPageState extends State<AdminNotificationListPage> {
  List<NotificationModel> notifications = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    refreshNotifications();
  }

  Future refreshNotifications() async {
    setState(() => isLoading = true);
    notifications = await DatabaseHelper.instance.readAllNotifications();
    setState(() => isLoading = false);
  }

  Future deleteNotification(String id) async {
    await DatabaseHelper.instance.deleteNotification(id);
    refreshNotifications();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: const Duration(milliseconds: 1500),
          content: Text('Notification deleted'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Notifications'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : notifications.isEmpty
          ? const Center(child: Text('No Notifications found'))
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notif = notifications[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.notifications, color: Colors.red),
                    title: Text(notif.title),
                    subtitle: Text(notif.subtitle),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.orange),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdminNotificationFormPage(
                                  notification: notif,
                                ),
                              ),
                            );
                            refreshNotifications();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Delete Notification'),
                                content: const Text(
                                  'Are you sure you want to delete this notification?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      deleteNotification(notif.id);
                                    },
                                    child: const Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AdminNotificationFormPage(),
            ),
          );
          refreshNotifications();
        },
      ),
    );
  }
}
