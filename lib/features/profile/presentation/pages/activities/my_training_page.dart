import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safenesia_1/core/database/database_helper.dart';
import 'package:safenesia_1/features/training/models/training_model.dart';

class MyTrainingPage extends StatefulWidget {
  const MyTrainingPage({super.key});

  @override
  State<MyTrainingPage> createState() => _MyTrainingPageState();
}

class _MyTrainingPageState extends State<MyTrainingPage> {
  List<Training> kemnakerTrainings = [];
  List<Training> bnspTrainings = [];
  List<Training> awarenessTrainings = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTrainings();
  }

  Future<void> _loadTrainings() async {
    try {
      final allTrainings = await DatabaseHelper.instance.readAllTrainings();
      
      final kemnaker = <Training>[];
      final bnsp = <Training>[];
      final awareness = <Training>[];

      for (var training in allTrainings) {
        final sertifikasi = training.sertifikasi.toLowerCase();
        if (sertifikasi.contains('kemnaker')) {
          kemnaker.add(training);
        } else if (sertifikasi.contains('bnsp')) {
          bnsp.add(training);
        } else {
          // Asumsikan selain kemnaker dan bnsp masuk ke Awareness/Lainnya
          awareness.add(training);
        }
      }

      if (!mounted) return;
      setState(() {
        kemnakerTrainings = kemnaker;
        bnspTrainings = bnsp;
        awarenessTrainings = awareness;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final onPrimaryColor = theme.colorScheme.onPrimary;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: onPrimaryColor),
          title: Text(
            'Pelatihan Saya',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: onPrimaryColor,
            ),
          ),
          bottom: TabBar(
            indicatorColor: onPrimaryColor,
            indicatorWeight: 3,
            labelColor: onPrimaryColor,
            unselectedLabelColor: onPrimaryColor.withValues(alpha: 0.7),
            labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
            unselectedLabelStyle: GoogleFonts.inter(fontWeight: FontWeight.w400),
            tabs: const [
              Tab(text: 'Kemnaker'),
              Tab(text: 'BNSP'),
              Tab(text: 'Awareness'),
            ],
          ),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator(color: primaryColor))
            : TabBarView(
                children: [
                  _buildList(kemnakerTrainings, theme, primaryColor),
                  _buildList(bnspTrainings, theme, primaryColor),
                  _buildList(awarenessTrainings, theme, primaryColor),
                ],
              ),
      ),
    );
  }

  Widget _buildList(List<Training> items, ThemeData theme, Color primaryColor) {
    if (items.isEmpty) {
      return _buildEmptyState(theme);
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: items.length,
      itemBuilder: (context, i) {
        final training = items[i];
        return _buildTrainingCard(training, theme, primaryColor);
      },
    );
  }

  Widget _buildTrainingCard(Training training, ThemeData theme, Color primaryColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Icon + Certification
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.school_rounded,
                  color: primaryColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  training.sertifikasi,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Terdaftar',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Title
          Text(
            training.namaPelatihan,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Bidang
          Row(
            children: [
              Icon(
                Icons.category_rounded,
                size: 14,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  training.bidang,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_rounded,
            size: 64,
            color: theme.colorScheme.outlineVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'Belum ada pelatihan',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Pelatihan yang Anda ikuti\nakan muncul di sini.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
