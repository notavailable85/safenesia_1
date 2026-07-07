import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safenesia_1/features/article/models/article_model.dart';

class ArticleCategoryPage extends StatelessWidget {
  const ArticleCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final categories = articleCategories;

    return Scaffold(
      appBar: AppBar(title: const Text('Semua Kategori')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.2, // Slightly taller cards
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          // Icon and color mapping based on category
          IconData iconData;
          Color color;

          switch (category) {
            case 'Semua':
              iconData = Icons.all_inclusive;
              color = isDark ? Colors.blue.shade300 : Colors.blue.shade700;
              break;
            case 'Umum':
              iconData = Icons.public;
              color = isDark ? Colors.green.shade300 : Colors.green.shade700;
              break;
            case 'Listrik':
              iconData = Icons.electrical_services;
              color = isDark ? Colors.orange.shade300 : Colors.orange.shade700;
              break;
            case 'Konstruksi':
              iconData = Icons.construction;
              color = isDark ? Colors.brown.shade300 : Colors.brown.shade700;
              break;
            case 'Tambang':
              iconData = Icons.landscape;
              color = isDark ? Colors.grey.shade400 : Colors.grey.shade700;
              break;
            case 'Rumah Sakit':
              iconData = Icons.local_hospital;
              color = isDark ? Colors.red.shade300 : Colors.red.shade700;
              break;
            case 'Oil & Gas':
              iconData = Icons.oil_barrel;
              color = isDark ? Colors.grey.shade300 : Colors.black87;
              break;
            case 'Manufaktur':
              iconData = Icons.factory;
              color = isDark ? Colors.purple.shade300 : Colors.purple.shade700;
              break;
            default:
              iconData = Icons.category;
              color = isDark
                  ? Colors.blueGrey.shade300
                  : Colors.blueGrey.shade700;
          }

          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.pop(context, category);
              },
              borderRadius: BorderRadius.circular(16),
              child: Container(
                decoration: BoxDecoration(
                  color: isDark
                      ? color.withValues(alpha: 0.15)
                      : color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: color.withValues(alpha: isDark ? 0.3 : 0.5),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(iconData, size: 48, color: color),
                    const SizedBox(height: 12),
                    Text(
                      category,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        color: color,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
