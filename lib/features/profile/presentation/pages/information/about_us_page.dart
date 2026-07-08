import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
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
          'Tentang Kami',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.05),
                border: Border(
                  bottom: BorderSide(
                    color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                  ),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.scaffoldBackgroundColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.shadow.withValues(alpha: 0.08),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/logo_safenesia_vertical.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.health_and_safety_rounded,
                          size: 60,
                          color: colorScheme.primary,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Safenesia',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w800,
                      fontSize: 28,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Versi 1.0.0+2',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Deskripsi Singkat
                  Text(
                    'Pelopor Solusi K3 Digital di Indonesia',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Safenesia adalah platform inovatif yang dirancang untuk mempermudah perusahaan dan individu dalam memenuhi standar Keselamatan dan Kesehatan Kerja (K3). Kami mengintegrasikan teknologi modern dengan kebutuhan kepatuhan industri secara seamless.',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      height: 1.6,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Visi & Misi
                  _buildSectionHeader(context, Icons.visibility_rounded, 'Visi & Misi'),
                  const SizedBox(height: 16),
                  _buildVisionMissionCard(
                    context,
                    title: 'Visi',
                    content: 'Menjadi platform ekosistem K3 nomor satu yang mewujudkan nol kecelakaan kerja (zero accident) di seluruh sektor industri Indonesia.',
                    icon: Icons.rocket_launch_rounded,
                  ),
                  const SizedBox(height: 12),
                  _buildVisionMissionCard(
                    context,
                    title: 'Misi',
                    content: 'Menyediakan akses mudah dan terpercaya ke layanan sertifikasi, pelatihan unggulan, dan pengawasan riksa uji berbasis teknologi terdepan.',
                    icon: Icons.track_changes_rounded,
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Layanan Kami
                  _buildSectionHeader(context, Icons.miscellaneous_services_rounded, 'Layanan Utama'),
                  const SizedBox(height: 16),
                  _buildServiceItem(
                    context,
                    title: 'Pelatihan & Sertifikasi',
                    desc: 'Program ahli K3 Umum, Spesialis, dan ISO dengan sertifikasi resmi dari Kemnaker & BNSP.',
                    icon: Icons.school_rounded,
                  ),
                  _buildServiceItem(
                    context,
                    title: 'Riksa Uji Alat',
                    desc: 'Pemeriksaan kelayakan operasional alat berat, pesawat angkat angkut, dan instalasi.',
                    icon: Icons.plumbing_rounded,
                  ),
                  _buildServiceItem(
                    context,
                    title: 'Konsultasi SMK3',
                    desc: 'Pendampingan penerapan Sistem Manajemen K3 untuk mencapai standar audit terbaik.',
                    icon: Icons.handshake_rounded,
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Kontak
                  _buildSectionHeader(context, Icons.headset_mic_rounded, 'Hubungi Kami'),
                  const SizedBox(height: 16),
                  _buildContactCard(context),
                  
                  const SizedBox(height: 40),
                  
                  // Copyright
                  Center(
                    child: Text(
                      '© ${DateTime.now().year} PT Safenesia Solusi Terpadu.\nHak Cipta Dilindungi.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, IconData icon, String title) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(icon, color: colorScheme.primary, size: 22),
        const SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildVisionMissionCard(BuildContext context, {required String title, required String content, required IconData icon}) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: colorScheme.primary, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  content,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 1.5,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem(BuildContext context, {required String title, required String desc, required IconData icon}) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: colorScheme.primary, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 1.5,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: Column(
        children: [
          _buildContactRow(context, Icons.email_outlined, 'Email', 'support@safenesia.com'),
          Divider(height: 1, color: colorScheme.outlineVariant.withValues(alpha: 0.3)),
          _buildContactRow(context, Icons.phone_outlined, 'Telepon', '+62 21 1234 5678'),
          Divider(height: 1, color: colorScheme.outlineVariant.withValues(alpha: 0.3)),
          _buildContactRow(context, Icons.location_on_outlined, 'Alamat', 'Menara K3, Lt. 12\nJakarta Selatan, Indonesia'),
        ],
      ),
    );
  }

  Widget _buildContactRow(BuildContext context, IconData icon, String title, String value) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Icon(icon, color: colorScheme.primary, size: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: colorScheme.onSurface,
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
