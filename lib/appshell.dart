import 'package:app/pages/account.dart';
import 'package:app/pages/dashboard.dart';
import 'package:app/pages/home.dart';
import 'package:flutter/material.dart';

class AppshellPage extends StatefulWidget {
  _AppshellPageState createState() => _AppshellPageState();
}

class _AppshellPageState extends State<AppshellPage> {
  List<Widget> pages = [
    HomePage(),
    AccountPage()
  ];

  int _selectedIndex = 0;

  void _handleNavigation(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(

      // Body Section
      body: pages[_selectedIndex],

      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Settings'
          )
        ],
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blueAccent,
        currentIndex: _selectedIndex,
        onTap: _handleNavigation,
      ),

      // Float Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardPage())),
        child: Icon(Icons.dashboard, color: Colors.white),
        backgroundColor: Colors.blueAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}