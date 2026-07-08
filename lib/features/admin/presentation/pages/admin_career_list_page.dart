import 'package:flutter/material.dart';
import 'package:safenesia_1/core/database/database_helper.dart';
import 'package:safenesia_1/features/career/models/career_model.dart';
import 'package:safenesia_1/features/admin/presentation/pages/admin_career_form_page.dart';

class AdminCareerListPage extends StatefulWidget {
  const AdminCareerListPage({super.key});

  @override
  State<AdminCareerListPage> createState() => _AdminCareerListPageState();
}

class _AdminCareerListPageState extends State<AdminCareerListPage> {
  List<CareerModel> careers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    refreshCareers();
  }

  Future refreshCareers() async {
    setState(() => isLoading = true);
    careers = await DatabaseHelper.instance.readAllCareers();
    setState(() => isLoading = false);
  }

  Future deleteCareer(String id) async {
    await DatabaseHelper.instance.deleteCareer(id);
    refreshCareers();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(milliseconds: 1500),
          content: Text('Lowongan berhasil dihapus'),
        ),
      );
    }
  }

  Future _addDummyData() async {
    setState(() => isLoading = true);
    
    final dummy1 = CareerModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: 'HSE Officer',
      slug: 'hse-officer-jakarta',
      description: 'Dibutuhkan segera HSE Officer untuk proyek konstruksi di Jakarta Selatan.',
      requirements: '- Pendidikan min. S1 Teknik K3/Kesehatan Masyarakat\n- Pengalaman min. 2 tahun\n- Memiliki sertifikat AK3 Umum',
      responsibilities: '- Melakukan inspeksi K3 harian\n- Membuat laporan K3 bulanan\n- Mengadakan safety induction',
      benefits: '- Gaji pokok\n- Asuransi kesehatan\n- BPJS Ketenagakerjaan',
      companyId: 'comp-1',
      companyName: 'PT Konstruksi Maju Bersama',
      companyLogo: '',
      employmentType: 'Full-time',
      workplaceType: 'On-site',
      level: 'Staff (non-management & non-supervisor)',
      province: 'DKI Jakarta',
      city: 'Jakarta Selatan',
      address: 'Kawasan Rasuna Epicentrum',
      salaryVisible: true,
      salaryMin: 6000000,
      salaryMax: 8000000,
      salaryPeriod: 'Per Bulan',
      education: 'S1',
      minimumExperience: 2,
      skills: ['Risk Assessment', 'Safety Inspection', 'Reporting'],
      certificates: ['AK3 Umum Kemnaker'],
      applyUrl: 'https://example.com/apply/1',
      email: 'hr@konstruksimaju.com',
      phone: '081234567890',
      applicants: 15,
      bookmarks: 4,
      shares: 2,
      isFeatured: true,
      isUrgent: false,
      isActive: true,
      postedAt: DateTime.now().subtract(const Duration(days: 2)),
      expiredAt: DateTime.now().add(const Duration(days: 28)),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final dummy2 = CareerModel(
      id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
      title: 'Safety Inspector',
      slug: 'safety-inspector-balikpapan',
      description: 'Membuka lowongan untuk posisi Safety Inspector di area pertambangan.',
      requirements: '- Pendidikan min. D3\n- Memiliki sertifikat POP\n- Bersedia ditempatkan di Balikpapan',
      responsibilities: '- Mengawasi jalannya K3 di area tambang\n- Memastikan kelengkapan APD\n- Investigasi kecelakaan',
      benefits: '- Tiket pesawat cuti roster\n- Mess / Akomodasi\n- Tunjangan site',
      companyId: 'comp-2',
      companyName: 'PT Tambang Emas Nusantara',
      companyLogo: '',
      employmentType: 'Contract',
      workplaceType: 'On-site',
      level: 'Supervisor/Koordinator',
      province: 'Kalimantan Timur',
      city: 'Balikpapan',
      address: 'Site Penajam',
      salaryVisible: true,
      salaryMin: 8000000,
      salaryMax: 12000000,
      salaryPeriod: 'Per Bulan',
      education: 'D3',
      minimumExperience: 3,
      skills: ['Mining Safety', 'Incident Investigation'],
      certificates: ['Pengawas Operasional Pertama (POP)'],
      applyUrl: 'https://example.com/apply/2',
      email: 'recruitment@tambangemas.com',
      phone: '081199998888',
      applicants: 42,
      bookmarks: 10,
      shares: 5,
      isFeatured: false,
      isUrgent: true,
      isActive: true,
      postedAt: DateTime.now().subtract(const Duration(days: 5)),
      expiredAt: DateTime.now().add(const Duration(days: 10)),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await DatabaseHelper.instance.createCareer(dummy1);
    await DatabaseHelper.instance.createCareer(dummy2);

    await refreshCareers();
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('2 Data Dummy berhasil ditambahkan!'),
          duration: Duration(milliseconds: 1500),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Karir K3'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.auto_fix_high),
            tooltip: 'Tambah Data Dummy',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Tambah Data Dummy'),
                  content: const Text('Apakah Anda yakin ingin menambahkan 2 data lowongan Karir K3 secara otomatis?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Batal'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _addDummyData();
                      },
                      child: const Text('Tambahkan'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : careers.isEmpty
          ? const Center(child: Text('Belum ada data karir'))
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: careers.length,
              itemBuilder: (context, index) {
                final career = careers[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.1),
                      child: Icon(
                        Icons.work,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    title: Text(
                      career.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${career.companyName} - ${career.city}, ${career.province}'),
                        Text(
                          '${career.employmentType} • ${career.level}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    isThreeLine: true,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.orange),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AdminCareerFormPage(career: career),
                              ),
                            );
                            refreshCareers();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Hapus Lowongan'),
                                content: const Text(
                                  'Apakah Anda yakin ingin menghapus lowongan ini?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Batal'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      deleteCareer(career.id);
                                    },
                                    child: const Text(
                                      'Hapus',
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
        child: Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimary),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AdminCareerFormPage(),
            ),
          );
          refreshCareers();
        },
      ),
    );
  }
}
