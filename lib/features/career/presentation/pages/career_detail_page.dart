import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safenesia_1/features/career/models/career_model.dart';
import 'package:safenesia_1/core/database/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:safenesia_1/features/career/presentation/pages/career_apply_page.dart';
import 'package:safenesia_1/features/career/presentation/pages/company_profile_page.dart';

class CareerDetailPage extends StatefulWidget {
  final CareerModel career;

  const CareerDetailPage({super.key, required this.career});

  @override
  State<CareerDetailPage> createState() => _CareerDetailPageState();
}

class _CareerDetailPageState extends State<CareerDetailPage> {
  late CareerModel _career;
  bool _isApplied = false;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _career = widget.career;
    _checkStatus();
  }

  Future<void> _checkStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final applied = prefs.getStringList('applied_careers') ?? [];
    final saved = prefs.getStringList('saved_careers') ?? [];
    setState(() {
      _isApplied = applied.contains(_career.id);
      _isSaved = saved.contains(_career.id);
    });
  }

  Future<void> _toggleSave() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('saved_careers') ?? [];
    
    int delta = 0;
    if (_isSaved) {
      saved.remove(_career.id);
      delta = -1;
    } else {
      saved.add(_career.id);
      delta = 1;
    }
    
    await prefs.setStringList('saved_careers', saved);
    
    final updatedCareer = _career.copyWith(
      bookmarks: (_career.bookmarks + delta) < 0 ? 0 : _career.bookmarks + delta
    );
    
    await DatabaseHelper.instance.updateCareer(updatedCareer);
    
    setState(() {
      _isSaved = !_isSaved;
      _career = updatedCareer;
    });
  }

  Future<void> _applyJob() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CareerApplyPage(career: _career),
      ),
    );
    
    if (result == true) {
      _checkStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Detail Karir'),
        actions: [
          IconButton(
            icon: Icon(
              _isSaved ? Icons.bookmark : Icons.bookmark_border,
              color: _isSaved ? primaryColor : null,
            ),
            onPressed: _toggleSave,
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Container(
              padding: const EdgeInsets.all(24.0),
              color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
              width: double.infinity,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CompanyProfilePage(
                            companyId: _career.companyId,
                            companyName: _career.companyName,
                            companyLogo: _career.companyLogo,
                          ),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: _career.companyLogo.isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(
                                      _career.companyLogo,
                                      fit: BoxFit.cover,
                                      errorBuilder: (c, e, s) => const Icon(
                                        Icons.business,
                                        size: 40,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  )
                                : const Icon(Icons.business, size: 40, color: Colors.grey),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _career.companyName,
                            style: TextStyle(
                              fontSize: 16,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                              decorationColor: primaryColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _career.title,
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.location_on, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        '${_career.city}, ${_career.province}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildMiniBadge(_career.employmentType),
                      _buildMiniBadge(_career.workplaceType),
                      _buildMiniBadge(_career.level),
                    ],
                  ),
                ],
              ),
            ),
            
            // CONTENT
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_career.salaryVisible && _career.salaryMin != null && _career.salaryMax != null) ...[
                    _buildSectionTitle('Gaji'),
                    Text(
                      'Rp ${(_career.salaryMin! / 1000000).toStringAsFixed(0)} Jt - Rp ${(_career.salaryMax! / 1000000).toStringAsFixed(0)} Jt / ${_career.salaryPeriod}',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],

                  _buildSectionTitle('Deskripsi Pekerjaan'),
                  Text(
                    _career.description,
                    style: const TextStyle(height: 1.6, color: Colors.black87),
                  ),
                  const SizedBox(height: 24),
                  
                  _buildSectionTitle('Tanggung Jawab'),
                  Text(
                    _career.responsibilities,
                    style: const TextStyle(height: 1.6, color: Colors.black87),
                  ),
                  const SizedBox(height: 24),

                  _buildSectionTitle('Persyaratan'),
                  Text(
                    _career.requirements,
                    style: const TextStyle(height: 1.6, color: Colors.black87),
                  ),
                  const SizedBox(height: 24),
                  
                  _buildSectionTitle('Kualifikasi'),
                  Row(
                    children: [
                      const Icon(Icons.school, size: 20, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text('Minimal ${_career.education}'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.work, size: 20, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text('Pengalaman ${_career.minimumExperience} Tahun'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  if (_career.skills.isNotEmpty) ...[
                    _buildSectionTitle('Keahlian yang Dibutuhkan'),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _career.skills.map((s) => Chip(
                        label: Text(s),
                        backgroundColor: primaryColor.withValues(alpha: 0.1),
                        labelStyle: TextStyle(color: primaryColor, fontWeight: FontWeight.w600, fontSize: 13),
                        side: BorderSide.none,
                      )).toList(),
                    ),
                    const SizedBox(height: 24),
                  ],
                  
                  if (_career.certificates.isNotEmpty) ...[
                    _buildSectionTitle('Sertifikat Wajib'),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _career.certificates.map((c) => Chip(
                        label: Text(c),
                        backgroundColor: Colors.orange.shade50,
                        labelStyle: TextStyle(color: Colors.orange.shade800, fontWeight: FontWeight.w600, fontSize: 13),
                        side: BorderSide.none,
                      )).toList(),
                    ),
                    const SizedBox(height: 24),
                  ],

                  _buildSectionTitle('Benefit'),
                  Text(
                    _career.benefits,
                    style: const TextStyle(height: 1.6, color: Colors.black87),
                  ),
                  const SizedBox(height: 24),
                  
                  _buildSectionTitle('Informasi Perusahaan'),
                  Row(
                    children: [
                      const Icon(Icons.business_center, size: 20, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(_career.companyName, style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.map, size: 20, color: Colors.grey),
                      const SizedBox(width: 8),
                      Expanded(child: Text(_career.address)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.email, size: 20, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(_career.email),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.phone, size: 20, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(_career.phone),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: _isApplied ? null : _applyJob,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                _isApplied ? 'Telah Dilamar' : 'Lamar Sekarang',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildMiniBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blueGrey.shade100),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: Colors.blueGrey.shade700,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
