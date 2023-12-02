import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' hide User;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:rental_busana/common/constants.dart';
import 'package:rental_busana/services/api_services.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:awesome_dialog/awesome_dialog.dart';
import '../models/pakaian.dart';
import '../widgets/bottom_sheet.dart';
import '../widgets/denda_dialog.dart';
import '../widgets/toast.dart';
import 'auth_services.dart';

class FirestoreServices {
  final CollectionReference rentalCollection =
      FirebaseFirestore.instance.collection('rental');

  ApiService apiService = ApiService();

  Future<void> addRental(List<Pakaian> listPakaian, int end) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('User is not signed in');
      return;
    }

    String userId = user.uid;

    DocumentReference docRef = rentalCollection.doc();
    try {
      // Mengambil data dari Firebase Auth
      String email = user.email ?? '';
      String displayName = user.displayName ?? '';
      int harga = listPakaian[0].harga * end;
      int denda = 0;

      tz.initializeTimeZones();
      final location = tz.getLocation('Asia/Jakarta');
      final now = tz.TZDateTime.now(location);
      final nextDay = now.add(Duration(days: end));
      final dateFormat = DateFormat('d MMMM yyyy');
      final startDate = dateFormat.format(now);
      final endDate = dateFormat.format(nextDay);

      await docRef.set({
        'pakaian_detail': {
          'id': listPakaian[0].id,
          'nama': listPakaian[0].nama,
          'deskripsi': listPakaian[0].deskripsi,
          'image': listPakaian[0].image,
          'kelamin': listPakaian[0].kelamin,
          'usia': listPakaian[0].usia,
          'kategori': listPakaian[0].kategori,
          'status': listPakaian[0].status,
        },
        'user_detail': {
          'userId': userId,
          'email': email,
          'name': displayName,
        },
        'start': startDate,
        'end': endDate,
        'harga': harga,
        'denda': 0,
        'kembali': '',
        'status': 'diproses',
      });
      apiService.statusDipesan(listPakaian[0].id);
      print('Transaction added successfully!');
    } catch (error) {
      print('Failed to add transaction: $error');
    }
  }

  Future<List<DocumentSnapshot>> historySelesai() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('rental')
          .where('status', isEqualTo: 'selesai')
          .get();

      List<Pakaian> pakaianList = await apiService.byId(1);

      List<DocumentSnapshot> pakaianSnapshots = querySnapshot.docs;
      return pakaianSnapshots;
    } catch (error) {
      print('Error getting data from Firestore: $error');
      return [];
    }
  }

  Future<void> cancelSewa(BuildContext context, String id) async {
    try {
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('rental').doc(id.toString());

      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection('rental')
          .doc(id.toString())
          .get();
      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        int idPakaianStr = data['pakaian_detail']['id'];
        apiService.statusTersedia(idPakaianStr);
        print("Berhasil Konfirmasi");
        await docRef.delete();
      } else {
        print('Dokumen tidak ditemukan');
      }
    } catch (error) {
      print('Error : $error');
    }
  }

  Future<void> konfirmasiSewa(BuildContext context, String id) async {
    try {
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('rental').doc(id.toString());
      await docRef.update({'status': 'disewa'});
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection('rental')
          .doc(id.toString())
          .get();
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      int idPakaianStr = data['pakaian_detail']['id'];
      apiService.statusDisewa(idPakaianStr);
      print("Berhasil Konfirmasi");
    } catch (error) {
      print('Error : $error');
    }
  }

  Future<void> selesaiSewa(BuildContext context, String id) async {
    try {
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('rental').doc(id.toString());
      await docRef.update({'status': 'selesai'});
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection('rental')
          .doc(id.toString())
          .get();
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      int idPakaianStr = data['pakaian_detail']['id'];
      apiService.statusTersedia(idPakaianStr);
      print("Berhasil Konfirmasi");
    } catch (error) {
      print('Error : $error');
    }
  }

  Future<void> cekDenda(BuildContext context, String id, int harga) async {
    try {
      int denda = 0;
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('rental').doc(id.toString());
      DocumentSnapshot docSnapshot = await docRef.get();
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;

      // Ambil tanggal mulai dan tanggal kembali dari data
      String tanggalMulaiStr = data['start'];
      String tanggalKembaliStr = data['end'];

      // Konversi tanggal mulai dan tanggal kembali ke tipe DateTime
      DateTime tanggalMulai;
      DateTime tanggalKembali;
      try {
        tanggalMulai = DateFormat('d MMMM yyyy').parse(tanggalMulaiStr);
        tanggalKembali = DateFormat('d MMMM yyyy').parse(tanggalKembaliStr);
      } catch (error) {
        throw const FormatException('Format tanggal tidak valid.');
      }

      // Ambil tanggal sekarang
      DateTime tanggalSekarang = DateTime.now();
      // Hitung selisih hari antara tanggal kembali dan tanggal sekarang
      Duration selisih = tanggalSekarang.difference(tanggalKembali);
      int selisihHari = selisih.inDays;

      // Cek apakah tanggal kembali melebihi tanggal sekarang
      if (tanggalSekarang.isAfter(tanggalKembali)) {
        // Jika tanggal kembali sudah lewat, hitung denda.
        denda = selisihHari * 5000;

        // Pastikan denda tidak negatif
        if (denda < 0) {
          denda = 0;
        }

        // Update data denda ke Firestore
        await docRef.update({'denda': denda});
        print(selisihHari);
        print("Denda telah diupdate: $denda");
        _showDendaDialog(context,
            id); // Pastikan fungsi _showDendaDialog telah diimplementasikan dengan benar di luar fungsi cekDenda.
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              backgroundColor: AppColors.chip,
              title: Text(
                'Penyewaan Selesai',
                style: TextStyle(color: AppColors.primaryColor),
              ),
              content: Text(
                'Kartu Identitas boleh diambil penyewa',
                style: TextStyle(color: AppColors.primaryColor, fontSize: 14),
              ),
            );
          },
        );
        tz.initializeTimeZones();
        final location = tz.getLocation('Asia/Jakarta');
        final now = tz.TZDateTime.now(location);
        final dateFormat = DateFormat('d MMMM yyyy');
        final kembali = dateFormat.format(now);
        denda = 0;
        // Jika belum ada denda, pastikan data denda di Firestore bernilai 0.
        await docRef.update({'status': 'selesai'});
        await docRef.update({'kembali': kembali});
        DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
            .collection('rental')
            .doc(id.toString())
            .get();
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        int idPakaianStr = data['pakaian_detail']['id'];
        apiService.statusTersedia(idPakaianStr);
      }

      print("Berhasil Konfirmasi");
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> Lunas(BuildContext context, String id) async {
    try {
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('rental').doc(id);

      await docRef.update({'status': 'selesai'});
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection('rental')
          .doc(id.toString())
          .get();
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      int idPakaianStr = data['pakaian_detail']['id'];
      apiService.statusTersedia(idPakaianStr);

      print("Pesanan Dibatalkan");
    } catch (error) {
      print('Error : $error');
    }
  }

  Future<List<Map<String, dynamic>>> getDataFromFirestore() async {
    // Mengambil koleksi "riwayat_disewa" dari Firestore
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('rental').get();

    List<Map<String, dynamic>> data = [];

    // Mengiterasi setiap dokumen dalam querySnapshot
    querySnapshot.docs.forEach((document) {
      // Mendapatkan data dari dokumen dan menambahkannya ke daftar data
      Map<String, dynamic> docData = document.data() as Map<String, dynamic>;
      data.add(docData);
    });

    return data;
  }
}

