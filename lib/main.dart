import 'package:flutter/material.dart';

void main() {
  runApp(const AkunApp());
}

class AkunApp extends StatelessWidget {
  const AkunApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Halaman Akun',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const AccountPage(),
    );
  }
}

// ==========================================
// 1. HALAMAN UTAMA AKUN
// ==========================================
class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool isBiometricEnabled = false;

  void _showBiometricDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text('Login Sidik Jari'),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Gunakan Sidik Jari'),
                  Switch(
                    value: isBiometricEnabled,
                    onChanged: (val) {
                      setStateDialog(() => isBiometricEnabled = val);
                      setState(
                        () => isBiometricEnabled = val,
                      ); // Update parent state
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Tutup'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.person, color: Colors.blue.shade700),
          ),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Budi Santoso',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'budi.santoso@email.com',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // KONTAINER 1
          const Text(
            'Aktivitas Saya',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          Card(
            margin: const EdgeInsets.only(top: 8, bottom: 24),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.history),
                  title: const Text('History Transaksi'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (c) => const HistoryTransactionPage(),
                    ),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.school),
                  title: const Text('Pelatihan yang Saya Ikuti'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) => const MyTrainingPage()),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.folder),
                  title: const Text('Dokumen Saya'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) => const MyDocumentsPage()),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.workspace_premium),
                  title: const Text('E-Certificate'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) => const ECertificatePage()),
                  ),
                ),
              ],
            ),
          ),

          // KONTAINER 2
          const Text(
            'Pengaturan Akun',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          Card(
            margin: const EdgeInsets.only(top: 8, bottom: 24),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.lock),
                  title: const Text('Edit Password'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) => const EditPasswordPage()),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('Edit Profil'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) => const EditProfilePage()),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.fingerprint),
                  title: const Text('Login Sidik Jari'),
                  trailing: Text(
                    isBiometricEnabled ? 'Aktif' : 'Nonaktif',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  onTap: _showBiometricDialog,
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.cleaning_services),
                  title: const Text('Bersihkan Cache'),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Cache berhasil dibersihkan'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // KONTAINER 3
          const Text(
            'Informasi Umum',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          Card(
            margin: const EdgeInsets.only(top: 8, bottom: 32),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('Tentang Kami'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) => const AboutUsPage()),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.help),
                  title: const Text('Pusat Bantuan'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) => const HelpCenterPage()),
                  ),
                ),
                const Divider(height: 1),
                const ListTile(
                  leading: Icon(Icons.android),
                  title: Text('Versi Aplikasi'),
                  trailing: Text(
                    'v1.0.0',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),

          // TOMBOL LOGOUT
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade50,
              foregroundColor: Colors.red,
              padding: const EdgeInsets.all(16),
            ),
            icon: const Icon(Icons.logout),
            label: const Text(
              'Keluar (Logout)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            onPressed: () {
              // Aksi Logout
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

// ==========================================
// SUB-HALAMAN KONTAINER 1
// ==========================================

// 1.A. HISTORY TRANSAKSI
class HistoryTransactionPage extends StatefulWidget {
  const HistoryTransactionPage({super.key});
  @override
  State<HistoryTransactionPage> createState() => _HistoryTransactionPageState();
}

class _HistoryTransactionPageState extends State<HistoryTransactionPage> {
  String selectedFilter = 'Semua';
  final List<String> filters = [
    'Semua',
    'Pelatihan',
    'Sertifikasi',
    'Riksa Uji',
    'Perpanjangan',
  ];
  final List<Map<String, String>> allData = [
    {
      'layanan': 'Pelatihan',
      'judul': 'Ahli K3 Umum',
      'status': 'Selesai',
      'tanggal': '12 Jan 2026',
    },
    {
      'layanan': 'Sertifikasi',
      'judul': 'ISO 9001:2015',
      'status': 'Proses',
      'tanggal': '05 Feb 2026',
    },
    {
      'layanan': 'Riksa Uji',
      'judul': 'Riksa Uji Crane',
      'status': 'Selesai',
      'tanggal': '20 Mar 2026',
    },
  ];

  @override
  Widget build(BuildContext context) {
    var filteredData = selectedFilter == 'Semua'
        ? allData
        : allData.where((e) => e['layanan'] == selectedFilter).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('History Transaksi')),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: filters
                  .map(
                    (f) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(f),
                        selected: selectedFilter == f,
                        onSelected: (val) => setState(() => selectedFilter = f),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredData.length,
              itemBuilder: (context, i) => Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(filteredData[i]['judul']!),
                  subtitle: Text(
                    "${filteredData[i]['layanan']} | ${filteredData[i]['tanggal']}",
                  ),
                  trailing: Chip(label: Text(filteredData[i]['status']!)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 1.B. PELATIHAN SAYA
class MyTrainingPage extends StatelessWidget {
  const MyTrainingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pelatihan Saya'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Kemnaker'),
              Tab(text: 'BNSP'),
              Tab(text: 'Awareness'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildList(['Ahli K3 Umum (Kemnaker)', 'Petugas P3K']),
            _buildList(['Auditor SMK3 (BNSP)']),
            _buildList(['Dasar-dasar K3 (Awareness)', 'Ergonomi Perkantoran']),
          ],
        ),
      ),
    );
  }

  Widget _buildList(List<String> items) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, i) => Card(
        child: ListTile(
          leading: const Icon(Icons.school, color: Colors.blue),
          title: Text(items[i]),
          trailing: const Text(
            'Selesai',
            style: TextStyle(color: Colors.green),
          ),
        ),
      ),
    );
  }
}

// 1.C. DOKUMEN SAYA
class MyDocumentsPage extends StatefulWidget {
  const MyDocumentsPage({super.key});
  @override
  State<MyDocumentsPage> createState() => _MyDocumentsPageState();
}

