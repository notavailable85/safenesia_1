import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safenesia_1/features/career/models/career_model.dart';
import 'package:safenesia_1/core/database/database_helper.dart';

class CareerDetailPage extends StatefulWidget {
  final CareerModel career;

  const CareerDetailPage({super.key, required this.career});

  @override
  State<CareerDetailPage> createState() => _CareerDetailPageState();
}

class _CareerDetailPageState extends State<CareerDetailPage> {
  late CareerModel _career;

  @override
  void initState() {
    super.initState();
    _career = widget.career;
  }

  void _applyJob() async {
    // Simulate API request or just update local DB
    final updatedCareer = CareerModel(
      id: _career.id,
      title: _career.title,
      company: _career.company,
      field: _career.field,
      location: _career.location,
      jobType: _career.jobType,
      experienceLevel: _career.experienceLevel,
      salaryMin: _career.salaryMin,
      salaryMax: _career.salaryMax,
      description: _career.description,
      requirements: _career.requirements,
      benefits: _career.benefits,
      postedDate: _career.postedDate,
      companyLogoUrl: _career.companyLogoUrl,
      isSaved: _career.isSaved,
      isApplied: 1, // Set to applied
    );

    await DatabaseHelper.instance.updateCareer(updatedCareer);

    if (mounted) {
      setState(() {
        _career = updatedCareer;
      });

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 60),
              const SizedBox(height: 16),
              Text(
                'Lamaran Berhasil Dikirim!',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Perusahaan akan meninjau profil Anda segera.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close dialog
                    Navigator.pop(context, true); // Pop page with result
                  },
                  child: const Text('Kembali ke Lowongan'),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isApplied = _career.isApplied == 1;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pekerjaan'),
        actions: [
          IconButton(
            icon: Icon(
              _career.isSaved == 1 ? Icons.bookmark : Icons.bookmark_border,
              color: _career.isSaved == 1 ? primaryColor : Colors.grey,
            ),
            onPressed: () async {
              final updatedCareer = CareerModel(
                id: _career.id,
                title: _career.title,
                company: _career.company,
                field: _career.field,
                location: _career.location,
                jobType: _career.jobType,
                experienceLevel: _career.experienceLevel,
                salaryMin: _career.salaryMin,
                salaryMax: _career.salaryMax,
                description: _career.description,
                requirements: _career.requirements,
                benefits: _career.benefits,
                postedDate: _career.postedDate,
                companyLogoUrl: _career.companyLogoUrl,
                isSaved: _career.isSaved == 1 ? 0 : 1,
                isApplied: _career.isApplied,
              );
              await DatabaseHelper.instance.updateCareer(updatedCareer);
              setState(() {
                _career = updatedCareer;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.all(24),
              color: primaryColor.withValues(alpha: 0.05),
              child: Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: _career.companyLogoUrl.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              _career.companyLogoUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (c, e, s) => Icon(
                                Icons.business,
                                size: 36,
                                color: primaryColor,
                              ),
                            ),
                          )
                        : Icon(Icons.business, size: 36, color: primaryColor),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _career.title,
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _career.company,
                          style: TextStyle(
                            fontSize: 16,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 14,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _career.location,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badges
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildBadge(Icons.work_outline, _career.jobType),
                      _buildBadge(Icons.stairs, _career.experienceLevel),
                      _buildBadge(
                        Icons.monetization_on_outlined,
                        'Rp ${_career.salaryMin ~/ 1000000} Jt - ${_career.salaryMax ~/ 1000000} Jt',
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Description
                  _buildSectionTitle('Deskripsi Pekerjaan'),
                  const SizedBox(height: 12),
                  Text(
                    _career.description,
                    style: const TextStyle(height: 1.6, color: Colors.black87),
                  ),

                  const SizedBox(height: 24),

                  // Requirements
                  _buildSectionTitle('Persyaratan'),
                  const SizedBox(height: 12),
                  Text(
                    _career.requirements,
                    style: const TextStyle(height: 1.6, color: Colors.black87),
                  ),

                  const SizedBox(height: 24),

                  // Benefits
                  _buildSectionTitle('Keuntungan & Fasilitas'),
                  const SizedBox(height: 12),
                  Text(
                    _career.benefits,
                    style: const TextStyle(height: 1.6, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              offset: const Offset(0, -4),
              blurRadius: 10,
            ),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isApplied ? Colors.grey : primaryColor,
                foregroundColor: isApplied
                    ? Colors.white
                    : Theme.of(context).colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: isApplied ? null : _applyJob,
              child: Text(
                isApplied ? 'Telah Dilamar' : 'Lamar Sekarang',
                style: const TextStyle(
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

  Widget _buildBadge(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.grey.shade700),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
