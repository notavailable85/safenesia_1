import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:safenesia_1/core/theme/theme_notifier.dart';
import 'package:safenesia_1/core/constants/app_colors.dart';

class ThemeSettingPage extends StatefulWidget {
  const ThemeSettingPage({super.key});

  @override
  State<ThemeSettingPage> createState() => _ThemeSettingPageState();
}

class _ThemeSettingPageState extends State<ThemeSettingPage> {
  double _currentHue = 0.0;

  @override
  void initState() {
    super.initState();
    // Initialize hue based on current primary color
    final hsv = HSVColor.fromColor(appThemeNotifier.value);
    _currentHue = hsv.hue;
  }

  void _onHueChanged(double value) {
    setState(() {
      _currentHue = value;
    });
    final newColor = HSVColor.fromAHSV(1.0, _currentHue, 1.0, 0.8).toColor();
    appThemeNotifier.value = newColor;
  }

  Future<void> _saveColor() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('app_theme_color', appThemeNotifier.value.value);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Warna Tema berhasil diubah')),
      );
    }
  }

  void _onThemeModeChanged(ThemeMode mode) async {
    appThemeModeNotifier.value = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('app_theme_mode', mode.index);
  }

  void _resetColor() async {
    appThemeNotifier.value = AppColors.primary;
    final hsv = HSVColor.fromColor(AppColors.primary);
    setState(() {
      _currentHue = hsv.hue;
    });
    appThemeModeNotifier.value = ThemeMode.system;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('app_theme_color');
    await prefs.remove('app_theme_mode');
  }

  @override
  Widget build(BuildContext context) {
    // Generate gradient colors for the slider background
    final List<Color> hueColors = [];
    for (int i = 0; i <= 360; i++) {
      hueColors.add(HSVColor.fromAHSV(1.0, i.toDouble(), 1.0, 0.8).toColor());
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Tema Aplikasi')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mode Tampilan',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ValueListenableBuilder<ThemeMode>(
              valueListenable: appThemeModeNotifier,
              builder: (context, themeMode, child) {
                return SizedBox(
                  width: double.infinity,
                  child: SegmentedButton<ThemeMode>(
                    segments: const [
                      ButtonSegment(
                        value: ThemeMode.light,
                        label: Text('Terang'),
                        icon: Icon(Icons.light_mode),
                      ),
                      ButtonSegment(
                        value: ThemeMode.dark,
                        label: Text('Gelap'),
                        icon: Icon(Icons.dark_mode),
                      ),
                      ButtonSegment(
                        value: ThemeMode.system,
                        label: Text('Sistem'),
                        icon: Icon(Icons.settings_system_daydream),
                      ),
                    ],
                    selected: {themeMode},
                    onSelectionChanged: (Set<ThemeMode> newSelection) {
                      _onThemeModeChanged(newSelection.first);
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 32),
            const Text(
              'Sesuaikan Warna Utama',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Geser slider di bawah ini untuk mengubah warna dominan pada aplikasi.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: appThemeNotifier.value,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(colors: hueColors),
              ),
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 40,
                  activeTrackColor: Colors.transparent,
                  inactiveTrackColor: Colors.transparent,
                  thumbColor: Colors.white,
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 14.0,
                    elevation: 4.0,
                  ),
                  overlayColor: Colors.white.withOpacity(0.3),
                ),
                child: Slider(
                  value: _currentHue,
                  min: 0.0,
                  max: 360.0,
                  onChanged: _onHueChanged,
                  onChangeEnd: (value) {
                    _saveColor();
                  },
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  side: BorderSide.none,
                ),
                onPressed: _resetColor,
                child: const Text('Kembalikan ke Default'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
