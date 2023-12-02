import 'package:flutter/material.dart';
import 'package:rental_busana/common/constants.dart';
import 'package:rental_busana/screens/user/beranda.dart';
import 'package:rental_busana/screens/user/riwayat.dart';

import '../screens/user/kategori.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  _BottomNavigationExampleState createState() =>
      _BottomNavigationExampleState();
}

class _BottomNavigationExampleState extends State {
  int _selectedTab = 0;

  final List _pages = [const Beranda(), Kategori(), Riwayat()];

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) => _changeTab(index),
        backgroundColor: AppColors.primaryColor,
        selectedItemColor:
            AppColors.card, // Ubah warna ikon dan label item yang aktif di sini
        unselectedItemColor: AppColors
            .chip, // Ubah warna ikon dan label item yang tidak aktif di sini
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Kategori",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "Riwayat",
          ),
        ],
        // Ubah gaya teks untuk label item yang aktif di sini
        // Misalnya, untuk mengubah ukuran teks menjadi 12 dan menggunakan font bold:
        // labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}
