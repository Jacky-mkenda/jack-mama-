import 'package:flutter/material.dart';
import 'package:patientapp/utils/colors.dart';

import 'mysvgassetsimg.dart';
import 'mytext.dart';

class MyAppBarWithBack extends StatelessWidget {
  final dynamic iconHeight, iconWidth, abTitle, fontSize, fontColor, abBGColor;

  const MyAppBarWithBack(
      {Key? key,
      required this.abTitle,
      required this.fontSize,
      required this.abBGColor,
      required this.fontColor,
      this.iconHeight,
      this.iconWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      // flexibleSpace: Container(
      //   decoration: Utility.toolbarGradientBG(),
      // ),
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: MySvgAssetsImg(
          imgHeight: iconHeight,
          imgWidth: iconWidth,
          imageName: "back.svg",
          fit: BoxFit.contain,
        ),
      ),
      title: MyText(
        mTitle: abTitle,
        mFontSize: fontSize,
        mFontStyle: FontStyle.normal,
        mFontWeight: FontWeight.normal,
        mMaxLine: 1,
        mOverflow: TextOverflow.ellipsis,
        mTextAlign: TextAlign.center,
        mTextColor: fontColor,
      ),
      backgroundColor: statusBarColor,
      elevation: 0,
    );
  }
}
