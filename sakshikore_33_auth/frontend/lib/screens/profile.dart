import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'login.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? user;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() async {
    final u = await AuthService.getUser();
    setState(() => user = u);
  }

  void handleLogout() async {
    await AuthService.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCF5EE),
      body: user == null
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Card(
                margin: EdgeInsets.all(30),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Profile",
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFFEE6983)),
                      ),
                      SizedBox(height: 20),
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text("Name"),
                        subtitle: Text(user!['name'] ?? ""),
                      ),
                      ListTile(
                        leading: Icon(Icons.account_circle),
                        title: Text("Username"),
                        subtitle: Text(user!['username'] ?? ""),
                      ),
                      ListTile(
                        leading: Icon(Icons.email),
                        title: Text("Email"),
                        subtitle: Text(user!['email'] ?? ""),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: handleLogout,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                        child: Text("Logout"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
