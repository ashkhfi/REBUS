import 'package:flutter/material.dart';
import 'package:rental_busana/models/pakaian.dart';

import '../common/constants.dart';
import '../services/api_services.dart';

class PakaianDialog extends StatefulWidget {
  List<Pakaian> pakaianList = [];
  PakaianDialog({required this.pakaianList});

  @override
  _PakaianDialogState createState() => _PakaianDialogState();
}

class _PakaianDialogState extends State<PakaianDialog> {
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  late ApiService apiService; // Ubah menjadi late

  List<Pakaian> pakaianList = []; // Inisialisasi dengan list kosong

  @override
  void initState() {
    super.initState();
    apiService = ApiService(); // Inisialisasi instance dari ApiService
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Pilih Pakaian'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(
            '${Api.baseUrl}/storage/images/${widget.pakaianList[0].image}',
          ),
          const SizedBox(height: 16),
          const Text('Tanggal Sewa'),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              // Tampilkan date picker untuk memilih tanggal mulai
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              ).then((value) {
                setState(() {
                  selectedStartDate = value;
                });
              });
            },
            child: Text(
              selectedStartDate != null
                  ? selectedStartDate!.toString().substring(0, 10)
                  : 'Pilih Tanggal Mulai',
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              // Tampilkan date picker untuk memilih tanggal selesai
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              ).then((value) {
                setState(() {
                  selectedEndDate = value;
                });
              });
            },
            child: Text(
              selectedEndDate != null
                  ? selectedEndDate!.toString().substring(0, 10)
                  : 'Pilih Tanggal Selesai',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Aksi yang dijalankan saat tombol 'Batal' ditekan
            Navigator.pop(context);
          },
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: () {
            // Aksi yang dijalankan saat tombol 'Pesan' ditekan
            if (selectedStartDate != null && selectedEndDate != null) {
              // Lakukan proses pemesanan atau tindakan yang diperlukan dengan tanggal yang dipilih
              // Anda dapat menambahkan logika atau perubahan state yang diperlukan di sini

              // Tutup dialog setelah melakukan tindakan
              Navigator.pop(context);
            } else {
              // Tampilkan pesan atau peringatan jika tanggal belum dipilih
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Harap pilih tanggal sewa')),
              );
            }
          },
          child: const Text('Pesan'),
        ),
      ],
    );
  }
}
