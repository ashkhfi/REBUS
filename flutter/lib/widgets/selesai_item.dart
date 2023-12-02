import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rental_busana/common/constants.dart';
import '../services/firestore_services.dart';

import '../utils/format_harga.dart';

Widget selesai_item(BuildContext context) {
  FirestoreServices firestoreservices = FirestoreServices();
  return StreamBuilder<QuerySnapshot>(
    // Menggunakan StreamBuilder untuk mendapatkan realtime updates dari Firestore
    stream: FirebaseFirestore.instance
        .collection('rental')
        .where('status', isEqualTo: 'selesai')
        .snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator(); // Tampilkan loading jika data sedang dimuat
      }
      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      }
      if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
        return Center(
            child: const Text('Tidak ada data dengan status disewa.'));
      }

      // Menggunakan ListView untuk menampilkan banyak data
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: snapshot.data!.docs.length,
        itemBuilder: (BuildContext context, int index) {
          DocumentSnapshot document = snapshot.data!.docs[index];
          Map<String, dynamic> rentalData =
              document.data() as Map<String, dynamic>;

          String endRental = rentalData['end'] ?? '';
          String startRental = rentalData['start'] ?? '';
          int harga = rentalData['harga'] ?? '';
          String image = rentalData['pakaian_detail']['image'] ?? '';
          String namaPakaian = rentalData['pakaian_detail']['nama'] ?? '';
          String namaUser = rentalData['user_detail']['name'] ?? '';
          String kembali = rentalData['kembali'] ?? '';
          int denda = rentalData['denda'] ?? '';
          return Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            margin: const EdgeInsets.only(bottom: 10),
            height: MediaQuery.of(context).size.height / 4 + 25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.chip,
            ),
            child: Column(
              children: [
                Text(
                  namaUser,
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  height: 2,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          '${Api.baseUrl}/storage/images/$image',
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.height / 8 + 25,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            namaPakaian,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          const Text(
                            "dari",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            startRental,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            "sampai",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            endRental,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            "kembali",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            kembali,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    AutoSizeText(
                      'Rp. ${PriceFormatter.formatPrice(harga)}',
                      style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    const SizedBox(width: 20),
                    AutoSizeText(
                      (denda == 0)
                          ? 'Tidak ada denda'
                          : 'Rp. ${PriceFormatter.formatPrice(denda)}',
                      style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
