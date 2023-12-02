import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rental_busana/widgets/toast.dart';

import '../../common/constants.dart';
import '../../models/pakaian.dart';
import '../../utils/format_harga.dart';

class CostumeAdmin extends StatefulWidget {
  const CostumeAdmin({super.key});

  @override
  State<CostumeAdmin> createState() => _CostumeAdminState();
}

class _CostumeAdminState extends State<CostumeAdmin> {
  final Dio dio = Dio();
  List<Pakaian>? pakaianList = [];
  bool isRefreshing = false;
  bool isLoading = false;
  String statusText = "tersedia";

  Color chipBackgroundColor(String chipLabel) {
    return statusText == chipLabel ? AppColors.primaryColor : Colors.white;
  }

  Color chipTextColor(String chipLabel) {
    return statusText == chipLabel ? Colors.white : AppColors.primaryColor;
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
            .where((pakaian) => pakaian.status == statusText)
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: Text(
                    'Tersedia',
                    style: TextStyle(
                      color: chipTextColor('tersedia'),
                    ),
                  ),
                  selected: statusText == 'tersedia',
                  onSelected: (isSelected) {
                    fetchPakaianList();
                    setState(() {
                      statusText = 'tersedia';
                    });
                  },
                  selectedColor: chipBackgroundColor('tersedia'),
                ),
                const SizedBox(width: 10),
                ChoiceChip(
                  label: Text(
                    'Disewa',
                    style: TextStyle(
                      color: chipTextColor('disewa'),
                    ),
                  ),
                  selected: statusText == 'disewa',
                  onSelected: (isSelected) {
                    fetchPakaianList();
                    setState(() {
                      statusText = 'disewa';
                    });
                  },
                  selectedColor: chipBackgroundColor('disewa'),
                ),
                const SizedBox(width: 10),
                ChoiceChip(
                  label: Text(
                    'Dipesan',
                    style: TextStyle(
                      color: chipTextColor('dipesan'),
                    ),
                  ),
                  selected: statusText == 'dipesan',
                  onSelected: (isSelected) {
                    fetchPakaianList();
                    setState(() {
                      statusText = 'dipesan';
                    });
                  },
                  selectedColor: chipBackgroundColor('dipesan'),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
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
    );
  }
}

Widget gridItem(List<Pakaian> items) {
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      final itemWidth = constraints.maxWidth / 2;
      const itemHeight = 300.0;

      return Padding(
        padding: const EdgeInsets.fromLTRB(26, 0, 26, 0),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: itemWidth / itemHeight,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            Pakaian pakaian = items[index];
            return GestureDetector(
              onTap: () {},
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: AppColors.primaryColor),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.card,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 6 + 10,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(20)),
                          child: CachedNetworkImage(
                            imageUrl:
                                '${Api.baseUrl}/storage/images/${pakaian.image}',
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            width: itemWidth,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          const SizedBox(height: 3),
                          AutoSizeText(
                            pakaian.nama,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                'Rp. ${PriceFormatter.formatPrice(pakaian.harga)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 20),
                                padding: const EdgeInsets.fromLTRB(4, 2, 3, 4),
                                decoration: BoxDecoration(
                                  color: AppColors.chip,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  pakaian.usia,
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                padding: const EdgeInsets.fromLTRB(4, 2, 3, 4),
                                decoration: BoxDecoration(
                                  color: AppColors.chip,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  pakaian.kelamin,
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                              height:
                                  8), // Tambahkan jarak sebelum menampilkan label status
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
