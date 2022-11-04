import 'dart:developer';

import 'package:patientapp/pages/intro.dart';
import 'package:patientapp/pages/login.dart';
import 'package:patientapp/pages/sidedrawer.dart';
import 'package:patientapp/provider/generalprovider.dart';
import 'package:patientapp/utils/constant.dart';
import 'package:patientapp/utils/sharedpre.dart';
import 'package:patientapp/widgets/myassetsimg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String? seen;
  SharedPre sharedPre = SharedPre();

  @override
  void initState() {
    final generalsetting = Provider.of<GeneralProvider>(context, listen: false);
    generalsetting.getGeneralsetting(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isFirstCheck();

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

  Future<void> isFirstCheck() async {
    final generalsettingData = Provider.of<GeneralProvider>(context);

    log('Is generalsettingData loading...? ==> ${generalsettingData.loading}');
    if (!generalsettingData.loading) {
      log('generalSettingData status ==> ${generalsettingData.generalSettingModel.status}');
      for (var i = 0;
          i < generalsettingData.generalSettingModel.result!.length;
          i++) {
        await sharedPre.save(
          generalsettingData.generalSettingModel.result![i].key.toString(),
          generalsettingData.generalSettingModel.result![i].value.toString(),
        );
        log('${generalsettingData.generalSettingModel.result![i].key.toString()} ==> ${generalsettingData.generalSettingModel.result![i].value.toString()}');
      }

      seen = await sharedPre.read('seen') ?? "0";
      log('seen ==> $seen');
      if (!mounted) return;
      if (seen == "1") {
        if (Constant.userID != "") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const MySideDrawer();
              },
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const Login();
              },
            ),
          );
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const Intro();
            },
          ),
        );
      }
    }
  }
}
