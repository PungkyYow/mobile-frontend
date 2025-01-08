import 'package:flutter/material.dart';

class PengaduanPage extends StatefulWidget {
  final String chatName; // Tambahkan parameter
  const PengaduanPage({super.key, required this.chatName});

  @override
  _PengaduanPageState createState() => _PengaduanPageState();
}

class _PengaduanPageState extends State<PengaduanPage> {
  final List<Map<String, String>> _messages = [
    {'sender': 'Pengguna', 'message': 'Halo, saya ingin melaporkan sesuatu yang mencurigakan di area saya.'},
    {'sender': 'Admin', 'message': 'Terima kasih atas laporan Anda. Kami akan segera menindaklanjuti.'},
  ];

  final TextEditingController _messageController = TextEditingController();

  void _sendMessage(String message) {
    if (message.trim().isEmpty) return;

    setState(() {
      _messages.add({'sender': 'Pengguna', 'message': message});
      _messages.add({'sender': 'Admin', 'message': 'AAMIIN'});
    });

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaduan: ${widget.chatName}'), // Gunakan parameter
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final isUser = _messages[index]['sender'] == 'Pengguna';

                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.purple.shade100 : Colors.purple.shade50,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(12),
                        topRight: const Radius.circular(12),
                        bottomLeft: Radius.circular(isUser ? 12 : 0),
                        bottomRight: Radius.circular(isUser ? 0 : 12),
                      ),
                    ),
                    child: Text(
                      _messages[index]['message']!,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.purple.shade50,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Ketik pesan...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _sendMessage(_messageController.text),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(12),
                  ),
                  child: const Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
