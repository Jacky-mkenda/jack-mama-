import 'dart:developer';

import 'package:awesome_drawer_bar/awesome_drawer_bar.dart';
import 'package:patientapp/pages/aboutprivacyterms.dart';
import 'package:patientapp/pages/forgotpassword.dart';
import 'package:patientapp/pages/home.dart';
import 'package:patientapp/pages/login.dart';
import 'package:patientapp/utils/colors.dart';
import 'package:patientapp/utils/constant.dart';
import 'package:patientapp/utils/sharedpre.dart';
import 'package:patientapp/utils/strings.dart';
import 'package:patientapp/utils/utility.dart';
import 'package:patientapp/widgets/mysvgassetsimg.dart';
import 'package:patientapp/widgets/mytext.dart';
import 'package:flutter/material.dart';

class MySideDrawer extends StatefulWidget {
  const MySideDrawer({Key? key}) : super(key: key);

  @override
  State<MySideDrawer> createState() => _MySideDrawerState();
}

class _MySideDrawerState extends State<MySideDrawer> {
  final _drawerBarController = AwesomeDrawerBarController();
  late int selectedMenuItemId;
  late String aboutUsUrl, privacyUrl, termsConditionUrl;

  @override
  void initState() {
    getAboutPrivacyTermsURL();
    selectedMenuItemId = 0;
    super.initState();
  }

  Future<void> getAboutPrivacyTermsURL() async {
    SharedPre sharedPref = SharedPre();
    aboutUsUrl = await sharedPref.read("about-us") ?? "";
    privacyUrl = await sharedPref.read("privacy-policy") ?? "";
    termsConditionUrl = await sharedPref.read("terms-and-conditions") ?? "";
    log('Constant userID ==> ${Constant.userID}');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AwesomeDrawerBar(
      type: StyleState.scaleRight,
      controller: _drawerBarController,
      menuScreen: mySideNavDrawer(),
      mainScreen: const Home(),
      borderRadius: 12.0,
      showShadow: false,
      angle: 0.0,
      slideWidth: MediaQuery.of(context).size.width * .8,
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.bounceIn,
      backgroundColor: drawerStartColor,
    );
  }

