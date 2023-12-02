import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../common/constants.dart';
import '../../models/pakaian.dart';
import '../../widgets/grid_item.dart';
import '../../widgets/header.dart';

class DetailKategori extends StatefulWidget {
  final String kategori;
  DetailKategori(this.kategori);

  @override
  State<DetailKategori> createState() => _DetailKategoriState();
}

class _DetailKategoriState extends State<DetailKategori> {
  final Dio dio = Dio();
  List<Pakaian>? pakaianList = [];

  bool isLoading = false;

  void fetchPakaianList() async {
    setState(() {
      isLoading = true;
    });

    try {
      Dio dio = Dio();
      Response response = await dio.get(Api.url);
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        pakaianList = data
            .map((item) => Pakaian.fromJson(item))
            .where((pakaian) =>
                pakaian.kategori ==
                widget.kategori) // Filter berdasarkan status 'tersedia'
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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.primaryColor,
          ),
        ),
        backgroundColor: Colors.white,
        toolbarHeight: MediaQuery.of(context).size.height / 10 - 10,
        title: Text(
          "Detail Kategori",
          style: TextStyle(color: AppColors.primaryColor),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.kategori,
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 30,
                          fontWeight: FontWeight.w800),
                    ),
                    pakaianList!.isEmpty
                        ? Padding(
                            padding: EdgeInsets.only(top: 200),
                            child: Text(
                              "Tidak ada data dikategori ${widget.kategori} ",
                              style: TextStyle(
                                  fontSize: 20, color: AppColors.primaryColor),
                            ),
                          )
                        : gridItem(pakaianList!),
                  ],
                ),
              ),
            ),
    );
  }
}
