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

  void _handleSubmitted(String text) async {
    if (text.trim().isEmpty) return;
    if (_isTyping) return; // Mencegah submit beruntun

    _textController.clear();
    setState(() {
      _messages.add(
        ChatMessage(text: text, isUser: true, timestamp: DateTime.now()),
      );
      _isTyping = true;
    });

    _scrollToBottom();

    // Mock API Call untuk keperluan UI/Development
    // Siap dihubungkan ke Firebase Cloud Functions atau API backend di masa mendatang
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      
      setState(() {
        _isTyping = false;
        _messages.add(
          ChatMessage(
            text: 'Fitur respon pintar AI sedang dinonaktifkan sementara. Pesan Anda: "$text" telah diterima dan antarmuka ini siap diintegrasikan dengan backend AI Safenesia!',
            isUser: false,
            timestamp: DateTime.now(),
          ),
        );
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
    final primaryColor = theme.colorScheme.primary;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              'Asisten K3',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.auto_awesome_rounded, size: 12, color: primaryColor),
                const SizedBox(width: 4),
                Text(
                  'Didukung oleh Gemini AI',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
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
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message.isUser;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: isUser
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (!isUser) ...[
                        CircleAvatar(
                          backgroundColor: primaryColor.withValues(alpha: 0.1),
                          radius: 14,
                          child: Icon(
                            Icons.auto_awesome_rounded,
                            size: 16,
                            color: primaryColor,
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: isUser
                                ? primaryColor
                                : theme.colorScheme.onSurface.withValues(
                                    alpha: 0.06,
                                  ),
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(20),
                              topRight: const Radius.circular(20),
                              bottomLeft: Radius.circular(isUser ? 20 : 4),
                              bottomRight: Radius.circular(isUser ? 4 : 20),
                            ),
                          ),
                          child: Text(
                            message.text,
                            style: GoogleFonts.inter(
                              color: isUser
                                  ? theme.colorScheme.onPrimary
                                  : theme.colorScheme.onSurface,
                              fontSize: 15,
                              height: 1.5,
                              fontWeight: FontWeight.w400,
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
              padding: const EdgeInsets.only(left: 48, right: 24, bottom: 16),
              child: Row(
                children: [
                  Icon(
                    Icons.auto_awesome_rounded,
                    size: 14,
                    color: primaryColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Gemini sedang berpikir...',
                    style: GoogleFonts.inter(
                      color: theme.colorScheme.onSurfaceVariant,
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
              left: 16,
              right: 16,
              top: 12,
              bottom: MediaQuery.paddingOf(context).bottom + 16.0,
            ),
            decoration: BoxDecoration(color: theme.scaffoldBackgroundColor),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    style: GoogleFonts.inter(fontSize: 15),
                    decoration: InputDecoration(
                      hintText: 'Tanya seputar K3...',
                      hintStyle: GoogleFonts.inter(
                        color: theme.colorScheme.onSurfaceVariant.withValues(
                          alpha: 0.6,
                        ),
                        fontSize: 15,
                      ),
                      filled: true,
                      fillColor: theme.colorScheme.onSurface.withValues(
                        alpha: 0.04,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(
                          color: theme.colorScheme.outlineVariant.withValues(
                            alpha: 0.5,
                          ),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(
                          color: theme.colorScheme.outlineVariant.withValues(
                            alpha: 0.5,
                          ),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(
                          color: primaryColor,
                          width: 1.5,
                        ),
                      ),
                    ),
                    maxLines: 4,
                    minLines: 1,
                    textInputAction: TextInputAction.send,
                    onSubmitted: _handleSubmitted,
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
                      Icons.arrow_upward_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
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
