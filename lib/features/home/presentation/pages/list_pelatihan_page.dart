import 'package:flutter/material.dart';

// ==========================================
// 5. PLACEHOLDERS (Untuk kelengkapan Bottom Nav)
// ==========================================
class PelatihanK3ListPage extends StatelessWidget {
  const PelatihanK3ListPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Semua Pelatihan K3')),
      body: const Center(
        child: Text('Gunakan halaman Pelatihan sebelumnya di sini'),
      ),
    );
  }
}

class DummyAkunPage extends StatelessWidget {
  const DummyAkunPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Akun Saya')),
      body: const Center(
        child: Text('Gunakan halaman Akun sebelumnya di sini'),
      ),
    );
  }
}
