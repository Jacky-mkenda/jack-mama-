import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:patientapp/utils/colors.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_html/flutter_html.dart';
// ignore: import_of_legacy_library_into_null_safe, depend_on_referenced_packages
import 'package:html/parser.dart' show parse;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patientapp/utils/sharedpre.dart';
import 'package:patientapp/utils/strings.dart';
import 'package:patientapp/widgets/myappbarwithback.dart';
import 'package:patientapp/widgets/mysvgassetsimg.dart';
import 'package:patientapp/widgets/mytext.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
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

  static void getUserId() async {
    SharedPre sharedPref = SharedPre();
    Constant.userID = await sharedPref.read("userid") ?? "";
    log('Constant userID ==> ${Constant.userID}');
  }

  static setUserId() async {
    SharedPre sharedPref = SharedPre();
    await sharedPref.save("userid", "");
    String userId = await sharedPref.read("userid");
    log('setUserId userId ==> $userId');
  }

  static setFirstTime() async {
    SharedPre sharedPref = SharedPre();
    await sharedPref.save("seen", "1");
    String seenValue = await sharedPref.read("seen");
    log('setFirstTime seen ==> $seenValue');
  }

  static Widget pageLoader() {
    return const Align(
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }

  static void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: MyText(
          mTitle: message,
          mFontSize: 14,
          mFontStyle: FontStyle.normal,
          mFontWeight: FontWeight.normal,
          mTextColor: white,
          mTextAlign: TextAlign.center,
        ),
      ),
    );
  }

  static void showProgress(
      BuildContext context, ProgressDialog prDialog) async {
    prDialog = ProgressDialog(context);
    //For normal dialog
    prDialog = ProgressDialog(context,
        type: ProgressDialogType.normal, isDismissible: false, showLogs: false);

    prDialog.style(
      message: pleaseWait,
      borderRadius: 5,
      progressWidget: Container(
        padding: const EdgeInsets.all(8),
        child: const CircularProgressIndicator(),
      ),
      maxProgress: 100,
      progressTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 13,
        fontWeight: FontWeight.w400,
      ),
      backgroundColor: white,
      insetAnimCurve: Curves.easeInOut,
      messageTextStyle: const TextStyle(
        color: black,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
    );

    await prDialog.show();
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
        icon: const MySvgAssetsImg(
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

  static String formateDate(String date) {
    String finalDate = "";
    DateFormat inputDate = DateFormat("yyyy-MM-dd");
    DateFormat outputDate = DateFormat("MMMM dd, yyyy");

    log('date => $date');
    DateTime inputTime = inputDate.parse(date);
    log('inputTime => $inputTime');

    finalDate = outputDate.format(inputTime);
    log('finalDate => $finalDate');

    return finalDate;
  }

  static String formateInYYYYMMDD(String date) {
    String finalDate = "";
    DateFormat inputDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSXXX");
    DateFormat outputDate = DateFormat("yyyy-MM-dd");

    log('date => $date');
    DateTime inputTime = inputDate.parse(date);
    log('inputTime => $inputTime');

    finalDate = outputDate.format(inputTime);
    log('finalDate => $finalDate');

    return finalDate;
  }

  static String formateFullDate(String date) {
    String finalDate = "";
    DateFormat inputDate = DateFormat("yyyy-MM-dd HH:mm:ss.SSS");
    DateFormat outputDate = DateFormat("yyyy-MM-dd");

    log('date => $date');
    DateTime inputTime = inputDate.parse(date);
    log('inputTime => $inputTime');

    finalDate = outputDate.format(inputTime);
    log('finalDate => $finalDate');

    return finalDate;
  }

  static String formateInMMMMDD(String date) {
    String finalDate = "";
    DateFormat inputDate = DateFormat("yyyy-MM-dd");
    DateFormat outputDate = DateFormat("MMMM dd");

    log('date => $date');
    DateTime inputTime = inputDate.parse(date);
    log('inputTime => $inputTime');

    finalDate = outputDate.format(inputTime);
    log('finalDate => $finalDate');

    return finalDate;
  }

  static String formateTime(String time) {
    String finalTime = "";
    DateFormat hhmmFormatter = DateFormat("HH:mm");
    DateFormat mmFormatter = DateFormat("hh:mm a");

    log('date => $date');
    DateTime inputTime = hhmmFormatter.parse(time);
    log('inputTime => $inputTime');

    finalTime = mmFormatter.format(inputTime);
    log('finalTime => $finalTime');

    return finalTime;
  }

  static String formateTimeSetInColumn(String time) {
    String finalTime = "";
    DateFormat hhmmFormatter = DateFormat("HH:mm");
    DateFormat mmFormatter = DateFormat("hh:mm a");

    log('date => $date');
    DateTime inputTime = hhmmFormatter.parse(time);
    log('inputTime => $inputTime');

    finalTime = mmFormatter.format(inputTime);
    finalTime = finalTime.split(" ").join("\n");
    log('finalTime => $finalTime');

    return finalTime;
  }

  static String covertTimeToText(String dataDate) {
    String convTime = "";
    String suffix = "ago";

    try {
      DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
      DateTime pasTime = dateFormat.parse(dataDate);
      DateTime nowTime = DateTime.now();

      log("==>pastTime ${pasTime.day}");
      log("==>nowTime ${nowTime.day}");

      Duration difference = nowTime.difference(pasTime);
      log('(1). difference => $difference');

      int day = difference.inDays;
      double hour = difference.inHours % 24;
      double minute = difference.inMinutes % 60;
      double second = difference.inSeconds % 60;

      log("==>second : $second");
      log("==>minute : $minute");
      log("==>hour : $hour");
      log("==>day : $day");

      if (day >= 7) {
        if (day > 360) {
          convTime = "${(day / 360)} yrs $suffix";
        } else if (day > 30) {
          convTime = "${(day / 30)} months $suffix";
        } else {
          convTime = "${(day / 7)} week $suffix";
        }
      } else if (day > 0 && day < 7) {
        if (day == 1) {
          convTime = "$day day $suffix";
        } else {
          convTime = "$day days $suffix";
        }
      } else if (hour < 24 && hour > 0) {
        if (hour == 1) {
          convTime = "${hour.round()} hr $suffix";
        } else {
          convTime = "${hour.round()} hrs $suffix";
        }
      } else if (minute < 60 && minute > 0) {
        if (minute == 1) {
          convTime = "${minute.round()} min $suffix";
        } else {
          convTime = "${minute.round()} mins $suffix";
        }
      } else if (second < 60 && second > 0) {
        if (second == 1) {
          convTime = "${second.round()} sec $suffix";
        } else {
          convTime = "${second.round()} secs $suffix";
        }
      }
    } catch (e) {
      log("ConvTimeE Exception ==> $e");
    }

    return convTime;
  }

  static String calculateBMI(String strWeight, String strHeight) {
    String strBMIText = "", bmiResult = "";
    double bmi = 0;
    if (strWeight.isNotEmpty && strWeight != "-") {
      double weightValue = double.parse(strWeight.trim());
      double heightValue = double.parse(strHeight.trim()) / 100;

      bmi = (weightValue / (heightValue * heightValue));

      log("bmi :==> $bmi");
      if (bmi < 18.5) {
        bmiResult = "You are in the underweight BMI range!";
      } else if (bmi >= 18.5 && bmi < 24.9) {
        bmiResult = "You are in the healthy weight BMI range!";
      } else if (bmi >= 25 && bmi <= 29.9) {
        bmiResult = "You are in the overweight BMI range!";
      } else if (bmi > 30) {
        bmiResult = "You are in the obese BMI range!";
      }

      strBMIText = parseHtmlString(
          "<p>BMI is : <b><font color='#000'>${bmi.toStringAsFixed(2)}</font></b> and $bmiResult </p>");
      log("strBMIText :==> $strBMIText");
    } else {
      strBMIText = "";
    }
    return strBMIText;
  }

  //Convert Html to simple String
  static String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;

    return parsedString;
  }
}
