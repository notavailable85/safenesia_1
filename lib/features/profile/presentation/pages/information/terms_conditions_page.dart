import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final List<Map<String, dynamic>> sections = [
      {
        'icon': Icons.info_outline_rounded,
        'title': '1. Pendahuluan',
        'content': 'Dengan mengunduh, menginstal, dan menggunakan aplikasi Safenesia, Anda menyetujui secara sadar untuk terikat oleh semua Syarat dan Ketentuan ini. Jika Anda tidak setuju, mohon untuk tidak menggunakan layanan ini.',
      },
      {
        'icon': Icons.health_and_safety_rounded,
        'title': '2. Layanan K3',
        'content': 'Aplikasi ini dirancang khusus untuk memfasilitasi kebutuhan Keselamatan dan Kesehatan Kerja (K3) di Indonesia, termasuk pendaftaran pelatihan, sertifikasi, dan riksa uji.',
      },
      {
        'icon': Icons.person_outline_rounded,
        'title': '3. Kewajiban Pengguna',
        'content': 'Pengguna wajib memberikan informasi data diri maupun perusahaan yang valid, akurat, dan dapat dipertanggungjawabkan kebenarannya saat melakukan pendaftaran atau transaksi.',
      },
      {
        'icon': Icons.gavel_rounded,
        'title': '4. Kepatuhan Hukum',
        'content': 'Penggunaan aplikasi ini tunduk pada hukum dan perundang-undangan yang berlaku di Republik Indonesia. Kami berhak membatasi atau membekukan akun jika ditemukan indikasi pelanggaran.',
      },
      {
        'icon': Icons.update_rounded,
        'title': '5. Pembaruan Layanan',
        'content': 'Kami berhak melakukan perubahan, peningkatan, maupun penghentian layanan sementara untuk keperluan pemeliharaan (maintenance) yang akan diinformasikan sebelumnya apabila memungkinkan.',
      },
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: colorScheme.onSurface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'Syarat & Ketentuan',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header section
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: colorScheme.primary.withValues(alpha: 0.2)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.verified_user_rounded, color: colorScheme.primary, size: 28),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pembaruan Terakhir',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '12 Agustus 2026',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  Text(
                    'Mohon baca dengan saksama',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Syarat dan ketentuan ini mengatur penggunaan Anda atas aplikasi Safenesia dan layanan terkait yang kami sediakan.',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      height: 1.6,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Iterasi konten
                  ...sections.map((section) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: colorScheme.surface,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: colorScheme.shadow.withValues(alpha: 0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                              border: Border.all(
                                color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                              ),
                            ),
                            child: Icon(
                              section['icon'],
                              size: 20,
                              color: colorScheme.primary,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8),
                                Text(
                                  section['title'],
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: colorScheme.onSurface,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  section['content'],
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    height: 1.6,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          
          // Sticky Bottom Button
          Container(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 16,
              bottom: MediaQuery.paddingOf(context).bottom + 16,
            ),
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withValues(alpha: 0.05),
                  offset: const Offset(0, -4),
                  blurRadius: 16,
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Saya Mengerti',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
