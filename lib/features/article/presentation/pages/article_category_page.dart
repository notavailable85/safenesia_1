import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safenesia_1/features/article/models/article_model.dart';

class ArticleCategoryPage extends StatelessWidget {
  const ArticleCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Exclude 'Semua' from grid display for better UI if wanted, but let's keep it
    final categories = articleCategories;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Semua Kategori'),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.5,
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
              color = Colors.blue;
              break;
            case 'Umum':
              iconData = Icons.public;
              color = Colors.green;
              break;
            case 'Listrik':
              iconData = Icons.electrical_services;
              color = Colors.orange;
              break;
            case 'Konstruksi':
              iconData = Icons.construction;
              color = Colors.brown;
              break;
            case 'Tambang':
              iconData = Icons.landscape;
              color = Colors.grey.shade700;
              break;
            case 'Rumah Sakit':
              iconData = Icons.local_hospital;
              color = Colors.red;
              break;
            case 'Oil & Gas':
              iconData = Icons.oil_barrel;
              color = Colors.black87;
              break;
            case 'Manufaktur':
              iconData = Icons.factory;
              color = Colors.purple;
              break;
            default:
              iconData = Icons.category;
              color = Colors.blueGrey;
          }

          return InkWell(
            onTap: () {
              // Return the selected category to the previous page
              Navigator.pop(context, category);
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color.withOpacity(0.5)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(iconData, size: 40, color: color),
                  const SizedBox(height: 8),
                  Text(
                    category,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
