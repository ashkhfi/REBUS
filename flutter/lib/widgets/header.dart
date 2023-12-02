import 'package:flutter/material.dart';

import '../common/constants.dart';

Widget header(BuildContext context) {
  return Container(
    padding: const EdgeInsets.fromLTRB(30, 28, 0, 15),
    height: 81,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Expanded(
          child: TextField(
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(
                  color: AppColors.primaryColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(
                  color: AppColors
                      .primaryColor, // Warna border saat tidak dalam fokus
                ),
              ),
              contentPadding: EdgeInsetsDirectional.symmetric(vertical: 10),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.primaryColor,
              ),
              hintText: "Cari di Rebus",
            ),
            style: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(width: 10),
        Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.message,
                color: AppColors.primaryColor,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/chat_user');
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.person,
                color: AppColors.primaryColor,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/profil');
              },
            ),
          ],
        ),
      ],
    ),
  );
}
