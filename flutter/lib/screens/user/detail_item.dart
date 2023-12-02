import 'package:flutter/material.dart';
import 'package:rental_busana/screens/user/checkout.dart';

import '../../common/constants.dart';
import '../../models/pakaian.dart';
import '../../utils/format_harga.dart';

class DetailItem extends StatelessWidget {
  final Pakaian pakaian;

  DetailItem({required this.pakaian});

  @override
  Widget build(BuildContext context) {
    String selectedDay = '1 hari';
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
          "Detail Item",
          style: TextStyle(color: AppColors.primaryColor),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 360, // Atur tinggi sesuai kebutuhan
                    child: Image.network(
                      '${Api.baseUrl}/storage/images/${pakaian.image}',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 23),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        pakaian.nama,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 23),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Rp.${PriceFormatter.formatPrice(pakaian.harga)}',
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                        decoration: const BoxDecoration(
                          color: AppColors.chip,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Text(
                          pakaian.usia,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(width: 22),
                      Container(
                        margin: const EdgeInsets.only(right: 34),
                        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                        decoration: const BoxDecoration(
                          color: AppColors.chip,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Text(
                          pakaian.kelamin,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Container(
                    height: 4,
                    color: AppColors.chip,
                  ),
                  const SizedBox(height: 15),
                  const Padding(
                    padding: EdgeInsets.only(left: 14),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Deskripsi",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14, 0, 14, 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        pakaian.deskripsi,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  // Tambahkan komponen lainnya di sini
                ],
              ),
            ),
          ),
          // Container yang tidak ikut tergulir
          Column(
            children: [
              Container(
                height: 4,
                color: AppColors.chip,
              ),
              Container(
                height: 80,
                color: Colors.white,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: 100,
                        child: const Center(
                          child: Icon(
                            color: AppColors.primaryColor,
                            size: 30,
                            Icons.arrow_back_ios,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 2,
                      color: AppColors.chip,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: 100,
                        child: const Center(
                          child: Icon(
                            color: AppColors.primaryColor,
                            size: 30,
                            Icons.message_outlined,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: FractionallySizedBox(
                        widthFactor:
                            1.0, // Sesuaikan faktor lebar sesuai kebutuhan Anda
                        heightFactor:
                            1.0, // Sesuaikan faktor tinggi sesuai kebutuhan Anda
                        child: InkWell(
                          onTap: () {
                            Pakaian pakaianData = Pakaian(
                              id: pakaian.id,
                              deskripsi: pakaian.deskripsi,
                              kategori: pakaian.kategori,
                              kelamin: pakaian.kelamin,
                              usia: pakaian.usia,
                              status: pakaian.status,
                              nama: pakaian.nama,
                              image: pakaian.image,
                              harga: pakaian.harga,
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Checkout(pakaian: pakaianData),
                              ),
                            );
                          },
                          child: Container(
                            color: AppColors.primaryColor,
                            child: const Center(
                              child: Text(
                                "Pesan Sekarang",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
