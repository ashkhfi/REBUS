import 'package:flutter/material.dart';

import '../common/constants.dart';

AppBar appBarUser(BuildContext context) {
  return AppBar(
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
      title: Text(
        "Chat",
        style: TextStyle(color: AppColors.primaryColor),
      ));
}
