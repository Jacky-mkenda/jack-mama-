import 'dart:async';

import 'package:patientapp/pages/home.dart';
import 'package:patientapp/pages/login.dart';
import 'package:patientapp/widgets/myassetsimg.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    navigateToNext(context);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: MyAssetsImg(
        imageName: "splash.png",
        fit: BoxFit.fill,
        imgHeight: MediaQuery.of(context).size.height,
        imgWidth: MediaQuery.of(context).size.width,
      ),
    );
  }
}

void navigateToNext(BuildContext context) {
  Timer(
      const Duration(seconds: 1),
      () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Login())));
}
