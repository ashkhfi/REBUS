import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rental_busana/common/constants.dart';
import 'package:rental_busana/widgets/header.dart';
import 'package:rental_busana/widgets/list_riwayat_selesai.dart';

import '../../widgets/list_riwayat_disewa.dart';
import 'detail_history_disewa.dart';

class Riwayat extends StatefulWidget {
  @override
  _RiwayatState createState() => _RiwayatState();
}

class _RiwayatState extends State<Riwayat> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Color> _containerColors = [
    AppColors.primaryColor, // Warna kontainer tab pertama
    AppColors.chip, // Warna kontainer tab kedua
  ];
  List<Color> _textColors = [
    AppColors.chip, // Warna teks tab pertama saat dipilih
    AppColors.primaryColor, // Warna teks tab kedua saat dipilih
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(_onTabChanged);
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    setState(() {
      // Mengatur warna kontainer dan teks berdasarkan indeks tab yang aktif
      _containerColors = List.generate(
        2,
        (index) => index == _tabController.index
            ? AppColors.primaryColor
            : AppColors.chip,
      );
      _textColors = List.generate(
        2,
        (index) => index == _tabController.index
            ? AppColors.chip
            : AppColors.primaryColor,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight - 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Riwayat",
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),

              // Container(
              //   height: 1,
              //   color: Colors.grey,
              // ),
              SizedBox(
                height: 10,
              ),
              TabBar(
                tabAlignment: TabAlignment.fill,
                indicatorColor: AppColors.primaryColor,
                controller: _tabController,
                tabs: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
                    decoration: BoxDecoration(
                      color: _containerColors[
                          0], // Menggunakan nilai warna kontainer untuk tab pertama
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      "Sedang disewa",
                      style: TextStyle(
                        fontSize: 14,
                        color: _textColors[
                            0], // Menggunakan nilai warna teks untuk tab pertama
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    padding: const EdgeInsets.fromLTRB(40, 6, 40, 6),
                    decoration: BoxDecoration(
                      color: _containerColors[
                          1], // Menggunakan nilai warna kontainer untuk tab kedua
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      "Selesai",
                      style: TextStyle(
                        fontSize: 14,
                        color: _textColors[
                            1], // Menggunakan nilai warna teks untuk tab kedua
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        physics: BouncingScrollPhysics(),
        controller: _tabController,
        children: [
          // Content for Tab 1
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              listRiwayatDisewa(context)
            ],
          ),
          // Content for Tab 2
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              listRiwayatSelesai(context)
            ],
          ),
        ],
      ),
    );
  }
}

// Fungsi untuk membuat dan mengarahkan ke halaman DetailDisewa