  Widget mySideNavDrawer() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(
            height: 70,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(6),
                  onTap: () {
                    log("Tapped on $forgotPassword");
                    toggleDrawer();
                    setState(() {
                      selectedMenuItemId = 1;
                      log("selectedMenuItemId => $selectedMenuItemId");
                    });
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ForgotPassword("Drawer"),
                      ),
                    );
                  },
                  child: Container(
                    decoration: selectedMenuItemId == 1
                        ? BoxDecoration(
                            color: other50OpacColor,
                            borderRadius: BorderRadius.circular(6),
                            shape: BoxShape.rectangle,
                          )
                        : null,
                    width: MediaQuery.of(context).size.width * 0.55,
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: const <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        MySvgAssetsImg(
                          imageName: "reset_pw.svg",
                          fit: BoxFit.cover,
                          imgHeight: 24,
                          iconColor: white,
                          imgWidth: 24,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: MyText(
                            mTitle: forgotPassword,
                            mFontSize: 16,
                            mFontStyle: FontStyle.normal,
                            mFontWeight: FontWeight.normal,
                            mTextColor: white,
                            mOverflow: TextOverflow.ellipsis,
                            mMaxLine: 2,
                            mTextAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        MySvgAssetsImg(
                          imageName: "view_more.svg",
                          fit: BoxFit.cover,
                          imgHeight: 13,
                          imgWidth: 7,
                          iconColor: white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(6),
                  onTap: () {
                    log("Tapped on $aboutUs");
                    toggleDrawer();
                    setState(() {
                      selectedMenuItemId = 2;
                      log("selectedMenuItemId => $selectedMenuItemId");
                    });
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AboutPrivacyTerms(
                          appBarTitle: aboutUs,
                          loadURL: aboutUsUrl,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.55,
                    decoration: selectedMenuItemId == 2
                        ? BoxDecoration(
                            color: other50OpacColor,
                            borderRadius: BorderRadius.circular(6),
                            shape: BoxShape.rectangle,
                          )
                        : null,
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: const <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        MySvgAssetsImg(
                          imageName: "about_us.svg",
                          fit: BoxFit.cover,
                          iconColor: white,
                          imgHeight: 24,
                          imgWidth: 24,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: MyText(
                            mTitle: aboutUs,
                            mFontSize: 16,
                            mFontStyle: FontStyle.normal,
                            mFontWeight: FontWeight.normal,
                            mTextColor: white,
                            mOverflow: TextOverflow.ellipsis,
                            mMaxLine: 2,
                            mTextAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        MySvgAssetsImg(
                          imageName: "view_more.svg",
                          fit: BoxFit.cover,
                          imgHeight: 13,
                          imgWidth: 7,
                          iconColor: white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(6),
                  onTap: () {
                    log("Tapped on $termConditions");
                    toggleDrawer();
                    setState(() {
                      selectedMenuItemId = 3;
                      log("selectedMenuItemId => $selectedMenuItemId");
                    });
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AboutPrivacyTerms(
                          appBarTitle: termConditions,
                          loadURL: termsConditionUrl,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.55,
                    decoration: selectedMenuItemId == 3
                        ? BoxDecoration(
                            color: other50OpacColor,
                            borderRadius: BorderRadius.circular(6),
                            shape: BoxShape.rectangle,
                          )
                        : null,
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: const <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        MySvgAssetsImg(
                          imageName: "t_and_c.svg",
                          fit: BoxFit.cover,
                          imgHeight: 24,
                          iconColor: white,
                          imgWidth: 24,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: MyText(
                            mTitle: termConditions,
                            mFontSize: 16,
                            mFontStyle: FontStyle.normal,
                            mFontWeight: FontWeight.normal,
                            mTextColor: white,
                            mOverflow: TextOverflow.ellipsis,
                            mMaxLine: 2,
                            mTextAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        MySvgAssetsImg(
                          imageName: "view_more.svg",
                          fit: BoxFit.cover,
                          imgHeight: 13,
                          imgWidth: 7,
                          iconColor: white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(6),
                  onTap: () {
                    log("Tapped on $privacyPolicy");
                    toggleDrawer();
                    setState(() {
                      selectedMenuItemId = 4;
                      log("selectedMenuItemId => $selectedMenuItemId");
                    });
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AboutPrivacyTerms(
                          appBarTitle: privacyPolicy,
                          loadURL: privacyUrl,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.55,
                    decoration: selectedMenuItemId == 4
                        ? BoxDecoration(
                            color: other50OpacColor,
                            borderRadius: BorderRadius.circular(6),
                            shape: BoxShape.rectangle,
                          )
                        : null,
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: const <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        MySvgAssetsImg(
                          imageName: "report_issue.svg",
                          fit: BoxFit.cover,
                          imgHeight: 24,
                          iconColor: white,
                          imgWidth: 24,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: MyText(
                            mTitle: privacyPolicy,
                            mFontSize: 16,
                            mFontStyle: FontStyle.normal,
                            mFontWeight: FontWeight.normal,
                            mTextColor: white,
                            mOverflow: TextOverflow.ellipsis,
                            mMaxLine: 2,
                            mTextAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        MySvgAssetsImg(
                          imageName: "view_more.svg",
                          fit: BoxFit.cover,
                          imgHeight: 13,
                          imgWidth: 7,
                          iconColor: white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                // InkWell(
                //   borderRadius: BorderRadius.circular(6),
                //   onTap: () {
                //     log("Tapped on $helpCenter");
                //     toggleDrawer();
                //     setState(() {
                //       selectedMenuItemId = 5;
                //       log("selectedMenuItemId => $selectedMenuItemId");
                //     });
                //     Navigator.of(context).push(MaterialPageRoute(
                //         builder: (context) => const AboutPrivacyTerms(
                //               appBarTitle: helpCenter,
                //             ),),);
                //   },
                //   child: Container(
                //     width: MediaQuery.of(context).size.width * 0.55,
                //     decoration: selectedMenuItemId == 5
                //         ? BoxDecoration(
                //             color: other50OpacColor,
                //             borderRadius: BorderRadius.circular(6),
                //             shape: BoxShape.rectangle,
                //           )
                //         : null,
                //     height: 60,
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       mainAxisSize: MainAxisSize.min,
                //       children: const <Widget>[
                //         SizedBox(
                //           width: 10,
                //         ),
                //         MySvgAssetsImg(
                //           imageName: "help_center.svg",
                //           fit: BoxFit.cover,
                //           imgHeight: 24,
                //           imgWidth: 24,
                //           iconColor: white,
                //         ),
                //         SizedBox(
                //           width: 15,
                //         ),
                //         Expanded(
                //           child: MyText(
                //             mTitle: helpCenter,
                //             mFontSize: 16,
                //             mFontStyle: FontStyle.normal,
                //             mFontWeight: FontWeight.normal,
                //             mTextColor: white,
                //             mOverflow: TextOverflow.ellipsis,
                //             mMaxLine: 2,
                //             mTextAlign: TextAlign.start,
                //           ),
                //         ),
                //         SizedBox(
                //           width: 15,
                //         ),
                //         MySvgAssetsImg(
                //           imageName: "view_more.svg",
                //           fit: BoxFit.cover,
                //           imgHeight: 13,
                //           imgWidth: 7,
                //           iconColor: white,
                //         ),
                //         SizedBox(
                //           width: 10,
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(5),
            onTap: () {
              log("Tapped on $logout");
              toggleDrawer();
              setState(() {
                selectedMenuItemId = 6;
                log("selectedMenuItemId => $selectedMenuItemId");
                if (Constant.userID != "") {
                  showMyDialog();
                } else {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                  );
                }
              });
            },
            child: Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              decoration: selectedMenuItemId == 6
                  ? BoxDecoration(
                      color: other50OpacColor,
                      borderRadius: BorderRadius.circular(10),
                      shape: BoxShape.rectangle,
                    )
                  : null,
              width: MediaQuery.of(context).size.width * 0.55,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  const MySvgAssetsImg(
                    imageName: "logout.svg",
                    fit: BoxFit.cover,
                    imgHeight: 24,
                    iconColor: white,
                    imgWidth: 24,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: MyText(
                      mTitle: (Constant.userID == "") ? login : logout,
                      mFontSize: 16,
                      mFontStyle: FontStyle.normal,
                      mFontWeight: FontWeight.normal,
                      mTextColor: white,
                      mOverflow: TextOverflow.ellipsis,
                      mMaxLine: 2,
                      mTextAlign: TextAlign.start,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const MySvgAssetsImg(
                    imageName: "view_more.svg",
                    fit: BoxFit.cover,
                    imgHeight: 13,
                    imgWidth: 7,
                    iconColor: white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  toggleDrawer() {
    _drawerBarController.toggle!();
  }

  Future<void> showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                MyText(
                  mTitle: Constant.appName,
                  mTextColor: black,
                  mFontSize: 25,
                  mFontStyle: FontStyle.normal,
                  mFontWeight: FontWeight.w600,
                  mTextAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                const MyText(
                  mTitle: areYouSureWantToLogout,
                  mTextColor: black,
                  mFontSize: 18,
                  mFontStyle: FontStyle.normal,
                  mFontWeight: FontWeight.normal,
                  mTextAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 2,
                foregroundColor: white,
                backgroundColor: boxBorderColor, // foreground
              ),
              child: const Padding(
                padding: EdgeInsets.all(5),
                child: MyText(
                  mTitle: no,
                  mTextColor: black,
                  mFontSize: 16,
                  mFontStyle: FontStyle.normal,
                  mFontWeight: FontWeight.w600,
                  mTextAlign: TextAlign.center,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 2,
                foregroundColor: white,
                backgroundColor: primaryDarkColor, // foreground
              ),
              child: const Padding(
                padding: EdgeInsets.all(5),
                child: MyText(
                  mTitle: yes,
                  mTextColor: white,
                  mFontSize: 16,
                  mFontStyle: FontStyle.normal,
                  mFontWeight: FontWeight.w600,
                  mTextAlign: TextAlign.center,
                ),
              ),
              onPressed: () async {
                Constant.userID = "";
                await Utility.setUserId();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                );
              },
            )
          ],
        );
      },
    );
  }
}
