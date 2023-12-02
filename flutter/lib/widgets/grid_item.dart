import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rental_busana/models/pakaian.dart';

import '../common/constants.dart';
import '../utils/format_harga.dart';

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
              onTap: () {
                Navigator.pushNamed(context, '/detail/pakaian',
                    arguments: pakaian);
              },
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
