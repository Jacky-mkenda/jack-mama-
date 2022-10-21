import 'package:patientapp/utils/colors.dart';
import 'package:patientapp/widgets/myassetsimg.dart';
import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  const NoData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
        margin: const EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(12),
          shape: BoxShape.rectangle,
        ),
        constraints: const BoxConstraints(minHeight: 0, minWidth: 0),
        child: const MyAssetsImg(
          imgHeight: 150,
          fit: BoxFit.contain,
          imageName: "nodata.png",
        ),
      ),
    );
  }
}
