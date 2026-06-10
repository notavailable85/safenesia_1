import 'package:flutter/material.dart';

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
  final List<Map<String, dynamic>> messages = [
    {
      'isBot': true,
      'text':
          'Halo! Saya asisten virtual Anda. Ada yang bisa saya bantu terkait layanan kami?',
    },
  ];

  void _sendMessage() {
    if (_chatCtrl.text.isEmpty) return;
    String userText = _chatCtrl.text;

    setState(() {
      messages.add({'isBot': false, 'text': userText});
      _chatCtrl.clear();
    });

    // Simulasi Balasan Chatbot
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        messages.add({
          'isBot': true,
          'text':
              'Terima kasih atas pesan Anda. Agen kami akan segera membalas atau Anda bisa membaca artikel FAQ kami.',
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Live Chat Bantuan')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, i) {
                bool isBot = messages[i]['isBot'];
                return Align(
                  alignment: isBot
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isBot
                          ? Colors.grey.shade200
                          : Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(messages[i]['text']),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _chatCtrl,
                    decoration: const InputDecoration(
                      hintText: 'Ketik pesan...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
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
