import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../common/constants.dart';
import '../../utils/format_harga.dart';

class DetailDisewa extends StatefulWidget {
  final String image;
  final String nama;
  final String kategori;
  final String umur;
  final String jenis_kelamin;
  final String mulai;
  final String kembali;
  final int biaya;
  const DetailDisewa(
      {super.key,
      required this.image,
      required this.nama,
      required this.kategori,
      required this.umur,
      required this.jenis_kelamin,
      required this.mulai,
      required this.kembali,
      required this.biaya});

  @override
  State<DetailDisewa> createState() => _DetailDisewaState();
}

class _DetailDisewaState extends State<DetailDisewa> {
  @override
  Widget build(BuildContext context) {
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
        title: const Padding(
          padding: EdgeInsets.only(left: 40),
          child: Text(
            "Detail Disewa ",
            style: TextStyle(color: AppColors.primaryColor),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              height: MediaQuery.of(context).size.height / 9,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    margin: const EdgeInsets.only(top: 5),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        '${Api.baseUrl}/storage/images/${widget.image}',
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
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                          widget.nama,
                          style: const TextStyle(
                            fontSize: 20,
                            color: AppColors.chip,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: AppColors.chip,
            height: 1,
          ),
          Expanded(
            child: Container(
              height: MediaQuery.sizeOf(context).height / 10,
              child: Row(
                children: [
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Kategori",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        widget.kategori,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                            fontSize: 16, color: AppColors.primaryColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: AppColors.chip,
            height: 1,
          ),
          Expanded(
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height / 10,
              child: Row(
                children: [
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Usia",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        widget.umur,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                            fontSize: 16, color: AppColors.primaryColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: AppColors.chip,
            height: 1,
          ),
          Expanded(
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height / 10,
              child: Row(
                children: [
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Jenis Kelamin",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        widget.jenis_kelamin,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                            fontSize: 16, color: AppColors.primaryColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: AppColors.chip,
            height: 1,
          ),
          Expanded(
            child: Container(
              height: MediaQuery.sizeOf(context).height / 10,
              child: Row(
                children: [
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Tanggal mulai",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        widget.mulai,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                            fontSize: 16, color: AppColors.primaryColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: AppColors.chip,
            height: 1,
          ),
          Expanded(
            child: Container(
              height: MediaQuery.sizeOf(context).height / 10,
              child: Row(
                children: [
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Tanggal Kembali",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        widget.kembali,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                            fontSize: 16, color: AppColors.primaryColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: AppColors.chip,
            height: 1,
          ),
          Expanded(
            child: Container(
              height: MediaQuery.sizeOf(context).height / 10,
              child: Row(
                children: [
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Total Biaya",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        'Rp. ${PriceFormatter.formatPrice(widget.biaya)}',
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                            fontSize: 16, color: AppColors.primaryColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: AppColors.chip,
            height: 1,
          ),
          Expanded(
            child: Container(
              height: MediaQuery.sizeOf(context).height / 10,
              child: const Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Status",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Text(
                        "Disewa",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 16, color: AppColors.primaryColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: AppColors.chip,
            height: 1,
          ),
        ],
      ),
    );
  }
}
