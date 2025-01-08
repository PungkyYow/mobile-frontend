import 'package:flutter/material.dart';

class MapsPage extends StatelessWidget {
  const MapsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Aisee - Peta Interaktif',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFAACA8), Color(0xFFDDD6F3)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Icon(
                Icons.map_outlined,
                size: 100,
                color: Colors.purple,
              ),
              const SizedBox(height: 20),
              const Text(
                'Peta Interaktif Aisee',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.shield_outlined, color: Colors.purple, size: 30),
                  SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      'Menggunakan teknologi pemantauan waktu nyata untuk mendeteksi lokasi insiden potensial.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.auto_awesome, color: Colors.purple, size: 30),
                  SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      'Didukung AI canggih untuk memberikan informasi secara akurat dan efisien.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.place_outlined, color: Colors.purple, size: 30),
                  SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      'Menampilkan lokasi penting dengan detail terkini untuk intervensi cepat.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.purple.withOpacity(0.1),
                            child: const Icon(Icons.location_on, color: Colors.purple),
                          ),
                          title: Text('Lokasi ${index + 1}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              )),
                          subtitle: const Text(
                            'Detail informasi lokasi dan kondisi terkini.',
                            style: TextStyle(color: Colors.black54),
                          ),
                          trailing: Container(
                            decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: const Text(
                              'Lihat',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          onTap: () {
                            // Implementasi navigasi atau detail peta
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
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
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home');
              break;
            case 1:
              Navigator.pushNamed(context, '/maps');
              break;
            case 2:
              Navigator.pushNamed(context, '/chatlist');
              break;
            case 3:
              Navigator.pushNamed(context, '/histori');
              break;
            case 4:
              Navigator.pushNamed(context, '/settingprofil');
              break;
          }
        },
      ),
    );
  }
}
