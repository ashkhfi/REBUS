import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rental_busana/screens/admin/costume_admin.dart';
import 'package:rental_busana/screens/admin/rental_admin.dart';
import 'package:rental_busana/screens/admin/users_admin.dart';

import '../../common/constants.dart';
import '../chat/rooms.dart';

class HomeAdmin extends StatefulWidget {
  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  String _appBarTitle = 'Katalog';
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Mengubah judul pada app bar sesuai dengan item yang diklik
    if (_selectedIndex == 0) {
      _appBarTitle = 'Katalog';
    } else if (_selectedIndex == 1) {
      _appBarTitle = 'Rental';
    } else if (_selectedIndex == 2) {
      _appBarTitle = 'User';
    }
  }

  Widget _getBodyWidget() {
    switch (_selectedIndex) {
      case 0:
        return const CostumeAdmin(); // Ganti dengan halaman Home yang sesuai
      case 1:
        return RentalAdmin(); // Ganti dengan halaman Business yang sesuai
      case 2:
        return const RoomsPage(); // Ganti dengan halaman School yang sesuai
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          _appBarTitle,
          textAlign: TextAlign.right,
          style: const TextStyle(
            fontSize: 30,
            color: AppColors.primaryColor,
          ),
        ),
        toolbarHeight: 70,
        leadingWidth: 100,
        iconTheme: const IconThemeData(
          color: AppColors.primaryColor,
          size: 40,
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          const CostumeAdmin(), // Ganti dengan halaman default yang sesuai (misalnya Home)
          RentalAdmin(), // Ganti dengan halaman default yang sesuai (misalnya Business)
          const RoomsPage(), // Ganti dengan halaman default yang sesuai (misalnya School)
        ],
      ),
      drawer: Drawer(
        width: 300,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Text(
                      "Halo admin sayang",
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.black26, fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 2,
                    color: Colors.black12,
                  ),
                  ListTile(
                    title: const Text(
                      'Katalog',
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                    selected: _selectedIndex == 0,
                    onTap: () {
                      _onItemTapped(0);
                      Navigator.pop(context);
                    },
                  ),
                  Container(
                    height: 2,
                    color: Colors.black12,
                  ),
                  ListTile(
                    title: const Text(
                      'Rental',
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                    selected: _selectedIndex == 1,
                    onTap: () {
                      _onItemTapped(1);
                      Navigator.pop(context);
                    },
                  ),
                  Container(
                    height: 2,
                    color: Colors.black12,
                  ),
                  ListTile(
                    title: const Text('User',
                        style: TextStyle(fontSize: 18, color: Colors.black54)),
                    selected: _selectedIndex == 2,
                    onTap: () {
                      _onItemTapped(2);
                      Navigator.pop(context);
                    },
                  ),
                  Container(
                    height: 2,
                    color: Colors.black12,
                  ),
                ],
              ),
            ),
            Container(
                height: 40,
                width: double.infinity,
                color: Colors.black12,
                child: TextButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text("Logout"),
                )),
          ],
        ),
      ),
    );
  }
}
