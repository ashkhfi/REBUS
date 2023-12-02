// Contoh fungsi untuk menampilkan toast dengan pesan dan durasi kustom
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void tampilkanToast(String pesan) {
  Fluttertoast.showToast(
    msg: pesan,
    toastLength: Toast
        .LENGTH_SHORT, // Durasi toast, bisa Toast.LENGTH_SHORT atau Toast.LENGTH_LONG
    gravity: ToastGravity
        .BOTTOM, // Posisi toast di layar, bisa BOTTOM, CENTER, atau TOP
    timeInSecForIosWeb:
        1, // Durasi toast untuk platform iOS dan web (dalam detik)
    backgroundColor: Colors.black45, // Warna latar belakang toast
    textColor: Colors.white, // Warna teks toast
    fontSize: 16.0, // Ukuran teks toast
  );
}

// Contoh penggunaan fungsi tampilkanToast

