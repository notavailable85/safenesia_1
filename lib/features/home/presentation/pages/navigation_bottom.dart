import 'package:flutter/material.dart';
import 'package:safenesia_1/features/career/career_page.dart';
import 'package:safenesia_1/features/home/presentation/pages/home_page.dart';
import 'package:safenesia_1/features/home/presentation/pages/list_pelatihan_page.dart';

// ==========================================
// 0. MAIN NAVIGATION (BOTTOM NAV BAR)
// ==========================================
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const KarirPage(),
    const PelatihanK3ListPage(), // Halaman khusus list Pelatihan dari Bottom Nav
    const DummyAkunPage(), // Placeholder untuk halaman akun yang sudah dibuat sebelumnya
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue.shade800,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Karir'),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Pelatihan K3',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Akun'),
        ],
      ),
    );
  }
}
