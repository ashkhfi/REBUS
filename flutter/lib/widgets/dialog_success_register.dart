import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rental_busana/common/constants.dart';

void DialogSuccessRegister(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Success',
              style: TextStyle(color: AppColors.primaryColor)),
          content: const Text(
            "Berhasil Registrasi",
            style: TextStyle(color: AppColors.primaryColor),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text(
                "Belum",
                style: TextStyle(color: AppColors.chip),
              ),
            ),
          ],
        );
      });
}
