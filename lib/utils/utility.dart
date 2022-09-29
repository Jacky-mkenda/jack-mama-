import 'package:flutter/material.dart';

import 'package:patientapp/utils/colors.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patientapp/widgets/myappbarwithback.dart';
import 'package:patientapp/widgets/mysvgassetsimg.dart';
import 'package:patientapp/widgets/mytext.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constant.dart';

class Utility {
  static void showToast(var msg) {
    Fluttertoast.showToast(
        msg: "$msg",
        timeInSecForIosWeb: 2,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: white,
        textColor: black,
        fontSize: 16);
  }

  static PreferredSize appBarCommon(var appBarTitle) {
    return PreferredSize(
      preferredSize: Size.fromHeight(Constant.appBarHeight),
      child: MyAppBarWithBack(
        abTitle: appBarTitle,
        fontSize: Constant.appBarTextSize,
        abBGColor: appBgColor,
        fontColor: white,
      ),
    );
  }

  static AppBar myAppBar(BuildContext context, String appBarTitle) {
    return AppBar(
      elevation: 0,
      backgroundColor: statusBarColor,
      centerTitle: true,
      // flexibleSpace: Container(
      //   decoration: toolbarGradientBG(),
      // ),
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: MySvgAssetsImg(
          imageName: "back.svg",
          fit: BoxFit.contain,
          imgHeight: 15,
          imgWidth: 19,
        ),
      ),
      title: MyText(
        mTitle: appBarTitle,
        mFontSize: 20,
        mFontStyle: FontStyle.normal,
        mFontWeight: FontWeight.normal,
        mTextAlign: TextAlign.center,
        mTextColor: white,
      ),
    );
  }

  static BoxDecoration topRoundBG() {
    return const BoxDecoration(
      color: appBgColor,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      shape: BoxShape.rectangle,
    );
  }

  static BoxDecoration topRoundWhiteBG() {
    return const BoxDecoration(
      color: white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      shape: BoxShape.rectangle,
    );
  }

  static BoxDecoration textFieldBGWithBorder() {
    return BoxDecoration(
      color: white,
      border: Border.all(
        color: otherLightColor,
        width: .2,
      ),
      borderRadius: BorderRadius.circular(4),
      shape: BoxShape.rectangle,
    );
  }

  static BoxDecoration r4BGWithBorder() {
    return BoxDecoration(
      color: white,
      border: Border.all(
        color: otherLightColor,
        width: .5,
      ),
      borderRadius: BorderRadius.circular(4),
      shape: BoxShape.rectangle,
    );
  }

  static BoxDecoration r4DarkBGWithBorder() {
    return BoxDecoration(
      color: primaryDarkColor,
      border: Border.all(
        color: primaryDarkColor,
        width: .5,
      ),
      borderRadius: BorderRadius.circular(4),
      shape: BoxShape.rectangle,
    );
  }

  static BoxDecoration r10BGWithBorder() {
    return BoxDecoration(
      color: white,
      border: Border.all(
        color: boxBorderColor,
        width: .5,
      ),
      borderRadius: BorderRadius.circular(10),
      shape: BoxShape.rectangle,
    );
  }

  static BoxDecoration primaryDarkButton() {
    return BoxDecoration(
      color: primaryDarkColor,
      borderRadius: BorderRadius.circular(4),
      shape: BoxShape.rectangle,
    );
  }

  static BoxDecoration primaryButton() {
    return BoxDecoration(
      color: primaryColor,
      borderRadius: BorderRadius.circular(4),
      shape: BoxShape.rectangle,
      // boxShadow: const [
      //   BoxShadow(
      //     offset: Offset(0, 0),
      //     blurRadius: 2,
      //     spreadRadius: 2,
      //     color: Colors.black26,
      //   ),
      // ],
    );
  }

  static BoxDecoration toolbarGradientBG() {
    return const BoxDecoration(
      color: primaryColor,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      shape: BoxShape.rectangle,
    );
  }

  static Html htmlTexts(var strText) {
    return Html(
      data: strText,
      onLinkTap: (url) async {
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(
            Uri.parse(url),
            mode: LaunchMode.platformDefault,
          );
        } else {
          throw 'Could not launch $url';
        }
      },
      shrinkToFit: false,
      linkStyle:
          const TextStyle(decoration: TextDecoration.none, color: linkColor),
      defaultTextStyle: GoogleFonts.roboto(
        textStyle: const TextStyle(
          fontSize: 14,
          color: otherLightColor,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          letterSpacing: .2,
        ),
      ),
    );
  }

  static Future<void> launchPhoneDialer(String contactNumber) async {
    final Uri phoneUri = Uri(scheme: "tel", path: contactNumber);
    try {
      if (await canLaunchUrl(Uri.parse(phoneUri.toString()))) {
        await launchUrl(Uri.parse(phoneUri.toString()));
      }
    } catch (error) {
      throw ("Cannot dial");
    }
  }
}
