import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:rental_busana/screens/home.dart';
import '../../common/constants.dart';
import 'package:lottie/lottie.dart';

class Done extends StatefulWidget {
  const Done({super.key});

  @override
  State<Done> createState() => _DoneState();
}

class _DoneState extends State<Done> {
  @override
  void initState() {
    super.initState();
    timeDilation =
        3.0; // Jika Anda ingin mengatur efek animasi yang lebih lambat, Anda dapat menyesuaikan nilai timeDilation.
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
          color: AppColors.primaryColor,
        ),
        backgroundColor: Colors.white,
        toolbarHeight: MediaQuery.of(context).size.height / 10 - 10,
        title: const Text(
          "Checkout",
          style: TextStyle(color: AppColors.primaryColor),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          const Center(
            child: Text(
              "PESANAN ANDA BERHASIL ",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryColor),
            ),
          ),
          Icon(
            Icons.check_circle_outline, // Ikon check
            size: 300, // Ukuran ikon (lebar dan tinggi)
            color: Colors.green, // Warna ikon
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Silahkan datang ke toko dengan membawa kartu identitas",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: AppColors.primaryColor),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Center(
            child: CircularProgressIndicator(),
          )
        ],
      ),
    );
  }
}
