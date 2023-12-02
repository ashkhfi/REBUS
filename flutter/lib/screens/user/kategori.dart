import 'package:flutter/material.dart';
import 'package:rental_busana/common/constants.dart';

import 'kategori_detail.dart';

class Kategori extends StatelessWidget {
  Kategori({super.key});

  // List nama kategori
  final List<String> namaKategoriList = [
    "Pakaian Pengantin",
    "Pakaian Formal",
    "Pakaian Adat",
    "Pakaian Wisuda",
  ];

  // List gambar kategori
  final List<String> gambarKategoriList = [
    "assets/image/pakaian_pengantin.png",
    "assets/image/formal.png",
    "assets/image/pakaian_adat.png",
    "assets/image/baju_wisuda.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: MediaQuery.of(context).size.height / 10 - 10,
        title: const Text(
          "Kategori",
          style: TextStyle(
              color: AppColors.primaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            // header(context),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    for (int i = 0; i < namaKategoriList.length; i++)
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailKategori(namaKategoriList[i])),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Container(
                            height: MediaQuery.of(context).size.height / 3 + 50,
                            width: MediaQuery.of(context).size.width - 80,
                            decoration: BoxDecoration(
                              color: AppColors.card,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 30),
                                Image.asset(
                                  gambarKategoriList[i],
                                  scale: 1,
                                ),
                                const SizedBox(height: 20),
                                Expanded(
                                  child: Text(
                                    namaKategoriList[i],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
