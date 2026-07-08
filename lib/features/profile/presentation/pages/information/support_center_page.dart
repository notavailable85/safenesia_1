import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// ==========================================
// SUB-HALAMAN KONTAINER 3
// ==========================================

// 3.B. PUSAT BANTUAN (LIVE CHAT DUMMY)
class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({super.key});
  @override
  State<HelpCenterPage> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  final _chatCtrl = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  final List<Map<String, dynamic>> messages = [
    {
      'isBot': true,
      'text': 'Halo! Saya Customer Support Safenesia. Ada yang bisa saya bantu terkait layanan kami hari ini?',
      'time': DateTime.now().subtract(const Duration(minutes: 5)),
    },
  ];

  bool _isTyping = false;

  void _sendMessage() {
    if (_chatCtrl.text.trim().isEmpty) return;
    String userText = _chatCtrl.text.trim();

    setState(() {
      messages.add({
        'isBot': false, 
        'text': userText,
        'time': DateTime.now(),
      });
      _chatCtrl.clear();
      _isTyping = true;
    });
    
    _scrollToBottom();

    // Simulasi Balasan Chatbot
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      setState(() {
        _isTyping = false;
        messages.add({
          'isBot': true,
          'text': 'Terima kasih atas pesan Anda. Agen kami akan segera membalas atau Anda bisa membaca artikel FAQ kami.',
          'time': DateTime.now(),
        });
      });
      _scrollToBottom();
    });
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
    final colorScheme = theme.colorScheme;
    final primaryColor = colorScheme.primary;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  backgroundColor: primaryColor.withValues(alpha: 0.1),
                  radius: 20,
                  child: Icon(Icons.support_agent_rounded, color: primaryColor),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.greenAccent.shade400,
                      shape: BoxShape.circle,
                      border: Border.all(color: theme.scaffoldBackgroundColor, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Customer Support',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: colorScheme.onSurface,
                  ),
                ),
                Text(
                  'Online',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Colors.greenAccent.shade400,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert_rounded),
            onPressed: () {},
          ),
        ],
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
                bottom: 24,
              ),
              itemCount: messages.length,
              itemBuilder: (context, i) {
                bool isBot = messages[i]['isBot'];
                String text = messages[i]['text'];
                DateTime time = messages[i]['time'];
                String formattedTime = DateFormat('HH:mm').format(time);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    mainAxisAlignment: isBot
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (isBot) ...[
                        CircleAvatar(
                          backgroundColor: primaryColor.withValues(alpha: 0.1),
                          radius: 14,
                          child: Icon(
                            Icons.support_agent_rounded,
                            size: 16,
                            color: primaryColor,
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      Flexible(
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.75,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: isBot
                                ? colorScheme.onSurface.withValues(alpha: 0.06)
                                : primaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(20),
                              topRight: const Radius.circular(20),
                              bottomLeft: Radius.circular(isBot ? 4 : 20),
                              bottomRight: Radius.circular(isBot ? 20 : 4),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                text,
                                style: GoogleFonts.inter(
                                  color: isBot
                                      ? colorScheme.onSurface
                                      : colorScheme.onPrimary,
                                  fontSize: 15,
                                  height: 1.4,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    formattedTime,
                                    style: GoogleFonts.inter(
                                      color: isBot
                                          ? colorScheme.onSurfaceVariant.withValues(alpha: 0.7)
                                          : colorScheme.onPrimary.withValues(alpha: 0.7),
                                      fontSize: 11,
                                    ),
                                  ),
                                  if (!isBot) ...[
                                    const SizedBox(width: 4),
                                    Icon(
                                      Icons.done_all_rounded,
                                      size: 14,
                                      color: colorScheme.onPrimary.withValues(alpha: 0.9),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          
          // Typing Indicator
          if (_isTyping)
            Padding(
              padding: const EdgeInsets.only(left: 48, right: 24, bottom: 16),
              child: Row(
                children: [
                  Text(
                    'Support sedang mengetik...',
                    style: GoogleFonts.inter(
                      color: colorScheme.onSurfaceVariant,
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

          // Input Area
          Container(
            padding: EdgeInsets.only(
              left: 12,
              right: 12,
              top: 12,
              bottom: MediaQuery.paddingOf(context).bottom + 16.0,
            ),
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withValues(alpha: 0.05),
                  offset: const Offset(0, -4),
                  blurRadius: 16,
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.add_circle_outline_rounded, color: colorScheme.onSurfaceVariant),
                  onPressed: () {},
                ),
                Expanded(
                  child: TextField(
                    controller: _chatCtrl,
                    style: GoogleFonts.inter(fontSize: 15),
                    decoration: InputDecoration(
                      hintText: 'Ketik pesan...',
                      hintStyle: GoogleFonts.inter(
                        color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                        fontSize: 15,
                      ),
                      filled: true,
                      fillColor: colorScheme.onSurface.withValues(alpha: 0.04),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(
                          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(
                          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(
                          color: primaryColor,
                          width: 1.5,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                    ),
                    maxLines: 4,
                    minLines: 1,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  margin: const EdgeInsets.only(bottom: 2),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    padding: const EdgeInsets.all(12),
                    icon: const Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: _sendMessage,
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
