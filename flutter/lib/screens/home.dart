import 'package:flutter/material.dart';
import '../widgets/bottom_navbar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Halaman Utama'),
      ),
      body: const Center(
        child: Text('Konten halaman utama'),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
