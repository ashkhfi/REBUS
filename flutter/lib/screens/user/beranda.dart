import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rental_busana/common/constants.dart';
import 'package:rental_busana/widgets/grid_item.dart';

import '../../models/pakaian.dart';
import '../../widgets/corousel_beranda.dart';
import '../../widgets/dialog_rental.dart';
import '../../widgets/header.dart';

class Beranda extends StatefulWidget {
  const Beranda({super.key});

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  final Dio dio = Dio();
  List<Pakaian>? pakaianList = [];

  bool isLoading = false;
  bool isRefreshing = false;

  Future<void> _refreshData() async {
    if (!isRefreshing) {
      // Tambahkan kondisi untuk menghindari multiple refresh secara bersamaan
      setState(() {
        isRefreshing =
            true; // Set isRefreshing menjadi true saat proses refresh dimulai
      });

      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        fetchPakaianList();
      });
    }
  }

  void fetchPakaianList() async {
    setState(() {
      isLoading = true;
      isRefreshing = false;
    });

    try {
      Dio dio = Dio();
      Response response = await dio.get(Api.url);
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        pakaianList = data
            .map((item) => Pakaian.fromJson(item))
            .where((pakaian) => pakaian.status == 'tersedia')
            .toList();
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchPakaianList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        splashColor: AppColors.chip,
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          _refreshData(); // Panggil method _refreshData ketika tombol ditekan
        },
        child: isRefreshing
            ? const CircularProgressIndicator(
                color: Colors.white,
              ) // Tampilkan CircularProgressIndicator jika sedang refreshing
            : const Icon(Icons.refresh),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  header(context),
                  corousel(context),
                  const Text(
                    "Produk Kami",
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 40,
                        fontWeight: FontWeight.w800),
                  ),
                  pakaianList!.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text("Tidak ada data tersedia "),
                        )
                      : gridItem(pakaianList!),
                ],
              ),
            ),
    );
  }
}
