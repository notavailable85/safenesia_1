import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safenesia_1/core/constants/app_colors.dart';
import 'package:safenesia_1/features/training/presentation/pages/training_detail_page.dart';
import 'package:safenesia_1/features/training/presentation/pages/admin/admin_training_list_page.dart';
import 'package:safenesia_1/features/training/models/training_schedule_model.dart';
import 'package:safenesia_1/core/database/database_helper.dart';
import 'package:safenesia_1/core/utils/currency_formatter.dart';

class TrainingListPage extends StatefulWidget {
  const TrainingListPage({super.key});

  @override
  State<TrainingListPage> createState() => _TrainingListPageState();
}

class _TrainingListPageState extends State<TrainingListPage> {
  String _searchQuery = '';
  String _sortBy = 'terdekat'; // terdekat, terjauh
  String? _selectedKategori;
  String? _selectedSertifikasi;

  List<TrainingSchedule> _schedules = [];
  bool _isLoading = true;

  // Categories
  final List<String> _kategoriList = [
    'Keahlian K3 Umum',
    'Sistem Manajemen K3',
    'Listrik',
    'Konstruksi dan Bangunan',
    'Penanggulangan Kebakaran',
    'Elevator dan Eskalator',
    'Lingkungan Kerja dan Bahan Berbahaya',
    'Bekerja Pada Ketinggian',
    'Kesehatan Kerja',
    'Pesawat Angkat dan Pesawat Angkut',
    'Pesawat Tenaga dan Produksi',
    'Pesawat Uap, Bejana Tekanan dan Tangki Timbun',
    'Pengelasan',
  ];

  final List<String> _sertifikasiList = [
    'Sertifikasi Kemnaker RI',
    'Sertifikasi BNSP',
    'Sertifikasi Safenesia',
  ];

