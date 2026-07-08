import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final List<Map<String, dynamic>> sections = [
      {
        'icon': Icons.dataset_rounded,
        'title': '1. Pengumpulan Data',
        'content': 'Kami mengumpulkan informasi pribadi yang Anda berikan secara langsung saat mendaftar, seperti nama lengkap, alamat email, nomor telepon, dan data perusahaan untuk keperluan sertifikasi K3.',
      },
      {
        'icon': Icons.analytics_rounded,
        'title': '2. Penggunaan Informasi',
        'content': 'Data yang terkumpul digunakan untuk memverifikasi identitas, memproses pendaftaran pelatihan/sertifikasi, memberikan dukungan layanan pelanggan, dan mengirimkan notifikasi penting.',
      },
      {
        'icon': Icons.security_rounded,
        'title': '3. Keamanan Data',
        'content': 'Safenesia menerapkan standar enkripsi dan langkah keamanan teknis terkini untuk melindungi informasi pribadi Anda dari akses, modifikasi, atau penyebaran yang tidak sah.',
      },
      {
        'icon': Icons.lock_rounded,
        'title': '4. Berbagi Data',
        'content': 'Kami tidak akan pernah menjual, menyewakan, atau menukar data pribadi Anda kepada pihak ketiga tanpa izin eksplisit dari Anda, kecuali diwajibkan oleh hukum yang berlaku.',
      },
      {
        'icon': Icons.manage_accounts_rounded,
        'title': '5. Hak Pengguna',
        'content': 'Anda memiliki hak penuh untuk mengakses, memperbarui, atau meminta penghapusan data pribadi Anda kapan saja melalui menu pengaturan akun di dalam aplikasi.',
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
          'Kebijakan Privasi',
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
                        Icon(Icons.shield_rounded, color: colorScheme.primary, size: 28),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Komitmen Privasi',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Data Anda aman bersama kami',
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
                    'Privasi Anda sangat penting',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Kebijakan ini menjelaskan bagaimana Safenesia mengumpulkan, menggunakan, dan melindungi informasi pribadi Anda.',
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
