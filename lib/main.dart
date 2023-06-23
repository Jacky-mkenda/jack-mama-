import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:patientapp/pages/splash.dart';
import 'package:patientapp/provider/allappointmentprovider.dart';
import 'package:patientapp/provider/appointmentdetailprovider.dart';
import 'package:patientapp/provider/bookappointmentprovider.dart';
import 'package:patientapp/provider/doctordetailprovider.dart';
import 'package:patientapp/provider/forgotpasswordprovider.dart';
import 'package:patientapp/provider/generalprovider.dart';
import 'package:patientapp/provider/historyprovider.dart';
import 'package:patientapp/provider/homeprovider.dart';
import 'package:patientapp/provider/medicaltestprovider.dart';
import 'package:patientapp/provider/notificationprovider.dart';
import 'package:patientapp/provider/profileprovider.dart';
import 'package:patientapp/provider/updateprofileprovider.dart';
import 'package:patientapp/provider/viewallprovider.dart';
import 'package:patientapp/utils/colors.dart';
import 'package:patientapp/utils/constant.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:patientapp/utils/utility.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GeneralProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => ViewAllProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => UpdateProfileProvider()),
        ChangeNotifierProvider(create: (_) => AllAppointmentProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
        ChangeNotifierProvider(create: (_) => AppointmentDetailProvider()),
        ChangeNotifierProvider(create: (_) => DoctorDetailProvider()),
        ChangeNotifierProvider(create: (_) => MedicalTestProvider()),
        ChangeNotifierProvider(create: (_) => BookAppointmentProvider()),
        ChangeNotifierProvider(create: (_) => ForgotPasswordProvider()),
      ],
      child:  MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late PackageInfo packageInfo;
  @override
  void initState() {
    //Saved UserID in Constant for Future use
    Utility.getUserId();
    getPackage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        primaryColorDark: primaryDarkColor,
        primaryColorLight: primaryLightColor,
        scaffoldBackgroundColor: appBgColor,
      ),
      title: Constant.appName.isNotEmpty ? Constant.appName : "DTPatient",
      home: const Splash(),
    );
  }

  void getPackage() async {
    packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    Constant.appName = appName;
    log(Constant.appName);

    log("App Name : $appName, App Package Name : $packageName, App Version : $version, App build Number : $buildNumber");
  }
}
