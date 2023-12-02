import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rental_busana/common/constants.dart';
import 'package:rental_busana/widgets/disewa_item.dart';

import '../../widgets/konfirmasi_item.dart';
import '../../widgets/selesai_item.dart';

class RentalAdmin extends StatefulWidget {
  @override
  _RentalAdminState createState() => _RentalAdminState();
}

class _RentalAdminState extends State<RentalAdmin> {
  // Buat daftar item untuk setiap tab
  List<String> konfirmasiItems = [
    'Item 1 Konfirmasi',
    'Item 2 Konfirmasi',
    'Item 3 Konfirmasi'
  ];
  List<String> disewaItems = [
    'Item 1 Disewa',
    'Item 2 Disewa',
    'Item 3 Disewa'
  ];
  List<String> selesaiItems = [
    'Item 1 Selesai',
    'Item 2 Selesai',
    'Item 3 Selesai'
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight - 60),
            child: TabBar(
              labelColor: AppColors.primaryColor,
              dividerColor: Colors.black,
              labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              indicatorColor: AppColors.primaryColor,
              tabs: [
                Tab(
                  text: "Konfirmasi",
                ),
                Tab(
                  text: "disewa",
                ),
                Tab(
                  text: "selesai",
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(50, 10, 50, 0),
                child: konfirmasi_item(context)),
            // Tampilkan list untuk tab "Disewa"
            Padding(
                padding: const EdgeInsets.fromLTRB(50, 10, 50, 0),
                child: disewa_item(context)),
            Padding(
                padding: const EdgeInsets.fromLTRB(50, 10, 50, 0),
                child: selesai_item(context)),
            // Tampilkan list untuk tab "Selesai"
          ],
        ),
      ),
    );
  }
}