class _MyDocumentsPageState extends State<MyDocumentsPage> {
  List<Map<String, String>> uploadedDocs = [];
  final List<String> docTypes = [
    'KTP',
    'Ijazah',
    'Pasfoto',
    'CV',
    'Surat Keterangan Sehat',
    'Surat Keterangan Kerja',
    'Pakta Intgritas',
  ];
  String? selectedType;

  void _showUploadDialog() {
    selectedType = docTypes.first;
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) => AlertDialog(
          title: const Text('Upload Dokumen Baru'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: selectedType,
                items: docTypes
                    .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                    .toList(),
                onChanged: (val) => setStateDialog(() => selectedType = val),
                decoration: const InputDecoration(labelText: 'Jenis Dokumen'),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.file_upload),
                label: const Text('Pilih File dari HP'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(
                  () => uploadedDocs.add({
                    'jenis': selectedType!,
                    'nama_file': 'file_terupload.pdf',
                  }),
                );
                Navigator.pop(context);
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dokumen Saya')),
      body: uploadedDocs.isEmpty
          ? const Center(child: Text('Belum ada dokumen yang diupload.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: uploadedDocs.length,
              itemBuilder: (context, i) => Card(
                child: ListTile(
                  leading: const Icon(Icons.file_present, color: Colors.blue),
                  title: Text(uploadedDocs[i]['jenis']!),
                  subtitle: Text(uploadedDocs[i]['nama_file']!),
                  trailing: const Icon(Icons.check_circle, color: Colors.green),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showUploadDialog,
        icon: const Icon(Icons.add),
        label: const Text('Upload Dokumen'),
      ),
    );
  }
}

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

// ==========================================
// SUB-HALAMAN KONTAINER 2
// ==========================================

// 2.A. EDIT PASSWORD (DENGAN SIMULASI OTP)
class EditPasswordPage extends StatefulWidget {
  const EditPasswordPage({super.key});
  @override
  State<EditPasswordPage> createState() => _EditPasswordPageState();
}

class _EditPasswordPageState extends State<EditPasswordPage> {
  bool isCodeSent = false;
  final _emailCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isCodeSent ? _buildOTPForm() : _buildRequestForm(),
      ),
    );
  }

  Widget _buildRequestForm() {
    return Column(
      children: [
        const TextField(
          obscureText: true,
          decoration: InputDecoration(labelText: 'Password Lama'),
        ),
        const SizedBox(height: 12),
        const TextField(
          obscureText: true,
          decoration: InputDecoration(labelText: 'Password Baru'),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _emailCtrl,
          decoration: const InputDecoration(
            labelText: 'Email Anda (Untuk Kode Konfirmasi)',
          ),
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (_emailCtrl.text.isNotEmpty) setState(() => isCodeSent = true);
            },
            child: const Text('Kirim Kode Konfirmasi'),
          ),
        ),
      ],
    );
  }

  Widget _buildOTPForm() {
    return Column(
      children: [
        Text(
          'Kami telah mengirimkan kode OTP ke email ${_emailCtrl.text}. Silakan masukkan kode di bawah ini:',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 24),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Kode OTP (Contoh: 123456)',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Password berhasil diubah!')),
              );
              Navigator.pop(context);
            },
            child: const Text('Simpan Password Baru'),
          ),
        ),
      ],
    );
  }
}

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

// ==========================================
// SUB-HALAMAN KONTAINER 3
// ==========================================

// 3.A. TENTANG KAMI
class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tentang Kami')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text(
            'Aplikasi Keselamatan Kerja',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            'Kami menyediakan layanan pelatihan, sertifikasi, dan riksa uji terbaik di Indonesia untuk memastikan kepatuhan standar industri Anda.',
          ),
          Divider(height: 40),
          Text(
            'Layanan Kami',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ListTile(
            leading: Icon(Icons.check),
            title: Text('Pelatihan Ahli K3'),
          ),
          ListTile(
            leading: Icon(Icons.check),
            title: Text('Sertifikasi ISO & SMK3'),
          ),
          ListTile(
            leading: Icon(Icons.check),
            title: Text('Riksa Uji Alat Berat'),
          ),
          Divider(height: 40),
          Text(
            'Kontak Kami',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('support@aplikasik3.com'),
          ),
          ListTile(leading: Icon(Icons.phone), title: Text('021-12345678')),
        ],
      ),
    );
  }
}

// 3.B. PUSAT BANTUAN (LIVE CHAT DUMMY)
class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({super.key});
  @override
  State<HelpCenterPage> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  final _chatCtrl = TextEditingController();
  final List<Map<String, dynamic>> messages = [
    {
      'isBot': true,
      'text':
          'Halo! Saya asisten virtual Anda. Ada yang bisa saya bantu terkait layanan kami?',
    },
  ];

  void _sendMessage() {
    if (_chatCtrl.text.isEmpty) return;
    String userText = _chatCtrl.text;

    setState(() {
      messages.add({'isBot': false, 'text': userText});
      _chatCtrl.clear();
    });

    // Simulasi Balasan Chatbot
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        messages.add({
          'isBot': true,
          'text':
              'Terima kasih atas pesan Anda. Agen kami akan segera membalas atau Anda bisa membaca artikel FAQ kami.',
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Live Chat Bantuan')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, i) {
                bool isBot = messages[i]['isBot'];
                return Align(
                  alignment: isBot
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isBot
                          ? Colors.grey.shade200
                          : Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(messages[i]['text']),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _chatCtrl,
                    decoration: const InputDecoration(
                      hintText: 'Ketik pesan...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a purple toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: .fromSeed(seedColor: Colors.deepPurple),
//       ),

//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: .center,
//           children: [
//             const Text('You have pushed the button this many times:'),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
