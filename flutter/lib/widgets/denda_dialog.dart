import 'package:flutter/material.dart';

void _showDendaDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Icon(
          Icons.warning,
          color: Colors.yellow,
          size: 48,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Denda 5000",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Aksi ketika tombol "Lunas" ditekan
                    Navigator.of(context).pop();
                    // Tambahkan aksi yang diinginkan ketika tombol "Lunas" ditekan
                    print("Lunas");
                  },
                  child: Text("Lunas"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Aksi ketika tombol "Belum" ditekan
                    Navigator.of(context).pop();
                    // Tambahkan aksi yang diinginkan ketika tombol "Belum" ditekan
                    print("Belum");
                  },
                  child: Text("Belum"),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
