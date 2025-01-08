import 'package:flutter/material.dart';
import 'package:myapp/chatlist.dart';
import 'register.dart';
import 'login.dart';
import 'dashboard.dart';
import 'maps.dart';
import 'histori.dart';
import 'profil.dart';
import 'settingprofil.dart';
import 'tablepeta.dart';
import 'pengaduan.dart';
import 'home.dart';
import 'splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Routes Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/splashscreen',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomePage(), // Add Home route
        '/register': (context) => const RegisterPage(),
        '/login': (context) => const LoginPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/maps': (context) => const MapsPage(),
        '/histori': (context) => const HistoriPage(),
        '/profil': (context) => const ProfilPage(),
        '/settingprofil': (context) => const SettingProfilPage(),
        '/tablepeta': (context) => const TablePetaPage(),
        '/pengaduan': (context) {
          // Navigate to PengaduanPage with chatName argument
          final chatName = 'Some Chat Name'; // Set the value of chatName here
          return PengaduanPage(chatName: chatName);
        },
        '/chatlist': (context) => const ChatlistPage(),
      },
    );
  }
}
