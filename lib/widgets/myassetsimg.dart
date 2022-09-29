import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyAssetsImg extends StatelessWidget {
  String imageName;
  double? imgHeight, imgWidth;
  dynamic fit, iconColor;

  MyAssetsImg({
    Key? key,
    required this.imageName,
    required this.fit,
    this.imgHeight,
    this.imgWidth,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: imgHeight,
      width: imgWidth,
      child: Image.asset(
        "assets/images/$imageName",
        fit: fit,
        color: iconColor,
      ),
    );
  }
}