  // Dynamic Months (Current + next 3)
  late List<DateTime> _monthTabs;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _monthTabs = List.generate(
      4,
      (index) => DateTime(now.year, now.month + index, 1),
    );
    _refreshTrainings();
  }

  Future<void> _refreshTrainings() async {
    setState(() => _isLoading = true);
    try {
      final data = await DatabaseHelper.instance.readAllSchedulesWithTraining();
      if (mounted) {
        setState(() {
          _schedules = data;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Terjadi kesalahan memuat jadwal: $e')),
        );
      }
    }
  }

  String _getMonthName(int month) {
    const months = [
      '',
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return months[month];
  }

  String _getShortMonthName(int month) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Ags',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];
    return months[month];
  }

  // Dummy Data has been removed and replaced with SQLite integration.

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Filter Pelatihan',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      // TextStyle(
                      //     fontSize: 18,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const Divider(color: AppColors.primary, thickness: 1),
                  Text(
                    'Urutkan Jadwal',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'terdekat',
                        groupValue: _sortBy,
                        onChanged: (val) {
                          setModalState(() => _sortBy = val!);
                          setState(() => _sortBy = val!);
                        },
                      ),
                      const Text('Terdekat'),
                      Radio<String>(
                        value: 'terjauh',
                        groupValue: _sortBy,
                        onChanged: (val) {
                          setModalState(() => _sortBy = val!);
                          setState(() => _sortBy = val!);
                        },
                      ),
                      const Text('Terjauh'),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Bidang',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedKategori,
                    hint: const Text('Semua Bidang'),
                    items: [
                      const DropdownMenuItem<String>(
                        value: null,
                        child: Text('Semua Bidang'),
                      ),
                      ..._kategoriList.map(
                        (k) => DropdownMenuItem(value: k, child: Text(k)),
                      ),
                    ],
                    onChanged: (val) {
                      setModalState(() => _selectedKategori = val);
                      setState(() => _selectedKategori = val);
                    },
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Sertifikasi',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedSertifikasi,
                    hint: const Text('Semua Sertifikasi'),
                    items: [
                      const DropdownMenuItem<String>(
                        value: null,
                        child: Text('Semua Sertifikasi'),
                      ),
                      ..._sertifikasiList.map(
                        (s) => DropdownMenuItem(value: s, child: Text(s)),
                      ),
                    ],
                    onChanged: (val) {
                      setModalState(() => _selectedSertifikasi = val);
                      setState(() => _selectedSertifikasi = val);
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Terapkan Filter'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _monthTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari pelatihan...',
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
              onChanged: (val) {
                setState(() {
                  _searchQuery = val;
                });
              },
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.admin_panel_settings),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminTrainingListPage(),
                  ),
                );
                _refreshTrainings();
              },
            ),
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: _showFilterModal,
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(55),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
              ), // Memberi tinggi ekstra
              child: TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start, // Geser ke samping kiri
                dividerColor:
                    Colors.transparent, // Hapus garis abu-abu di bawah
                labelPadding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ), // Membuat gap antar tab sekitar 16
                indicatorPadding: EdgeInsetsGeometry.symmetric(
                  horizontal: -8,
                  vertical: 6,
                ),
                indicator: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).scaffoldBackgroundColor, // Indikator menggunakan warna scaffold agar menyatu dengan body
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                labelColor: Theme.of(context).colorScheme.onSurface,
                unselectedLabelColor: Theme.of(
                  context,
                ).colorScheme.onPrimary.withOpacity(0.7),
                labelStyle: GoogleFonts.inter(
                  fontSize: 14, // Perbesar fontsize
                  fontWeight: FontWeight.w500,
                ),
                unselectedLabelStyle: GoogleFonts.inter(
                  fontSize: 14, // Perbesar fontsize
                  fontWeight: FontWeight.w500,
                ),
                tabs: _monthTabs.map((date) {
                  return Tab(text: '${_getMonthName(date.month)} ${date.year}');
                }).toList(),
              ),
            ),
          ),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                children: _monthTabs.map((date) {
                  return _buildTrainingList(context, date.month, date.year);
                }).toList(),
              ),
      ),
    );
  }

  Widget _buildTrainingList(BuildContext context, int month, int year) {
    var filteredSchedules = _schedules.where((s) {
      final sDate = DateTime.tryParse(s.tanggalStart) ?? DateTime.now();
      return sDate.month == month && sDate.year == year;
    }).toList();

    // Apply Search
    if (_searchQuery.isNotEmpty) {
      filteredSchedules = filteredSchedules
          .where(
            (s) => (s.trainingData?.namaPelatihan ?? '').toLowerCase().contains(
              _searchQuery.toLowerCase(),
            ),
          )
          .toList();
    }

    // Apply Filters
    if (_selectedKategori != null) {
      filteredSchedules = filteredSchedules
          .where((s) => s.trainingData?.bidang == _selectedKategori)
          .toList();
    }
    if (_selectedSertifikasi != null) {
      filteredSchedules = filteredSchedules
          .where((s) => s.trainingData?.sertifikasi == _selectedSertifikasi)
          .toList();
    }

    // Apply Sorting
    filteredSchedules.sort((a, b) {
      final dateA = DateTime.tryParse(a.tanggalStart) ?? DateTime.now();
      final dateB = DateTime.tryParse(b.tanggalStart) ?? DateTime.now();
      if (_sortBy == 'terdekat') {
        return dateA.compareTo(dateB);
      } else {
        return dateB.compareTo(dateA);
      }
    });

    if (filteredSchedules.isEmpty) {
      return const Center(
        child: Text('Tidak ada jadwal pelatihan di bulan ini.'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(left: 12, top: 12, right: 12, bottom: 100),
      itemCount: filteredSchedules.length,
      itemBuilder: (context, index) {
        final schedule = filteredSchedules[index];
        final training = schedule.trainingData;
        if (training == null) return const SizedBox();

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color:
                Theme.of(context).cardTheme.color ??
                Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TrainingDetailPage(scheduleData: schedule),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Baris Pertama (Atas)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(
                              context,
                            ).colorScheme.primary.withOpacity(0.8),
                            Theme.of(context).colorScheme.primary,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        training.bidang,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Baris Kedua (Tengah)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Kiri (Sertifikasi)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            training.sertifikasi,
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.onPrimaryContainer,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Kanan (Tanggal)
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.calendar_month,
                                size: 16,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  schedule.tanggalStr,
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Baris Ketiga (Bawah)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Kiri (Judul)
                        Expanded(
                          child: Text(
                            training.namaPelatihan,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              color: AppColors.textPrimaryLight,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Kanan (Harga)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Theme.of(
                                context,
                              ).colorScheme.primary.withOpacity(0.3),
                            ),
                          ),
                          child: Text(
                            training.hargaPromo.toRupiah(),
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
