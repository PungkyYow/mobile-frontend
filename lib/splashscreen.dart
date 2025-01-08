import 'package:flutter/material.dart';
import 'package:myapp/login.dart';
import 'home.dart'; // Pastikan untuk mengimpor halaman home

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  // Fungsi untuk menunggu beberapa detik dan pindah ke halaman lain
  Future<void> _navigateToHome() async {
  // Menunggu selama 3 detik
  await Future.delayed(const Duration(seconds: 3));

  // Navigasi ke halaman utama setelah splash screen selesai
  if (mounted) { // Mengecek apakah widget masih berada dalam tree
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()), // Ganti dengan halaman utama
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
             image: NetworkImage('https://miro.medium.com/v2/resize:fit:624/1*_4NFJ1bhJYjer6T70FfJPA.png'),
           width: 150,  // Set the width as needed
  height: 50, // Set the height as needed
  fit: BoxFit.cover, // Ensures the image fits inside the container
),

            const SizedBox(height: 20),
            // Teks atau judul aplikasi
          ],
        ),
      ),
    );
  }
}
