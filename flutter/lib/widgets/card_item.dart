import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../common/constants.dart';



Card cardItem(BoxConstraints constraints, String image, String nama,
    String harga, String kelamin, String usia) {
  final itemWidth = constraints.maxWidth / 2;
  return Card(
    shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Expanded(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: itemWidth / 200,
              child: Image.asset(
                'assets/image/$image',
                height: 153,
                fit: BoxFit.fill,
              ),
            ),
            Column(children: [
              const SizedBox(
                height: 3,
              ),
              AutoSizeText(
                nama,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(
                height: 18,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    harga,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    padding: const EdgeInsets.fromLTRB(4, 2, 3, 4),
                    decoration: const BoxDecoration(
                      color: AppColors.chip,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Text(
                      usia,
                      style: const TextStyle(fontSize: 10),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    padding: const EdgeInsets.fromLTRB(4, 2, 3, 4),
                    decoration: const BoxDecoration(
                      color: AppColors.chip,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Text(
                      kelamin,
                      style: const TextStyle(fontSize: 10),
                    ),
                  ),
                ],
              )
            ])
          ],
        ),
      ),
    ),
  );
}
