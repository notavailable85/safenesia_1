import 'package:flutter/material.dart';
import 'package:safenesia_1/features/career/career_page.dart';
import 'package:safenesia_1/features/home/presentation/pages/home_page.dart';
import 'package:safenesia_1/features/training/presentation/pages/training_list_page.dart';
import 'package:safenesia_1/features/profile/presentation/pages/profile_page.dart';

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

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  final List<Widget> _pages = [
    const HomePage(),
    const TrainingListPage(),
    const KarirPage(),
    const AccountPage(),
  ];

  void _onPopInvoked(bool didPop) {
    if (didPop) return;

    final navigator = _navigatorKeys[_selectedIndex].currentState!;
    if (navigator.canPop()) {
      navigator.pop();
    } else {
      if (_selectedIndex != 0) {
        setState(() => _selectedIndex = 0);
      } else {
        // We are on the first tab and first route, close app if needed
        // Since canPop is false, if we want to allow closing, we can call
        // Navigator.of(context).pop() or SystemNavigator.pop()
        // But for now, returning will do nothing or we can allow pop.
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: _onPopInvoked,
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages.asMap().entries.map((entry) {
            return TabNavigator(
              navigatorKey: _navigatorKeys[entry.key],
              rootPage: entry.value,
            );
          }).toList(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            if (index == _selectedIndex) {
              _navigatorKeys[index].currentState!.popUntil(
                (route) => route.isFirst,
              );
            } else {
              setState(() => _selectedIndex = index);
            }
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'Pelatihan K3',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Karir'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Akun'),
          ],
        ),
      ),
    );
  }
}

class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final Widget rootPage;

  const TabNavigator({
    super.key,
    required this.navigatorKey,
    required this.rootPage,
  });

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => rootPage);
      },
    );
  }
}
