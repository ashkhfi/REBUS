// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../provider/pakaian_provider.dart';
// import '../models/pakaian.dart';

// class PakaianListItem extends StatelessWidget {
//   final Pakaian pakaian;

//   const PakaianListItem({required this.pakaian});

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: Image.network(pakaian.image),
//       title: Text(pakaian.nama),
//       subtitle: Text(pakaian.kategori),
//       trailing: IconButton(
//         icon: Icon(Icons.delete),
//         onPressed: () {
//           final pakaianProvider =
//               Provider.of<PakaianProvider>(context, listen: false);
//           pakaianProvider.deletePakaian(pakaian.id);
//         },
//       ),
//     );
//   }
// }
