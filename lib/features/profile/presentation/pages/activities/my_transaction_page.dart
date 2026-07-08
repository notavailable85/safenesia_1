import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:safenesia_1/features/profile/models/transaction_model.dart';
import 'package:safenesia_1/features/profile/repositories/transaction_repository.dart';
import 'package:safenesia_1/core/database/database_helper.dart';
class HistoryTransactionPage extends StatefulWidget {
  const HistoryTransactionPage({super.key});

  @override
  State<HistoryTransactionPage> createState() => _HistoryTransactionPageState();
}

class _HistoryTransactionPageState extends State<HistoryTransactionPage> {
  String selectedFilter = 'Semua';
  final List<String> filters = [
    'Semua',
    'Pelatihan',
    'Sertifikasi',
    'Riksa Uji',
    'Perpanjangan',
  ];

  final ITransactionRepository _repository = LocalTransactionRepository();
  List<TransactionModel> allData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTransactions();
    DatabaseHelper.transactionNotifier.addListener(_loadTransactions);
  }

  @override
  void dispose() {
    DatabaseHelper.transactionNotifier.removeListener(_loadTransactions);
    super.dispose();
  }

  Future<void> _loadTransactions() async {
    try {
      final data = await _repository.getTransactions();
      if (!mounted) return;
      setState(() {
        allData = data;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => isLoading = false);
    }
  }

  String _formatCurrency(int? amount) {
    if (amount == null) return 'Menunggu Pembayaran';
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(amount);
  }

  IconData _getIconForService(String service) {
    switch (service) {
      case 'Pelatihan':
        return Icons.school_rounded;
      case 'Sertifikasi':
        return Icons.workspace_premium_rounded;
      case 'Riksa Uji':
        return Icons.fact_check_rounded;
      case 'Perpanjangan':
        return Icons.autorenew_rounded;
      default:
        return Icons.receipt_long_rounded;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'selesai':
      case 'berhasil':
        return Colors.green;
      case 'proses':
      case 'menunggu':
        return Colors.orange;
      case 'batal':
      case 'gagal':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return DefaultTabController(
      length: filters.length,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text(
            'Riwayat Transaksi',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: theme.colorScheme.onPrimary,
            ),
          ),
          backgroundColor: primaryColor,
          iconTheme: IconThemeData(color: theme.colorScheme.onPrimary),
          elevation: 0,
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(58),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(
                  height: 2,
                  thickness: 2,
                  color: theme.brightness == Brightness.dark
                      ? Colors.black
                      : Colors.white,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: theme.brightness == Brightness.dark
                            ? Colors.black26
                            : primaryColor.withValues(alpha: 0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TabBar(
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    dividerColor: Colors.transparent,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 24),
                    indicatorPadding: const EdgeInsets.symmetric(horizontal: -8, vertical: 6),
                    indicator: BoxDecoration(
                      color: primaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    labelStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
                    unselectedLabelStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
                    tabs: filters.map((f) => Tab(text: f)).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator(color: primaryColor))
            : TabBarView(
                children: filters.map((f) {
                  final tabData = f == 'Semua'
                      ? allData
                      : allData.where((e) => e.layanan == f).toList();
                  
                  if (tabData.isEmpty) return _buildEmptyState(theme);
                  
                  return ListView.builder(
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24, top: 16),
                    itemCount: tabData.length,
                    itemBuilder: (context, i) {
                      final trx = tabData[i];
                      return _buildTransactionCard(trx, theme, primaryColor);
                    },
                  );
                }).toList(),
              ),
      ),
    );
  }

  Widget _buildTransactionCard(
      TransactionModel trx, ThemeData theme, Color primaryColor) {
    final statusColor = _getStatusColor(trx.status);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardTheme.color ?? theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Icon + Category + Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getIconForService(trx.layanan),
                      color: primaryColor,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    trx.layanan,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  trx.status,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Title
          Text(
            trx.judul,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Date & Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_rounded,
                    size: 14,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    trx.tanggal,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              Text(
                _formatCurrency(trx.totalBayar),
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: primaryColor,
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
            Icons.receipt_long_rounded,
            size: 64,
            color: theme.colorScheme.outlineVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'Belum ada transaksi',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Transaksi pelatihan dan sertifikasi\nakan muncul di sini.',
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
