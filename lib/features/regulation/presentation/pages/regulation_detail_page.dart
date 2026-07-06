import 'package:flutter/material.dart';
import 'package:safenesia_1/features/regulation/models/regulation_model.dart';

class RegulationDetailPage extends StatelessWidget {
  final RegulationModel regulation;

  const RegulationDetailPage({super.key, required this.regulation});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Regulasi'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                regulation.category,
                style: TextStyle(
                  color: theme.colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Title
            Text(
              regulation.title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 8),
            
            // Nomor dan Tahun
            Row(
              children: [
                Icon(Icons.gavel, size: 18, color: Colors.grey.shade600),
                const SizedBox(width: 6),
                Text(
                  '${regulation.nomor} - ${regulation.tahun}',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            const Divider(),
            const SizedBox(height: 16),
            
            // Description
            Text(
              'Deskripsi',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              regulation.deskripsi.isEmpty 
                  ? 'Belum ada deskripsi untuk regulasi ini.' 
                  : regulation.deskripsi,
              style: theme.textTheme.bodyLarge?.copyWith(
                height: 1.5,
                color: theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70.0 + MediaQuery.of(context).padding.bottom,
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 8,
          bottom: 8 + MediaQuery.of(context).padding.bottom,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: const [
            BoxShadow(
              color: Color(0x0D000000), // 5% black
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: ElevatedButton.icon(
          onPressed: () {
            // TODO: Implement PDF Viewer / Downloader
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Mengunduh dokumen PDF: ${regulation.title}'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          icon: const Icon(Icons.picture_as_pdf),
          label: const Text('Baca Dokumen (PDF)'),
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.primaryColor,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
