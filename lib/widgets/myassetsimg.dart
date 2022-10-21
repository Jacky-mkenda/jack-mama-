import 'package:flutter/material.dart';

class MyAssetsImg extends StatelessWidget {
  final String imageName;
  final double? imgHeight, imgWidth;
  final dynamic fit, iconColor;

  const MyAssetsImg({
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
