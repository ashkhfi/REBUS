import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  final List<String> imageUrls;

  ImagePreview({required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imageUrls.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: Image.asset(
              imageUrls[index],
              fit: BoxFit.fill,
            ),
          );
        },
      ),
    );
  }
}
