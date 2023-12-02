import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rental_busana/common/constants.dart';
import 'package:rental_busana/screens/user/detail_history_selesai.dart';

import '../screens/user/detail_history_disewa.dart';

Widget listRiwayatSelesai(BuildContext context) {
  User? user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    if (kDebugMode) {
      print('User is not signed in');
    }
    return Container();
  }

  String userId = user.uid;

  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('rental')
        .where('user_detail.userId', isEqualTo: userId)
        .where('status', isEqualTo: 'selesai')
        .snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // Menampilkan indikator loading jika data masih diambil
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        // Menampilkan pesan error jika terjadi kesalahan
        return Text('Failed to fetch data: ${snapshot.error}');
      } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
        // Menampilkan pesan jika data kosong
        return const Text('No data available');
      } else {
        // Menampilkan data menggunakan ListView.builder
        return Expanded(
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot document = snapshot.data!.docs[index];
              Map<String, dynamic> rentalData =
                  document.data() as Map<String, dynamic>;

              String end = rentalData['end'] ?? '';
              String start = rentalData['start'] ?? '';
              String kembali = rentalData['kembali'] ?? '';
              int harga = rentalData['harga'] ?? '';
              int denda = rentalData['denda'] ?? '';
              String image = rentalData['pakaian_detail']['image'] ?? '';
              String pakaian = rentalData['pakaian_detail']['nama'] ?? '';
              String usia = rentalData['pakaian_detail']['usia'] ?? '';
              String kelamin = rentalData['pakaian_detail']['kelamin'] ?? '';
              String kategori = rentalData['pakaian_detail']['kategori'] ?? '';

              return GestureDetector(
                onTap: () {
                  navigateToDetailSelesai(
                    context,
                    image,
                    pakaian,
                    kategori,
                    usia,
                    kelamin,
                    start,
                    end,
                    kembali,
                    harga,
                    denda,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: AppColors.chip,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: MediaQuery.of(context).size.height / 9,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 80,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              '${Api.baseUrl}/storage/images/$image',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                  pakaian,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Text(
                                      "kembali",
                                      style: TextStyle(
                                          color: AppColors.primaryColor),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 5),
                                      padding: const EdgeInsets.fromLTRB(
                                        8,
                                        4,
                                        8,
                                        4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            kembali,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: AppColors.chip,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }
    },
  );
}

// Fungsi untuk membuat dan mengarahkan ke halaman DetailDisewa
void navigateToDetailSelesai(
  BuildContext context,
  String image,
  String nama,
  String kategori,
  String umur,
  String jenis_kelamin,
  String mulai,
  String berakhir,
  String kembali,
  int biaya,
  int denda,
) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DetailSelesai(
        image: image,
        nama: nama,
        kategori: kategori,
        umur: umur,
        jenis_kelamin: jenis_kelamin,
        mulai: mulai,
        kembali: kembali,
        end: berakhir,
        biaya: biaya,
        denda: denda,
      ),
    ),
  );
}
