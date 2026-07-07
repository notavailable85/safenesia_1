import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safenesia_1/features/certification/presentation/pages/certification_detail_page.dart';
import 'package:safenesia_1/features/certification/models/certification_model.dart';
import 'package:safenesia_1/core/database/database_helper.dart';
import 'package:safenesia_1/core/utils/currency_formatter.dart';
import 'package:safenesia_1/core/widgets/standard_search_field.dart';

// ==========================================
// 1. HALAMAN DAFTAR SERTIFIKASI
// ==========================================
class CertListPage extends StatefulWidget {
  const CertListPage({super.key});

  @override
  State<CertListPage> createState() => _CertListPageState();
}

class _CertListPageState extends State<CertListPage> {
  List<CertModel> _certifications = [];
  bool _isLoading = true;

  String _searchQuery = '';
  String _sortBy = 'terbaru';
  String? _selectedLevel;

  final List<String> _levelList = ['Dasar', 'Lanjutan', 'Manajerial'];

  @override
  void initState() {
    super.initState();
    _refreshCertifications();
  }

  Future<void> _refreshCertifications() async {
    setState(() => _isLoading = true);
    try {
      final data = await DatabaseHelper.instance.readAllCertifications();
      if (mounted) {
        setState(() {
          _certifications = data;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(milliseconds: 1500),
            content: Text('Terjadi kesalahan memuat data: $e'),
          ),
        );
      }
    }
  }

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
                        'Filter Sertifikasi',
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
                    'Urutkan Harga',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 12,
                    children: ['termurah', 'termahal'].map((sortType) {
                      final isSelected = _sortBy == sortType;
                      return ChoiceChip(
                        label: Text(
                          sortType == 'termurah' ? ' Termurah ' : ' Termahal ',
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

                  // --- Level Dropdown ---
                  Text(
                    'Level Sertifikasi',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    isExpanded: true,
                    initialValue: _selectedLevel,
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
                      'Semua Level',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    dropdownColor: Theme.of(context).colorScheme.surface,
                    items: [
                      const DropdownMenuItem<String>(
                        value: null,
                        child: Text('Semua Level'),
                      ),
                      ..._levelList.map(
                        (k) => DropdownMenuItem(value: k, child: Text(k)),
                      ),
                    ],
                    onChanged: (val) {
                      setModalState(() => _selectedLevel = val);
                      setState(() => _selectedLevel = val);
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: StandardSearchField(
            hintText: 'Cari sertifikasi...',
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
                  color: theme.brightness == Brightness.dark
                      ? Colors.black
                      : Colors.white,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: theme.brightness == Brightness.dark
                            ? Colors.black26
                            : theme.primaryColor.withValues(alpha: 0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TabBar(
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    dividerColor: Colors.transparent,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 24),
                    indicatorPadding: const EdgeInsets.symmetric(
                      horizontal: -8,
                      vertical: 6,
                    ),
                    indicator: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: colorScheme.onSurface.withValues(
                      alpha: 0.6,
                    ),
                    labelStyle: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    unselectedLabelStyle: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    tabs: const [
                      Tab(text: 'Sertifikasi SMK3'),
                      Tab(text: 'Sertifikasi ISO'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                children: [_buildCertList('SMK3'), _buildCertList('ISO')],
              ),
      ),
    );
  }

  Widget _buildCertList(String category) {
    var filteredList = _certifications
        .where((cert) => cert.category == category)
        .toList();

    // Apply Search
    if (_searchQuery.isNotEmpty) {
      filteredList = filteredList
          .where(
            (c) => c.title.toLowerCase().contains(_searchQuery.toLowerCase()),
          )
          .toList();
    }

    // Apply Filters
    if (_selectedLevel != null) {
      filteredList = filteredList
          .where((c) => c.level.toLowerCase() == _selectedLevel!.toLowerCase())
          .toList();
    }

    // Apply Sorting
    filteredList.sort((a, b) {
      if (_sortBy == 'termurah') {
        return a.basePrice.compareTo(b.basePrice);
      } else if (_sortBy == 'termahal') {
        return b.basePrice.compareTo(a.basePrice);
      }
      return 0;
    });

    if (filteredList.isEmpty) {
      return Center(
        child: Text(
          'Tidak ada sertifikasi untuk kategori ini.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(left: 12, top: 12, right: 12, bottom: 100),
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        final cert = filteredList[index];
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
                    builder: (context) => CertDetailPage(certData: cert),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Header: Judul & Badge Kategori ---
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            cert.title.toUpperCase(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
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
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            cert.category,
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

                    // --- Sub Header: Level ---
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Level ',
                            style: GoogleFonts.lora(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                              fontSize: 13,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          TextSpan(
                            text: cert.level,
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

                    // --- Footer: Price ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          cert.basePrice.toRupiah(),
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
