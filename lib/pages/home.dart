import 'dart:developer';

import 'package:awesome_drawer_bar/awesome_drawer_bar.dart';
import 'package:badges/badges.dart';
import 'package:patientapp/pages/appointmentf.dart';
import 'package:patientapp/pages/historyf.dart';
import 'package:patientapp/pages/homef.dart';
import 'package:patientapp/pages/login.dart';
import 'package:patientapp/pages/medicaltestf.dart';
import 'package:patientapp/pages/notifications.dart';
import 'package:patientapp/pages/profile.dart';
import 'package:patientapp/provider/homeprovider.dart';
import 'package:patientapp/utils/colors.dart';
import 'package:patientapp/utils/constant.dart';
import 'package:patientapp/utils/strings.dart';
import 'package:patientapp/widgets/mynetworkimg.dart';
import 'package:patientapp/widgets/mysvgassetsimg.dart';
import 'package:patientapp/widgets/mytext.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();
  int currentIndex = 0;
  late int selectedMenuItemId;
  late String appBarTitle;
  late bool isHomePage;
  final navigationPages = [
    const HomeF(),
    const AppointmentF(),
    const MedicalTestF(),
    const HistoryF(),
  ];

  @override
  void initState() {
    super.initState();
    appBarTitle = home;
    isHomePage = true;
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.getPatientNotification();
    homeProvider.getPatientProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: drawerKey,
      resizeToAvoidBottomInset: true,
      backgroundColor: primaryColor,
      appBar: homeAppBar(),
      body: navigationPages.elementAt(currentIndex),
      bottomNavigationBar: myBottomNavigation(),
    );
  }

  AppBar homeAppBar() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: statusBarColor,
      leading: IconButton(
        onPressed: () {
          AwesomeDrawerBar.of(context)!.toggle();
        },
        icon: const MySvgAssetsImg(
          imageName: "drawer.svg",
          fit: BoxFit.contain,
          imgHeight: 13,
          imgWidth: 22,
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
      actions: <Widget>[
        Visibility(
          visible: isHomePage,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: Consumer<HomeProvider>(
            builder: (context, homeProvider, child) {
              return IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Notifications(),
                    ),
                  );
                },
                icon: Badge(
                  position: BadgePosition.bottomStart(bottom: 8, start: 8),
                  badgeColor: white,
                  badgeContent: MyText(
                    mTitle: !homeProvider.loading
                        ? ((homeProvider.notificationModel.status == 200 &&
                                homeProvider.notificationModel.result != null)
                            ? (homeProvider.notificationModel.result?.length
                                    .toString() ??
                                "0")
                            : "0")
                        : "0",
                    mFontSize: 8,
                    mFontStyle: FontStyle.normal,
                    mFontWeight: FontWeight.normal,
                    mTextAlign: TextAlign.center,
                    mTextColor: primaryColor,
                  ),
                  child: const MySvgAssetsImg(
                    imageName: "notification.svg",
                    fit: BoxFit.contain,
                  ),
                ),
              );
            },
          ),
        ),
        Visibility(
          visible: isHomePage,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: Consumer<HomeProvider>(
            builder: (context, homeProvider, child) {
              return IconButton(
                onPressed: (() {
                  log('Profile tapped!');
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return (Constant.userID == "0" || Constant.userID == "")
                            ? const Login()
                            : const Profile();
                      },
                    ),
                  );
                }),
                icon: CircleAvatar(
                    radius: 16,
                    backgroundColor: white,
                    child: ClipOval(
                      clipBehavior: Clip.antiAlias,
                      child: MyNetworkImage(
                        imageUrl: !homeProvider.loading
                            ? ((homeProvider.profileModel.status == 200 &&
                                    homeProvider.profileModel.result != null)
                                ? (homeProvider.profileModel.result
                                        ?.elementAt(0)
                                        .profileImg
                                        .toString() ??
                                    Constant.userPlaceholder)
                                : Constant.userPlaceholder)
                            : Constant.userPlaceholder,
                        fit: BoxFit.cover,
                        imgHeight: 30,
                        imgWidth: 30,
                      ),
                    )),
              );
            },
          ),
        ),
      ],
    );
  }

  BottomNavigationBar myBottomNavigation() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      elevation: 5,
      backgroundColor: white,
      selectedItemColor: primaryDarkColor,
      unselectedItemColor: otherColor,
      selectedFontSize: 12,
      currentIndex: currentIndex,
      unselectedFontSize: 12,
      selectedLabelStyle: GoogleFonts.roboto(
        textStyle: const TextStyle(
          color: primaryDarkColor,
          fontSize: 12,
          height: 1.5,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
        ),
      ),
      unselectedLabelStyle: GoogleFonts.roboto(
        textStyle: const TextStyle(
          color: otherColor,
          fontSize: 12,
          height: 1.5,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
        ),
      ),
      onTap: (value) {
        log('$value');
        onNavigationClick(value);
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          label: home,
          tooltip: home,
          icon: MySvgAssetsImg(
            imageName: "home.svg",
            fit: BoxFit.contain,
            imgHeight: 21,
            imgWidth: 21,
          ),
          activeIcon: MySvgAssetsImg(
            imageName: "home_selected.svg",
            fit: BoxFit.contain,
            imgHeight: 21,
            imgWidth: 21,
          ),
        ),
        BottomNavigationBarItem(
          label: appointments,
          tooltip: appointments,
          icon: MySvgAssetsImg(
            imageName: "appointment.svg",
            fit: BoxFit.contain,
            imgHeight: 21,
            imgWidth: 21,
          ),
          activeIcon: MySvgAssetsImg(
            imageName: "appointment_selected.svg",
            fit: BoxFit.contain,
            imgHeight: 21,
            imgWidth: 21,
          ),
        ),
        BottomNavigationBarItem(
          label: medicalTest,
          tooltip: medicalTest,
          icon: MySvgAssetsImg(
            imageName: "medicaltest.svg",
            fit: BoxFit.contain,
            imgHeight: 21,
            imgWidth: 21,
          ),
          activeIcon: MySvgAssetsImg(
            imageName: "medicaltest_selected.svg",
            fit: BoxFit.contain,
            imgHeight: 21,
            imgWidth: 21,
          ),
        ),
        BottomNavigationBarItem(
          label: history,
          tooltip: history,
          icon: MySvgAssetsImg(
            imageName: "history.svg",
            fit: BoxFit.contain,
            imgHeight: 21,
            imgWidth: 21,
          ),
          activeIcon: MySvgAssetsImg(
            imageName: "history_selected.svg",
            fit: BoxFit.contain,
            imgHeight: 21,
            imgWidth: 21,
          ),
        ),
      ],
    );
  }

  void onNavigationClick(int value) {
    log('$value');
    // Respond to item press.
    setState(() {
      currentIndex = value;
      switch (value) {
        case 0:
          {
            appBarTitle = home;
            isHomePage = true;
          }
          break;
        case 1:
          {
            appBarTitle = appointments;
            isHomePage = true;
          }
          break;
        case 2:
          {
            appBarTitle = medicalTest;
            isHomePage = true;
          }
          break;
        case 3:
          {
            appBarTitle = history;
            isHomePage = true;
          }
          break;
      }
    });
  }

  toggleDrawer() async {
    drawerKey.currentState?.openEndDrawer();
  }
}
