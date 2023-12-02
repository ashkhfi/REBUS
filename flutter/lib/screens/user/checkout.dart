import 'package:flutter/material.dart';
import 'package:rental_busana/common/constants.dart';
import 'package:rental_busana/services/api_services.dart';
import 'package:rental_busana/services/firestore_services.dart';

import '../../models/pakaian.dart';
import '../../services/auth_services.dart';
import '../../utils/format_camel_case.dart';
import '../../utils/format_harga.dart';

class Checkout extends StatefulWidget {
  final Pakaian pakaian;

  Checkout({required this.pakaian});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  Authservices authservices = Authservices();
  ApiService apiService = ApiService();
  FirestoreServices firestoreservices = FirestoreServices();
  final TextEditingController dateController = TextEditingController();
  final ValueNotifier<int> totalNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    dateController.addListener(updateTotal);
  }

  @override
  void dispose() {
    dateController.dispose();
    totalNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
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
        title: const Text(
          "Checkout",
          style: TextStyle(color: AppColors.primaryColor),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.grey[200],
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        color: AppColors.chip,
                        height: 3,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        child: Image.network(
                          '${Api.baseUrl}/storage/images/${widget.pakaian.image}',
                          height: 300,
                          width: 300,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        color: AppColors.chip,
                        height: 2,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.pakaian.nama,
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "sewa berapa hari  : ",
                        style: TextStyle(color: Colors.black, fontSize: 17),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 30, 0),
                        width: 200,
                        child: TextField(
                          controller: dateController,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 10.0),
                            filled: true,
                            fillColor: AppColors.chip,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "*Harga yang tertera di awal adalah harga per hari. Apabila terjadi keterlambatan pengembalian, akan dikenakan denda sebesar 5000 per hari. Namun, untuk pengembalian sebelum waktu yang ditentukan, tidak akan mempengaruhi harga sewa. ",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Container bottom
          Column(
            children: [
              Container(
                height: 4,
                color: AppColors.chip,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 10,
                color: AppColors.primaryColor,
                child: Row(
                  children: [
                    Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width - 150,
                      child: Center(
                        child: ValueListenableBuilder<int>(
                          valueListenable: totalNotifier,
                          builder: (context, total, _) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Total Bayar : ",
                                  style: TextStyle(fontSize: 18),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Rp.${PriceFormatter.formatPrice(total)}',
                                  style: const TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/berhasil');
                          int total = widget.pakaian.harga *
                              int.parse(dateController.text);
                          List<Pakaian> pakaianDataList = [
                            Pakaian(
                              id: widget.pakaian.id,
                              deskripsi: widget.pakaian.deskripsi,
                              kategori: widget.pakaian.kategori,
                              kelamin: widget.pakaian.kelamin,
                              usia: widget.pakaian.usia,
                              status: widget.pakaian.status,
                              nama: widget.pakaian.nama,
                              image: widget.pakaian.image,
                              harga: widget.pakaian.harga,
                            ),
                          ];
                          int end = int.tryParse(dateController.text) ?? 0;
                          firestoreservices.addRental(pakaianDataList, end);
                        },
                        child: const Text(
                          "Buat Pesanan",
                          style: TextStyle(
                            color: AppColors.chip,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void updateTotal() {
    int days = int.tryParse(dateController.text) ?? 0;
    int total = widget.pakaian.harga * days;
    totalNotifier.value = total;
  }
}
