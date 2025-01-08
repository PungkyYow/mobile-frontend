import 'package:flutter/material.dart';
import 'pengaduan.dart';

class ChatlistPage extends StatelessWidget {
  const ChatlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> chats = [
      {'name': 'User A', 'lastMessage': 'Halo, ada yang ingin saya laporkan.'},
      {'name': 'User B', 'lastMessage': 'Bagaimana tindak lanjut laporan saya?'},
      {'name': 'User C', 'lastMessage': 'Apakah ada pembaruan terbaru?'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Chat'),
        backgroundColor: Colors.purple,
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          return ListTile(
            title: Text(chat['name']!),
            subtitle: Text(chat['lastMessage']!),
            leading: CircleAvatar(
              child: Text(chat['name']![0]),
              backgroundColor: Colors.purple.shade100,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PengaduanPage(chatName: chat['name']!),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Peta',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.support_agent),
            label: 'Pengaduan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/maps');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/chatlist');
          } else if (index == 3) {
            Navigator.pushNamed(context, '/histori');
          } else if (index == 4) {
            Navigator.pushNamed(context, '/settingprofil');
          }
        },
      ),
    );
  }
}
