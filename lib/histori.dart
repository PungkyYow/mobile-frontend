import 'package:flutter/material.dart';

class HistoriPage extends StatelessWidget {
  const HistoriPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Histori Perilaku Mencurigakan',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.purple,
        centerTitle: true,
        elevation: 10,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Penjelasan Fitur di atas
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Penjelasan Notifikasi:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.circle, color: Colors.green, size: 16),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'Hijau: Tidak ada tindakan mencurigakan terdeteksi. Situasi aman.',
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.circle, color: Colors.yellow, size: 16),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'Kuning: Tindakan mencurigakan terdeteksi. Perlu perhatian lebih.',
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.circle, color: Colors.red, size: 16),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'Merah: Tindakan berbahaya terdeteksi. Segera tindak lanjut.',
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          // List view for items
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 5,
              itemBuilder: (context, index) {
                final itemNumber = index + 1;
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 5,
                  shadowColor: Colors.deepPurpleAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            'https://akcdn.detik.net.id/community/media/visual/2024/10/21/bobby-kertanegara_169.png?w=700&q=90',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Judul Perilaku $itemNumber',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.place, color: Colors.deepPurple),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Alamat CCTV: Jalan Contoh No.$itemNumber',
                                      style: const TextStyle(fontSize: 14, color: Colors.black54),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.calendar_today, color: Colors.deepPurple),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Tanggal: 2023-12-$itemNumber',
                                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.access_time, color: Colors.deepPurple),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Waktu: 14:00:0$index',
                                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  // Logika navigasi ke tampilan CCTV
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  'Lihat CCTV',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
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

  Widget _buildSignalCard({required Color color, required String title, required String description}) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            Icons.circle,
            color: color,
            size: 40,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
