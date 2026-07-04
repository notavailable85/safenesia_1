import 'package:flutter/material.dart';
import 'package:safenesia_1/core/database/database_helper.dart';
import 'package:safenesia_1/features/auth/models/user_model.dart';

class AdminUserFormPage extends StatefulWidget {
  final UserModel? user;

  const AdminUserFormPage({super.key, this.user});

  @override
  State<AdminUserFormPage> createState() => _AdminUserFormPageState();
}

class _AdminUserFormPageState extends State<AdminUserFormPage> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String email;
  late String password;
  late String phoneNumber;
  String role = 'user';

  final List<String> roles = ['user', 'admin'];

  @override
  void initState() {
    super.initState();
    name = widget.user?.name ?? '';
    email = widget.user?.email ?? '';
    password = widget.user?.password ?? '';
    phoneNumber = widget.user?.phoneNumber ?? '';
    role = widget.user?.role ?? 'user';
  }

  void saveUser() async {
    if (_formKey.currentState!.validate()) {
      final user = UserModel(
        id: widget.user?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
        role: role,
      );

      if (widget.user != null) {
        await DatabaseHelper.instance.updateUser(user);
      } else {
        await DatabaseHelper.instance.createUser(user);
      }

      if (mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user == null ? 'Add User' : 'Edit User'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              initialValue: name,
              decoration: const InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
              validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              onChanged: (value) => name = value,
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: email,
              decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
              keyboardType: TextInputType.emailAddress,
              validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              onChanged: (value) => email = value,
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: password,
              decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
              obscureText: true,
              validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              onChanged: (value) => password = value,
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: phoneNumber,
              decoration: const InputDecoration(labelText: 'Phone Number', border: OutlineInputBorder()),
              keyboardType: TextInputType.phone,
              validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              onChanged: (value) => phoneNumber = value,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: role,
              decoration: const InputDecoration(labelText: 'Role', border: OutlineInputBorder()),
              items: roles.map((r) {
                return DropdownMenuItem(value: r, child: Text(r));
              }).toList(),
              onChanged: (val) {
                if (val != null) setState(() => role = val);
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                padding: const EdgeInsets.all(16),
              ),
              onPressed: saveUser,
              child: const Text('Save', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
