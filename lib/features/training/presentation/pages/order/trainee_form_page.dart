import 'package:flutter/material.dart';

// HALAMAN SUB-FORM INPUT PESERTA (HALAMAN BARU)
class DetailPesertaInputPage extends StatefulWidget {
  final int index;
  final Map<String, String> initialData;
  const DetailPesertaInputPage({
    super.key,
    required this.index,
    required this.initialData,
  });

  @override
  State<DetailPesertaInputPage> createState() => _DetailPesertaInputPageState();
}

class _DetailPesertaInputPageState extends State<DetailPesertaInputPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _namaCtrl;
  late TextEditingController _ktpCtrl;
  late TextEditingController _waCtrl;
  late TextEditingController _emailCtrl;

  @override
  void initState() {
    super.initState();
    _namaCtrl = TextEditingController(text: widget.initialData['nama']);
    _ktpCtrl = TextEditingController(text: widget.initialData['ktp']);
    _waCtrl = TextEditingController(text: widget.initialData['wa']);
    _emailCtrl = TextEditingController(text: widget.initialData['email']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Data Lengkap Peserta ${widget.index + 1}')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _namaCtrl,
              decoration: const InputDecoration(labelText: 'Nama Lengkap'),
              validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
            ),
            TextFormField(
              controller: _ktpCtrl,
              decoration: const InputDecoration(labelText: 'Nomor KTP'),
              keyboardType: TextInputType.number,
              validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
            ),
            TextFormField(
              controller: _waCtrl,
              decoration: const InputDecoration(labelText: 'No. WA'),
              keyboardType: TextInputType.phone,
              validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
            ),
            TextFormField(
              controller: _emailCtrl,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.pop(context, {
                    'nama': _namaCtrl.text,
                    'ktp': _ktpCtrl.text,
                    'wa': _waCtrl.text,
                    'email': _emailCtrl.text,
                  });
                }
              },
              child: const Text('Simpan Data Peserta'),
            ),
          ],
        ),
      ),
    );
  }
}
