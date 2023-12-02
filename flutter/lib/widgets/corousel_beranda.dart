import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

CarouselSlider corousel(BuildContext context) {
  return CarouselSlider(
    options: CarouselOptions(
      height: 360, // Tinggi carousel
      autoPlay: true, // Otomatis putar
      enlargeCenterPage: true, // Perbesar halaman tengah
      aspectRatio: 16 / 9, // Rasio aspek gambar
      autoPlayCurve: Curves.fastOutSlowIn, // Animasi perpindahan halaman
      enableInfiniteScroll: true, // Scroll tak terbatas
      autoPlayAnimationDuration: const Duration(
          milliseconds: 800), // Durasi animasi perpindahan halaman
      viewportFraction: 0.8, // Fraksi lebar halaman yang terlihat
    ),
    items: [
      // Daftar widget gambar yang akan ditampilkan dalam carousel
      Image.asset(
        'assets/image/corousel_2.png',
        width: MediaQuery.of(context).size.width,
      ),
      Image.asset('assets/image/corousel_1.png'),
    ],
  );
}
