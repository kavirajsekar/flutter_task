import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobileapp/loginstate/login.dart';

class profile_screen extends StatefulWidget {
  const profile_screen({super.key});

  @override
  State<profile_screen> createState() => _profile_screenState();
}

class _profile_screenState extends State<profile_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => login_screen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            CircleAvatar(
              radius: 90,
              child: Icon(
                Icons.person,
                size: 80,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'KaviRaj S',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('8608098549',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('kavisk1999@gmail.com',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Spacer(),
            Text(
              'version:0.01',
              style: TextStyle(color: Colors.grey[400]),
            )
          ],
        ),
      ),
    );
  }
}
