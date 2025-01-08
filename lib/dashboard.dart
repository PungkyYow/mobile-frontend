import 'contanst.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;
  int totalUsers = 0;
  List<Map<String, dynamic>> datausers = [];
  List<String> roles = ['admin', 'psikolog', 'tim medis', 'tim keamanan'];

  @override
  void initState() {
    super.initState();
    _fetchUserStatistics(); // Fetch data from the API
  }

  Future<void> _fetchUserStatistics() async {
    final response =
        await http.get(Uri.parse('${ApiConstants.baseUrl}/get_dashboard'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Response Data: $data');
      setState(() {
        totalUsers = data['total_user'];

        // Populate datausers list
        datausers = List<Map<String, dynamic>>.from(data['data']).map((user) {
          return {
            'name': user['name'] ?? '',
            'role': user['role'] ?? '',
            'id': user['id'] ?? '', // Add the user id if available
          };
        }).toList();
      });
    } else {
      // Handle failure
      print('Failed to load user statistics');
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (index == 0) {
        Navigator.pushReplacementNamed(context, '/Dashboard');
      } else if (index == 1) {
        _logout();
      }
    });
  }

  // Logout
  Future<void> _logout() async {
    // Add logic to clear any session or user authentication data, e.g. remove token
    // Example using SharedPreferences or any other session management
    // await SharedPreferences.getInstance().then((prefs) => prefs.clear());

    // Redirect to the login page after logout
    Navigator.pushReplacementNamed(context, '/login');
  }

  // Edit User Data
  Future<void> _editUser(Map<String, dynamic> user) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController nameController =
            TextEditingController(text: user['name']);
        String selectedRole = user['role'];

        return AlertDialog(
          title: const Text('Edit User'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              DropdownButtonFormField<String>(
                value: selectedRole,
                items: roles.map((role) {
                  return DropdownMenuItem<String>(
                    value: role,
                    child: Text(role),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedRole = newValue!;
                  });
                },
                decoration: const InputDecoration(labelText: 'Role'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Update the user data on the server
                _updateUser(user['id'], nameController.text, selectedRole);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Update User
  Future<void> _updateUser(int userId, String name, String role) async {
    final response = await http.put(
      Uri.parse('${ApiConstants.baseUrl}/users/$userId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'role': role,
      }),
    );

    if (response.statusCode == 200) {
      // Refresh user data
      _fetchUserStatistics();
    } else {
      print('Failed to update user');
    }
  }

  // Delete User
  Future<void> _deleteUser(int userId) async {
    final response = await http.delete(
      Uri.parse('${ApiConstants.baseUrl}/users/$userId'),
    );

    if (response.statusCode == 200) {
      // Refresh user data after deletion
      _fetchUserStatistics();
    } else {
      print('Failed to delete user');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Admin'),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Color(0xFFDDD6F3)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatCard('Total Pengguna', totalUsers.toString(),
                        Icons.people, Colors.blue),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Daftar Pengguna',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: datausers.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.purple,
                            child: Text(
                              datausers[index]['name']![0],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(
                            datausers[index]['name']!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'Role: ${datausers[index]['role']}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Edit user
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  _editUser(datausers[index]);
                                },
                              ),
                              // Delete user
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  _deleteUser(datausers[index]['id']);
                                },
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
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey[600],
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
      String title, String count, IconData icon, Color color) {
    return Expanded(
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 8),
              Text(
                count,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
