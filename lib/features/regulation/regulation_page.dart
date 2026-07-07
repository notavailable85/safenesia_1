import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safenesia_1/features/regulation/models/regulation_model.dart';
import 'package:safenesia_1/features/regulation/presentation/pages/regulation_detail_page.dart';
import 'package:safenesia_1/core/database/database_helper.dart';
import 'package:safenesia_1/core/widgets/standard_search_field.dart';

class RegulasiPage extends StatefulWidget {
  const RegulasiPage({super.key});

  @override
  State<RegulasiPage> createState() => _RegulasiPageState();
}

class _RegulasiPageState extends State<RegulasiPage> {
  List<RegulationModel> _allRegulations = [];
  List<RegulationModel> _filteredRegulations = [];
  bool _isLoading = true;
  String _searchQuery = '';
  String _selectedCategory = 'Semua';
  List<String> _categories = ['Semua'];

  @override
  void initState() {
    super.initState();
    _loadRegulations();
  }

  Future<void> _loadRegulations() async {
    final regulations = await DatabaseHelper.instance.readAllRegulations();

    // Extract unique categories
    final Set<String> cats = {'Semua'};
    for (var reg in regulations) {
      cats.add(reg.category);
    }

    setState(() {
      _allRegulations = regulations;
      _filteredRegulations = regulations;
      _categories = cats.toList();
      _isLoading = false;
    });
  }

  void _filterData() {
    setState(() {
      _filteredRegulations = _allRegulations.where((reg) {
        final matchesCategory =
            _selectedCategory == 'Semua' || reg.category == _selectedCategory;
        final query = _searchQuery.toLowerCase();
        final matchesSearch =
            query.isEmpty ||
            reg.title.toLowerCase().contains(query) ||
            reg.nomor.toLowerCase().contains(query) ||
            reg.tahun.toLowerCase().contains(query);
        return matchesCategory && matchesSearch;
      }).toList();
    });
  }

  void _onSearchChanged(String query) {
    _searchQuery = query;
    _filterData();
  }

  void _onCategorySelected(String category) {
    _selectedCategory = category;
    _filterData();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: StandardSearchField(
          hintText: 'Cari regulasi...',
          onChanged: _onSearchChanged,
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Horizontal Categories
                Container(
                  height: 50,
                  margin: const EdgeInsets.only(top: 12, bottom: 8),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      final category = _categories[index];
                      final isSelected = category == _selectedCategory;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(category),
                          selected: isSelected,
                          onSelected: (selected) {
                            if (selected) _onCategorySelected(category);
                          },
                          backgroundColor: theme.scaffoldBackgroundColor,
                          selectedColor: theme.primaryColor,
                          labelStyle: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : theme.textTheme.bodyMedium?.color,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // List of Regulations
                Expanded(
                  child: _filteredRegulations.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.gavel,
                                size: 80,
                                color: Colors.grey.shade300,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Regulasi tidak ditemukan',
                                style: TextStyle(color: Colors.grey.shade500),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.only(
                            left: 16,
                            top: 16,
                            right: 16,
                            bottom: 100,
                          ),
                          itemCount: _filteredRegulations.length,
                          itemBuilder: (context, index) {
                            final reg = _filteredRegulations[index];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          RegulationDetailPage(regulation: reg),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Icon PDF
                                      Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Colors.red.withValues(
                                            alpha: 0.1,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.picture_as_pdf,
                                          color: Colors.red,
                                          size: 32,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      // Content
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              reg.title,
                                              style: GoogleFonts.inter(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              '${reg.nomor} - Tahun ${reg.tahun}',
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey.shade600,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 2,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: theme.primaryColor
                                                    .withValues(alpha: 0.1),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Text(
                                                reg.category,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: theme.primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Bookmark
                                      IconButton(
                                        icon: Icon(
                                          reg.isSaved == 1
                                              ? Icons.bookmark
                                              : Icons.bookmark_border,
                                          color: reg.isSaved == 1
                                              ? Colors.orange
                                              : Colors.grey.shade400,
                                        ),
                                        onPressed: () async {
                                          // Toggle bookmark
                                          final newReg = RegulationModel(
                                            id: reg.id,
                                            category: reg.category,
                                            title: reg.title,
                                            nomor: reg.nomor,
                                            tahun: reg.tahun,
                                            deskripsi: reg.deskripsi,
                                            fileUrl: reg.fileUrl,
                                            isSaved: reg.isSaved == 1 ? 0 : 1,
                                          );
                                          await DatabaseHelper.instance
                                              .updateRegulation(newReg);
                                          _loadRegulations(); // Refresh
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}
