import 'package:flutter/material.dart';
import 'package:hashplus_flutter/UI/Home_page.dart';
import 'package:hashplus_flutter/UI/Tasks.dart';
import 'package:hashplus_flutter/UI/settings.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  int _selectedIndex = 0;
  List<Widget> _pages = [
    Home_Page(),
    Tasks(), // Home page
    settings(), // Search page // Profile page
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFCFE1E2),
        title: const Text(
          "MyDay",
          style: TextStyle(
            color: Color(0xFF341F1A),
            fontWeight: FontWeight.bold,
            fontFamily: "Alexandria",
          ),
        ),
      ),

      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: const Color(0xFFCFE1E2),
        selectedItemColor: const Color(0xFF341F1A),
        unselectedItemColor: Colors.grey,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tasks'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
