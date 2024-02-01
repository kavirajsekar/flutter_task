import 'package:flutter/material.dart';

import 'tabs/home/home.dart';
import 'tabs/profile.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final selectedIndexProvider = StateProvider<int>((ref) => 0);

// final pageControllerProvider = Provider((ref) => PageController());

// final homePage =
//     Container(color: Colors.blue, child: Center(child: Text('Home Page')));

// final profilePage =
//     Container(color: Colors.green, child: Center(child: Text('Profile Page')));

class home_page extends StatefulWidget {
  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    home_screen(),
    profile_screen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color.fromARGB(255, 78, 42, 194),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
