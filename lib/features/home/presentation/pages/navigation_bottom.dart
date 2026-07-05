import 'package:flutter/material.dart';
import 'package:safenesia_1/features/career/career_page.dart';
import 'package:safenesia_1/features/home/presentation/pages/home_page.dart';
import 'package:safenesia_1/features/training/presentation/pages/training_list_page.dart';
import 'package:safenesia_1/features/profile/presentation/pages/profile_page.dart';
import 'package:safenesia_1/features/chat_ai/presentation/pages/chat_ai_page.dart';

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
    GlobalKey<NavigatorState>(), // Chat AI
  ];

  final List<Widget> _pages = [
    const HomePage(),
    const TrainingListPage(),
    const KarirPage(),
    const ChatAiPage(), // New Tab
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
        extendBody: true, // Allow content to scroll behind the floating nav bar
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages.asMap().entries.map((entry) {
            return TabNavigator(
              navigatorKey: _navigatorKeys[entry.key],
              rootPage: entry.value,
            );
          }).toList(),
        ),
        bottomNavigationBar: _buildModernBottomNavBar(),
      ),
    );
  }

  Widget _buildModernBottomNavBar() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = theme.primaryColor;
    final navTheme = theme.bottomNavigationBarTheme;
    final bgColor = navTheme.backgroundColor ?? Colors.white;
    final selectedColor = navTheme.selectedItemColor ?? Colors.white;
    final unselectedColor = navTheme.unselectedItemColor ?? Colors.white70;

    return Container(
      height: 70.0 + MediaQuery.of(context).padding.bottom,
      padding: EdgeInsets.only(
        left: 12,
        right: 12,
        bottom: MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : primaryColor.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, -2), // Shadow points upwards
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, Icons.home_rounded, 'Home', selectedColor, unselectedColor),
          _buildNavItem(1, Icons.school_rounded, 'Pelatihan', selectedColor, unselectedColor),
          _buildNavItem(2, Icons.work_rounded, 'Karir', selectedColor, unselectedColor),
          _buildNavItem(3, Icons.smart_toy_rounded, 'AI Chat', selectedColor, unselectedColor),
          _buildNavItem(4, Icons.person_rounded, 'Akun', selectedColor, unselectedColor),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label, Color selectedColor, Color unselectedColor) {
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        if (index == 0) {
          _navigatorKeys[0].currentState?.popUntil((route) => route.isFirst);
          if (_selectedIndex != 0) setState(() => _selectedIndex = 0);
        } else if (index == _selectedIndex) {
          _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
        } else {
          setState(() => _selectedIndex = index);
        }
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? selectedColor.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? selectedColor : unselectedColor,
              size: 22,
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOutCubic,
              child: isSelected
                  ? Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Text(
                        label,
                        style: TextStyle(
                          color: selectedColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
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
