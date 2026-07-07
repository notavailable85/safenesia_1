import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class ChatAiPage extends StatefulWidget {
  const ChatAiPage({super.key});

  @override
  State<ChatAiPage> createState() => _ChatAiPageState();
}

class _ChatAiPageState extends State<ChatAiPage> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    // Welcome message from AI
    _messages.add(
      ChatMessage(
        text:
            'Halo! Saya Asisten K3 Safenesia. Ada yang bisa saya bantu terkait Keselamatan dan Kesehatan Kerja hari ini?',
        isUser: false,
        timestamp: DateTime.now(),
      ),
    );
  }

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;

    _textController.clear();
    setState(() {
      _messages.add(
        ChatMessage(text: text, isUser: true, timestamp: DateTime.now()),
      );
      _isTyping = true;
    });

    _scrollToBottom();

    // Simulate AI thinking and replying
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        _isTyping = false;
        _messages.add(
          ChatMessage(
            text: _getDummyResponse(text),
            isUser: false,
            timestamp: DateTime.now(),
          ),
        );
      });
      _scrollToBottom();
    });
  }

  String _getDummyResponse(String input) {
    final lower = input.toLowerCase();

    // GREETINGS & CHITCHAT
    if (lower.contains('halo') ||
        lower.contains('hai') ||
        lower.contains('hello')) {
      return 'Halo! Saya Chat AI Safenesia. Ada yang bisa saya bantu terkait K3, pelatihan, atau riksa uji hari ini?';
    } else if (lower.contains('pagi') ||
        lower.contains('siang') ||
        lower.contains('sore') ||
        lower.contains('malam')) {
      return 'Selamat ${lower.contains('pagi')
          ? 'pagi'
          : lower.contains('siang')
          ? 'siang'
          : lower.contains('sore')
          ? 'sore'
          : 'malam'}! Semoga Anda selalu dalam keadaan aman dan sehat. Ada yang ingin didiskusikan terkait Keselamatan Kerja?';
    } else if (lower.contains('siapa kamu') ||
        lower.contains('nama kamu') ||
        lower.contains('kamu siapa')) {
      return 'Saya adalah Asisten Virtual K3 dari Safenesia! Saya bertugas membantu Anda mencari informasi pelatihan, regulasi K3, riksa uji, dan menjawab pertanyaan dasar seputar Keselamatan dan Kesehatan Kerja.';
    } else if (lower.contains('terima kasih') ||
        lower.contains('makasih') ||
        lower.contains('thanks')) {
      return 'Sama-sama! Selalu utamakan keselamatan kerja (Safety First). Jangan ragu untuk bertanya lagi jika Anda butuh bantuan.';
    }
    // K3 & DEFINITIONS
    else if (lower.contains('apa itu k3') ||
        (lower.contains('k3') && lower.contains('pengertian'))) {
      return 'K3 singkatan dari Keselamatan dan Kesehatan Kerja. Ini adalah segala kegiatan untuk menjamin dan melindungi keselamatan serta kesehatan tenaga kerja melalui upaya pencegahan kecelakaan kerja dan penyakit akibat kerja.';
    } else if (lower.contains('smk3')) {
      return 'SMK3 (Sistem Manajemen Keselamatan dan Kesehatan Kerja) adalah bagian dari sistem manajemen perusahaan secara keseluruhan dalam rangka pengendalian risiko yang berkaitan dengan kegiatan kerja.';
    } else if (lower.contains('iso 45001') || lower.contains('iso')) {
      return 'ISO 45001 adalah standar internasional untuk Sistem Manajemen K3. Safenesia menyediakan layanan konsultasi dan sertifikasi ISO 45001, ISO 9001, dan ISO 14001. Anda bisa melihatnya di menu Home -> Sertifikasi ISO.';
    }
    // APP FEATURES & HOW TO USE
    else if (lower.contains('cara daftar') ||
        lower.contains('pesan pelatihan') ||
        lower.contains('beli')) {
      return 'Untuk mendaftar pelatihan: Buka tab "Pelatihan" di bawah, pilih jadwal pelatihan yang Anda inginkan, lalu tap "Pesan Sekarang". Anda dapat membayar dengan QRIS atau Bank Transfer.';
    } else if (lower.contains('membership') ||
        lower.contains('platinum') ||
        lower.contains('kartu')) {
      return 'Kartu Membership Platinum Safenesia memberikan Anda diskon khusus dan prioritas pendaftaran. Anda dapat melihat dan mengunduh kartu Anda langsung dari menu Home!';
    }
    // CORE K3 TOPICS (APD, RIKSA UJI, KECELAKAAN, REGULASI)
    else if (lower.contains('apd') ||
        lower.contains('alat pelindung') ||
        lower.contains('helm')) {
      return 'Alat Pelindung Diri (APD) sangat esensial. Pastikan setiap pekerja memakai APD standar (Helm, Kacamata, Sepatu Safety, Sarung Tangan) yang disesuaikan dengan Analisis Keselamatan Kerja (JSA) di area masing-masing.';
    } else if (lower.contains('kecelakaan') ||
        lower.contains('insiden') ||
        lower.contains('lapor')) {
      return 'Jika terjadi insiden: 1. Amankan area, 2. Berikan P3K jika ada korban, 3. Laporkan segera ke atasan/tim HSE. Jangan mengubah lokasi kejadian sebelum investigasi awal selesai.';
    } else if (lower.contains('riksa uji') ||
        lower.contains('inspeksi') ||
        lower.contains('alat berat')) {
      return 'Semua pesawat angkat/angkut (Crane, Forklift) dan bejana tekan wajib diriksa uji berkala sesuai Permenaker No. 8 Tahun 2020. Safenesia melayani pemesanan Riksa Uji resmi dari PJK3, cek di menu Home!';
    } else if (lower.contains('regulasi') ||
        lower.contains('undang-undang') ||
        lower.contains('uu no 1')) {
      return 'Dasar hukum K3 tertinggi di Indonesia adalah UU No. 1 Tahun 1970 tentang Keselamatan Kerja. Untuk detail regulasi spesifik lainnya, Anda bisa mengeksplorasi fitur Regulasi di aplikasi kami.';
    } else if (lower.contains('p3k') || lower.contains('pertolongan pertama')) {
      return 'Sesuai Permenaker No. 15 Tahun 2008, setiap tempat kerja harus memiliki petugas P3K berlisensi dan kotak P3K yang isinya harus dicek secara berkala.';
    }
    // FALLBACK
    else {
      return 'Maaf, pertanyaan Anda terlalu spesifik atau di luar konteks database saya saat ini. Anda dapat mencoba menanyakan seputar pengertian K3, APD, pendaftaran pelatihan, riksa uji alat, atau sertifikasi ISO.';
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white.withValues(alpha: 0.2),
              radius: 16,
              child: const Icon(
                Icons.smart_toy_rounded,
                size: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Chat AI',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Text(
                  'Online - K3 Assistant',
                  style: TextStyle(fontSize: 12, color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: primaryColor,
        foregroundColor: theme.colorScheme.onPrimary,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Chat Messages Area
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.only(
                top: 16,
                left: 16,
                right: 16,
                bottom: 20,
              ),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message.isUser;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Row(
                    mainAxisAlignment: isUser
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (!isUser) ...[
                        CircleAvatar(
                          backgroundColor: primaryColor.withValues(alpha: 0.1),
                          radius: 16,
                          child: Icon(
                            Icons.smart_toy_rounded,
                            size: 18,
                            color: primaryColor,
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: isUser ? primaryColor : theme.cardColor,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(12),
                              topRight: const Radius.circular(12),
                              bottomLeft: Radius.circular(isUser ? 16 : 0),
                              bottomRight: Radius.circular(isUser ? 0 : 16),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            message.text,
                            style: GoogleFonts.inter(
                              color: isUser
                                  ? Colors.white
                                  : theme.textTheme.bodyLarge?.color,
                              fontSize: 14,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ),
                      if (isUser) const SizedBox(width: 32),
                      if (!isUser) const SizedBox(width: 32),
                    ],
                  ),
                );
              },
            ),
          ),

          // Typing Indicator
          if (_isTyping)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Row(
                children: [
                  Text(
                    'AI sedang mengetik...',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

          // Input Area
          Container(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 12,
              // Tambahkan 100px padding bottom agar tidak tertutup bottom navbar mengambang
              bottom: 12 + 100.0,
            ),
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: TextField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        hintText: 'Tanya seputar K3...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      maxLines: null,
                      textInputAction: TextInputAction.send,
                      onSubmitted: _handleSubmitted,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send_rounded, color: Colors.white),
                    onPressed: () => _handleSubmitted(_textController.text),
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
