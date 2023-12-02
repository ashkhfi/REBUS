import 'package:flutter/material.dart';

void tampilkanBottomSheet(BuildContext context, String pesan) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.all(20),
        child: Text(
          pesan,
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      );
    },
  );
}
