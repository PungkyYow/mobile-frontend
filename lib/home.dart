import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'contanst.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aisee App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
  
  const HomePage({super.key});

  // Implementasi createState untuk HomePage
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
   String token = '';
    @override
  void initState() {
    super.initState();
    _loadToken();// Panggil fungsi pengecekan login saat halaman dimuat
  }
  // Fungsi untuk mengambil token dari SharedPreferences
  Future<void> _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token') ?? ''; // Ambil token dari SharedPreferences
    });
    // Panggil fungsi pengecekan login setelah token berhasil dimuat
    if (token.isNotEmpty) {
      _checkLogin(context); // Panggil _checkLogin dengan context setelah token tersedia
    }
  }
  // Fungsi untuk melakukan pengecekan login
    Future<void> _checkLogin(BuildContext context) async {

    final response = await http.get(
      Uri.parse(
          '${ApiConstants.baseUrl}/check-login'), // Ganti dengan URL API yang sesuai
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Jika response 200, artinya pengguna sudah login
      print("User is logged in: ${jsonDecode(response.body)}");
      // Tidak ada aksi lain jika berhasil
    } else if (response.statusCode == 500) {
      // Jika response 500, arahkan pengguna ke halaman login
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      // Tangani status code lain jika diperlukan
      print("Failed to check login: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Aisee Home',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildHeaderSection(),
            const SizedBox(height: 30),
            _buildPartnerSection(),
            const SizedBox(height: 30),
            _buildFeaturesSection(),
            const SizedBox(height: 30),
            _buildAboutAiseeSection(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  // Bottom Navigation Bar
  BottomNavigationBar _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
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
        // Handle navigation based on index
        switch (index) {
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
          default:
            break;
        }
      },
    );
  }

  // Header Section
  Widget _buildHeaderSection() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Colors.deepPurple, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: const Icon(
            Icons.health_and_safety,
            size: 80,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Kami percaya pada kekuatan teknologi untuk menyelamatkan nyawa.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  // Partner Section
  Widget _buildPartnerSection() {
    final List<String> partnerImages = [
      'https://miro.medium.com/v2/resize:fit:624/1*_4NFJ1bhJYjer6T70FfJPA.png',
      'https://miro.medium.com/v2/resize:fit:624/1*_4NFJ1bhJYjer6T70FfJPA.png',
      'https://miro.medium.com/v2/resize:fit:624/1*_4NFJ1bhJYjer6T70FfJPA.png',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Partner Kami',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:
              partnerImages.map((url) => _buildPartnerImage(url)).toList(),
        ),
      ],
    );
  }

  // Widget for Partner Image
  Widget _buildPartnerImage(String imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Image.network(
        imageUrl,
        height: 120,
        width: 120,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      (loadingProgress.expectedTotalBytes ?? 1)
                  : null,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[300],
            height: 120,
            width: 120,
            child: const Icon(
              Icons.broken_image,
              color: Colors.red,
              size: 50,
            ),
          );
        },
      ),
    );
  }

  // Features Section
  Widget _buildFeaturesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Fitur Aisee',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        const SizedBox(height: 10),
        const FeatureItem(
          icon: Icons.security,
          title: 'Keamanan Real-Time',
          description:
              'Pemantauan melalui CCTV dan AI untuk mendeteksi potensi bahaya secara langsung.',
        ),
        const FeatureItem(
          icon: Icons.phone_in_talk,
          title: 'Intervensi Cepat',
          description:
              'Notifikasi langsung kepada petugas terkait untuk intervensi segera.',
        ),
        const FeatureItem(
          icon: Icons.analytics,
          title: 'Analisis Data',
          description:
              'Pemanfaatan data untuk menganalisis dan mencegah kejadian serupa di masa depan.',
        ),
      ],
    );
  }

  // About Aisee Section
  Widget _buildAboutAiseeSection() {
    return Column(
      children: [
        const Text(
          'Tentang Aisee',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Aisee adalah platform yang bertujuan untuk meningkatkan keselamatan dan kesehatan masyarakat melalui teknologi pemantauan dan analisis canggih. Sistem kami menggabungkan CCTV, AI, dan pemantauan waktu nyata untuk mendeteksi potensi bahaya dan melakukan intervensi segera jika diperlukan.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      ],
    );
  }
}

// Widget for Feature Item
class FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 5,
      child: ListTile(
        leading: Icon(
          icon,
          size: 40,
          color: Colors.deepPurple,
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(description),
      ),
    );
  }
}
