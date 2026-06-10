import 'package:flutter/material.dart';

// ==========================================
// SUB-HALAMAN KONTAINER 2
// ==========================================

// 2.B. EDIT PROFIL
class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profil')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Stack(
              children: [
                const CircleAvatar(
                  radius: 50,
                  child: Icon(Icons.person, size: 50),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 18,
                    child: IconButton(
                      icon: const Icon(
                        Icons.camera_alt,
                        size: 16,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          TextField(
            // Hapus kata 'const' di sini
            decoration: const InputDecoration(
              labelText: 'Nama Lengkap',
            ), // 'const' dipindah ke sini
            controller: TextEditingController(text: 'Budi Santoso'),
          ),
          const SizedBox(height: 16),
          TextField(
            // Hapus kata 'const' di sini
            decoration: const InputDecoration(labelText: 'Email'),
            controller: TextEditingController(text: 'budi.santoso@email.com'),
          ),
          const SizedBox(height: 16),
          TextField(
            // Hapus kata 'const' di sini
            decoration: const InputDecoration(labelText: 'Nomor HP'),
            controller: TextEditingController(text: '081234567890'),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Simpan Perubahan'),
          ),
        ],
      ),
    );
  }
}
