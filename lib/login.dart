import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'contanst.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  Future<void> _login() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    // Endpoint API login
    final Uri url = Uri.parse('${ApiConstants.baseUrl}/login');

    // Membuat request body
    final Map<String, String> body = {
      'name': username,
      'password': password,
    };

    // Kirim request POST ke API login
   try {
  final response = await http.post(url, body: body);

  if (response.statusCode == 200) {
    // Jika login berhasil, parse response
    final Map<String, dynamic> data = jsonDecode(response.body);
    if (data['success']) {
      // Simpan token atau data lainnya jika diperlukan
      final String token = data['data']['token'];
      final String role = data['data']['user']['role']; // Pastikan server mengirimkan role

      if (role == 'admin') {
        // Arahkan ke halaman dashboard admin
        Navigator.pushReplacementNamed(context, '/dashboard', arguments: token);
      } 
      else {
        // Arahkan ke halaman home
        Navigator.pushReplacementNamed(context, '/home', arguments: token);
      }
    } else {
      setState(() {
        _errorMessage = data['message'];
      });
    }
  } else {
    // Jika status code bukan 200, beri pesan kesalahan
    setState(() {
      _errorMessage = 'Failed to login. Please try again.';
    });
  }
} catch (e) {
  setState(() {
    _errorMessage = 'An error occurred: $e';
  });
}
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Color(0xFFDDD6F3)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                const Text(
                  'Welcome to\nAisee!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'At Aisee, we believe in the power of\ntechnology to save lives.',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 40),
                Center(
                  child: Icon(
                    Icons.medical_services_outlined,
                    size: 120,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 40),
                _buildTextField(
                    hintText: 'User name', icon: Icons.person, controller: _usernameController),
                const SizedBox(height: 20),
                _buildTextField(
                  hintText: 'Password',
                  icon: Icons.lock,
                  obscureText: true,
                  controller: _passwordController,
                ),
                const SizedBox(height: 40),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 100,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    onPressed: _login,
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/register');
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                if (_errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      _errorMessage,
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon, color: Colors.purple),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.purple, width: 2),
        ),
        suffixIcon: obscureText ? const Icon(Icons.visibility_off) : null,
      ),
    );
  }
}