void _showDendaDialog(BuildContext context, String id) async {
  DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
      .collection('rental')
      .doc(id.toString())
      .get();
  Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
  int denda = data['denda'];
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Icon(
          Icons.warning,
          color: Colors.yellow,
          size: 48,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Pengguna ini memiliki Denda ${denda}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                  ),
                  onPressed: () async {
                    try {
                      ApiService apiService = ApiService();
                      DocumentReference docRef = FirebaseFirestore.instance
                          .collection('rental')
                          .doc(id);

                      await docRef.update({'status': 'selesai'});
                      DocumentSnapshot docSnapshot = await FirebaseFirestore
                          .instance
                          .collection('rental')
                          .doc(id.toString())
                          .get();
                      Map<String, dynamic> data =
                          docSnapshot.data() as Map<String, dynamic>;
                      int idPakaianStr = data['pakaian_detail']['id'];
                      tz.initializeTimeZones();
                      final location = tz.getLocation('Asia/Jakarta');
                      final now = tz.TZDateTime.now(location);
                      final dateFormat = DateFormat('d MMMM yyyy');
                      final kembali = dateFormat.format(now);

                      apiService.statusTersedia(idPakaianStr);
                    } catch (error) {
                      print('Error : $error');
                    }
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Sudah dibayar",
                    style: TextStyle(color: AppColors.chip),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Belum",
                    style: TextStyle(color: AppColors.chip),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
