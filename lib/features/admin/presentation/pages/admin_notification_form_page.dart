import 'package:flutter/material.dart';
import 'package:safenesia_1/core/database/database_helper.dart';
import 'package:safenesia_1/features/notification/models/notification_model.dart';

class AdminNotificationFormPage extends StatefulWidget {
  final NotificationModel? notification;

  const AdminNotificationFormPage({super.key, this.notification});

  @override
  State<AdminNotificationFormPage> createState() =>
      _AdminNotificationFormPageState();
}

class _AdminNotificationFormPageState extends State<AdminNotificationFormPage> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String subtitle;
  String type = 'info';

  final List<String> notificationTypes = ['warning', 'payment', 'info'];

  @override
  void initState() {
    super.initState();
    title = widget.notification?.title ?? '';
    subtitle = widget.notification?.subtitle ?? '';
    type = widget.notification?.type ?? 'info';
  }

  void saveNotification() async {
    if (_formKey.currentState!.validate()) {
      final notif = NotificationModel(
        id:
            widget.notification?.id ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        subtitle: subtitle,
        type: type,
      );

      if (widget.notification != null) {
        await DatabaseHelper.instance.updateNotification(notif);
      } else {
        await DatabaseHelper.instance.createNotification(notif);
      }

      if (mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.notification == null
              ? 'Add Notification'
              : 'Edit Notification',
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              initialValue: title,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Required' : null,
              onChanged: (value) => title = value,
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: subtitle,
              decoration: const InputDecoration(
                labelText: 'Subtitle',
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Required' : null,
              onChanged: (value) => subtitle = value,
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: type,
              decoration: const InputDecoration(
                labelText: 'Type',
                border: OutlineInputBorder(),
              ),
              items: notificationTypes.map((t) {
                return DropdownMenuItem(value: t, child: Text(t));
              }).toList(),
              onChanged: (val) {
                if (val != null) setState(() => type = val);
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                padding: const EdgeInsets.all(16),
              ),
              onPressed: saveNotification,
              child: const Text(
                'Save',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
