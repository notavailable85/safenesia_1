import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safenesia_1/features/training/presentation/pages/training_detail_page.dart';

import 'package:safenesia_1/features/training/models/training_schedule_model.dart';
import 'package:safenesia_1/core/database/database_helper.dart';
import 'package:safenesia_1/core/utils/currency_formatter.dart';
import 'package:safenesia_1/core/widgets/standard_search_field.dart';

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
  String? _selectedMetode;

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

  final List<String> _metodeList = ['Offline', 'Online', 'Blended'];

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
          SnackBar(
            duration: const Duration(milliseconds: 1500),
            content: Text('Terjadi kesalahan memuat jadwal: $e'),
          ),
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

  // Dummy Data has been removed and replaced with SQLite integration.

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: 12,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Drag Handle ---
                  Center(
                    child: Container(
                      width: 40,
                      height: 5,
                      margin: const EdgeInsets.only(bottom: 24),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  // --- Header ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Filter Pelatihan',
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.05),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.close, size: 20),
                          color: Theme.of(context).colorScheme.onSurface,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // --- Sort Options (Choice Chips) ---
                  Text(
                    'Urutkan Waktu',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 12,
                    children: ['terdekat', 'terjauh'].map((sortType) {
                      final isSelected = _sortBy == sortType;
                      return ChoiceChip(
                        label: Text(
                          sortType == 'terdekat'
                              ? ' Paling Dekat '
                              : ' Paling Jauh ',
                        ),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) {
                            setModalState(() => _sortBy = sortType);
                            setState(() => _sortBy = sortType);
                          }
                        },
                        selectedColor: Theme.of(context).colorScheme.primary,
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.05),
                        labelStyle: TextStyle(
                          color: isSelected
                              ? Theme.of(context).colorScheme.onPrimary
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Colors.transparent,
                          ),
                        ),
                        showCheckmark: false,
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),

                  // --- Bidang Dropdown ---
                  Text(
                    'Kategori Bidang',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    isExpanded: true,
                    initialValue: _selectedKategori,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      filled: true,
                      fillColor: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.05),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 1.5,
                        ),
                      ),
                    ),
                    hint: Text(
                      'Semua Bidang',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    dropdownColor: Theme.of(context).colorScheme.surface,
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
                  const SizedBox(height: 16),

                  // --- Sertifikasi Dropdown ---
                  Text(
                    'Sertifikasi',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    isExpanded: true,
                    initialValue: _selectedSertifikasi,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      filled: true,
                      fillColor: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.05),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 1.5,
                        ),
                      ),
                    ),
                    hint: Text(
                      'Semua Sertifikasi',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    dropdownColor: Theme.of(context).colorScheme.surface,
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
                  const SizedBox(height: 16),

                  // --- Metode Pelatihan Dropdown ---
                  Text(
                    'Metode Pelatihan',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    isExpanded: true,
                    initialValue: _selectedMetode,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      filled: true,
                      fillColor: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.05),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 1.5,
                        ),
                      ),
                    ),
                    hint: Text(
                      'Semua Metode',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    dropdownColor: Theme.of(context).colorScheme.surface,
                    items: [
                      const DropdownMenuItem<String>(
                        value: null,
                        child: Text('Semua Metode'),
                      ),
                      ..._metodeList.map(
                        (m) => DropdownMenuItem(value: m, child: Text(m)),
                      ),
                    ],
                    onChanged: (val) {
                      setModalState(() => _selectedMetode = val);
                      setState(() => _selectedMetode = val);
                    },
                  ),
                  const SizedBox(height: 24),

                  // --- Apply Button ---
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Terapkan Filter',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
          title: StandardSearchField(
            hintText: 'Cari pelatihan...',
            onChanged: (val) {
              setState(() {
                _searchQuery = val;
              });
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: _showFilterModal,
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(58),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(
                  height: 2,
                  thickness: 2,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black
                      : Colors.white,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).scaffoldBackgroundColor, // Background tab bar mengikuti scaffold
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black26
                            : Theme.of(
                                context,
                              ).primaryColor.withValues(alpha: 0.3),
                        blurRadius: 15,
                        offset: const Offset(
                          0,
                          2,
                        ), // Efek shadow / border standar
                      ),
                    ],
                  ),
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
                      color: Theme.of(context)
                          .colorScheme
                          .primary, // Indikator menggunakan warna tema aplikasi
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ), // Standar border radius 20
                    ),
                    labelColor: Colors
                        .white, // Teks putih saat aktif karena indikator primary
                    unselectedLabelColor: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.6),
                    labelStyle: GoogleFonts.inter(
                      fontSize: 14, // Perbesar fontsize
                      fontWeight: FontWeight.w500,
                    ),
                    unselectedLabelStyle: GoogleFonts.inter(
                      fontSize: 14, // Perbesar fontsize
                      fontWeight: FontWeight.w500,
                    ),
                    tabs: _monthTabs.map((date) {
                      return Tab(
                        text: '${_getMonthName(date.month)} ${date.year}',
                      );
                    }).toList(),
                  ),
                ),
              ],
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
    if (_selectedMetode != null) {
      filteredSchedules = filteredSchedules
          .where(
            (s) =>
                s.trainingData?.metode.toLowerCase() ==
                _selectedMetode!.toLowerCase(),
          )
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
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(
                context,
              ).colorScheme.outlineVariant.withValues(alpha: 0.3),
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor.withValues(alpha: 0.04),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        TrainingDetailPage(scheduleData: schedule),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Header: Judul & Badge Bidang ---
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            training.namaPelatihan.toUpperCase(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 16, // Font lebih besar
                              fontWeight: FontWeight.normal, // Tidak perlu bold
                              height: 1.3,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary, // Badge warna primer solid
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            training.metode,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),

                    // --- Sub Header: Sertifikasi ---
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Sertifikasi ',
                            style: GoogleFonts.lora(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                              fontSize: 13,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          TextSpan(
                            text: training.sertifikasi,
                            style: GoogleFonts.inter(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // --- Divider ---
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: Theme.of(
                        context,
                      ).colorScheme.outlineVariant.withValues(alpha: 0.2),
                    ),
                    const SizedBox(height: 14),

                    // --- Footer: Date & Price ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Left: Date
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_month_outlined,
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
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Right: Price
                        Text(
                          training.hargaPromo.toRupiah(),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
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
