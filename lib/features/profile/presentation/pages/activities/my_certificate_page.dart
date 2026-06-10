import 'package:flutter/material.dart';

// ==========================================
// SUB-HALAMAN KONTAINER 1
// ==========================================

// 1.D. E-CERTIFICATE
class ECertificatePage extends StatelessWidget {
  const ECertificatePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('E-Certificate Saya')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 2,
        itemBuilder: (context, i) => Card(
          child: ListTile(
            leading: const Icon(
              Icons.workspace_premium,
              color: Colors.orange,
              size: 40,
            ),
            title: Text('Sertifikat Ahli K3 ${i + 1}'),
            subtitle: const Text('Diterbitkan: 12 Jan 2026'),
            trailing: IconButton(
              icon: const Icon(Icons.download),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }
}
