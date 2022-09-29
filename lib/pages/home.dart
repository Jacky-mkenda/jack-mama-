import 'dart:developer';

import 'package:awesome_drawer_bar/awesome_drawer_bar.dart';
import 'package:badges/badges.dart';
import 'package:patientapp/pages/appointmentf.dart';
import 'package:patientapp/pages/historyf.dart';
import 'package:patientapp/pages/homef.dart';
import 'package:patientapp/pages/medicaltestf.dart';
import 'package:patientapp/pages/notifications.dart';
import 'package:patientapp/pages/profile.dart';
import 'package:patientapp/utils/colors.dart';
import 'package:patientapp/utils/strings.dart';
import 'package:patientapp/widgets/mynetworkimg.dart';
import 'package:patientapp/widgets/mysvgassetsimg.dart';
import 'package:patientapp/widgets/mytext.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  initState() {
    super.initState();
    appBarTitle = home;
    isHomePage = true;
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
        icon: MySvgAssetsImg(
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
          child: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Notifications()));
            },
            icon: Badge(
              position: BadgePosition.bottomStart(bottom: 8, start: 8),
              badgeColor: white,
              badgeContent: MyText(
                mTitle: '5',
                mFontSize: 8,
                mFontStyle: FontStyle.normal,
                mFontWeight: FontWeight.normal,
                mTextAlign: TextAlign.center,
                mTextColor: primaryColor,
              ),
              child: MySvgAssetsImg(
                imageName: "notification.svg",
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        Visibility(
          visible: isHomePage,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: IconButton(
            onPressed: (() {
              log('Profile tapped!');
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Profile()));
            }),
            icon: CircleAvatar(
                radius: 16,
                backgroundColor: white,
                child: ClipOval(
                  clipBehavior: Clip.antiAlias,
                  child: MyNetworkImage(
                    imageUrl:
                        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
                    fit: BoxFit.cover,
                    imgHeight: 30,
                    imgWidth: 30,
                  ),
                )),
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
      items: <BottomNavigationBarItem>[
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

  // SideDrawer mySideNavDrawer() {
  //   return SideDrawer(
  //     percentage: 0.7,
  //     cornerRadius: 10,
  //     slide: true,
  //     headerView: Container(),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         InkWell(
  //           onTap: () {
  //             log("Tapped on $changePassword");
  //             setState(() {
  //               selectedMenuItemId = menu.items.elementAt(0).id;
  //               log("selectedMenuItemId => $selectedMenuItemId");
  //             });
  //             toggleDrawer();
  //           },
  //           child: Container(
  //             decoration: selectedMenuItemId == menu.items.elementAt(0).id
  //                 ? BoxDecoration(
  //                     color: other50OpacColor,
  //                     borderRadius: BorderRadius.circular(10),
  //                     shape: BoxShape.rectangle,
  //                   )
  //                 : null,
  //             margin: const EdgeInsets.only(left: 15, bottom: 5, right: 15),
  //             width: MediaQuery.of(context).size.width * 0.55,
  //             height: 60,
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               mainAxisSize: MainAxisSize.min,
  //               children: <Widget>[
  //                 const SizedBox(
  //                   width: 10,
  //                 ),
  //                 MySvgAssetsImg(
  //                   imageName: "reset_pw.svg",
  //                   fit: BoxFit.cover,
  //                   imgHeight: 24,
  //                   iconColor: white,
  //                   imgWidth: 24,
  //                 ),
  //                 const SizedBox(
  //                   width: 15,
  //                 ),
  //                 Expanded(
  //                   child: MyText(
  //                     mTitle: menu.items.elementAt(0).title,
  //                     mFontSize: 16,
  //                     mFontStyle: FontStyle.normal,
  //                     mFontWeight: FontWeight.normal,
  //                     mTextColor: white,
  //                     mOverflow: TextOverflow.ellipsis,
  //                     mMaxLine: 2,
  //                     mTextAlign: TextAlign.start,
  //                   ),
  //                 ),
  //                 const SizedBox(
  //                   width: 15,
  //                 ),
  //                 MySvgAssetsImg(
  //                   imageName: "view_more.svg",
  //                   fit: BoxFit.cover,
  //                   imgHeight: 13,
  //                   imgWidth: 7,
  //                   iconColor: white,
  //                 ),
  //                 const SizedBox(
  //                   width: 10,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         InkWell(
  //           onTap: () {
  //             log("Tapped on $scanQRCode");
  //             setState(() {
  //               selectedMenuItemId = menu.items.elementAt(1).id;
  //               log("selectedMenuItemId => $selectedMenuItemId");
  //             });
  //             toggleDrawer();
  //             Navigator.of(context).push(MaterialPageRoute(
  //                 builder: (context) => const QRCodeScanner()));
  //           },
  //           child: Container(
  //             margin: const EdgeInsets.only(left: 15, bottom: 5, right: 15),
  //             width: MediaQuery.of(context).size.width * 0.55,
  //             decoration: selectedMenuItemId == menu.items.elementAt(1).id
  //                 ? BoxDecoration(
  //                     color: other50OpacColor,
  //                     borderRadius: BorderRadius.circular(10),
  //                     shape: BoxShape.rectangle,
  //                   )
  //                 : null,
  //             height: 60,
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               mainAxisSize: MainAxisSize.min,
  //               children: <Widget>[
  //                 const SizedBox(
  //                   width: 10,
  //                 ),
  //                 MySvgAssetsImg(
  //                   imageName: "scanner.svg",
  //                   fit: BoxFit.cover,
  //                   imgHeight: 24,
  //                   imgWidth: 24,
  //                   iconColor: white,
  //                 ),
  //                 const SizedBox(
  //                   width: 15,
  //                 ),
  //                 Expanded(
  //                   child: MyText(
  //                     mTitle: menu.items.elementAt(1).title,
  //                     mFontSize: 16,
  //                     mFontStyle: FontStyle.normal,
  //                     mFontWeight: FontWeight.normal,
  //                     mTextColor: white,
  //                     mOverflow: TextOverflow.ellipsis,
  //                     mMaxLine: 2,
  //                     mTextAlign: TextAlign.start,
  //                   ),
  //                 ),
  //                 const SizedBox(
  //                   width: 15,
  //                 ),
  //                 MySvgAssetsImg(
  //                   imageName: "view_more.svg",
  //                   fit: BoxFit.cover,
  //                   imgHeight: 13,
  //                   imgWidth: 7,
  //                   iconColor: white,
  //                 ),
  //                 const SizedBox(
  //                   width: 10,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         InkWell(
  //           onTap: () {
  //             log("Tapped on $aboutUs");
  //             setState(() {
  //               selectedMenuItemId = menu.items.elementAt(2).id;
  //               log("selectedMenuItemId => $selectedMenuItemId");
  //             });
  //             toggleDrawer();
  //           },
  //           child: Container(
  //             margin: const EdgeInsets.only(left: 15, bottom: 5, right: 15),
  //             width: MediaQuery.of(context).size.width * 0.55,
  //             decoration: selectedMenuItemId == menu.items.elementAt(2).id
  //                 ? BoxDecoration(
  //                     color: other50OpacColor,
  //                     borderRadius: BorderRadius.circular(10),
  //                     shape: BoxShape.rectangle,
  //                   )
  //                 : null,
  //             height: 60,
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               mainAxisSize: MainAxisSize.min,
  //               children: <Widget>[
  //                 const SizedBox(
  //                   width: 10,
  //                 ),
  //                 MySvgAssetsImg(
  //                   imageName: "about_us.svg",
  //                   fit: BoxFit.cover,
  //                   iconColor: white,
  //                   imgHeight: 24,
  //                   imgWidth: 24,
  //                 ),
  //                 const SizedBox(
  //                   width: 15,
  //                 ),
  //                 Expanded(
  //                   child: MyText(
  //                     mTitle: menu.items.elementAt(2).title,
  //                     mFontSize: 16,
  //                     mFontStyle: FontStyle.normal,
  //                     mFontWeight: FontWeight.normal,
  //                     mTextColor: white,
  //                     mOverflow: TextOverflow.ellipsis,
  //                     mMaxLine: 2,
  //                     mTextAlign: TextAlign.start,
  //                   ),
  //                 ),
  //                 const SizedBox(
  //                   width: 15,
  //                 ),
  //                 MySvgAssetsImg(
  //                   imageName: "view_more.svg",
  //                   fit: BoxFit.cover,
  //                   imgHeight: 13,
  //                   imgWidth: 7,
  //                   iconColor: white,
  //                 ),
  //                 const SizedBox(
  //                   width: 10,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         InkWell(
  //           onTap: () {
  //             log("Tapped on $termConditions");
  //             setState(() {
  //               selectedMenuItemId = menu.items.elementAt(3).id;
  //               log("selectedMenuItemId => $selectedMenuItemId");
  //             });
  //             toggleDrawer();
  //           },
  //           child: Container(
  //             margin: const EdgeInsets.only(left: 15, bottom: 5, right: 15),
  //             width: MediaQuery.of(context).size.width * 0.55,
  //             decoration: selectedMenuItemId == menu.items.elementAt(3).id
  //                 ? BoxDecoration(
  //                     color: other50OpacColor,
  //                     borderRadius: BorderRadius.circular(10),
  //                     shape: BoxShape.rectangle,
  //                   )
  //                 : null,
  //             height: 60,
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               mainAxisSize: MainAxisSize.min,
  //               children: <Widget>[
  //                 const SizedBox(
  //                   width: 10,
  //                 ),
  //                 MySvgAssetsImg(
  //                   imageName: "t_and_c.svg",
  //                   fit: BoxFit.cover,
  //                   imgHeight: 24,
  //                   iconColor: white,
  //                   imgWidth: 24,
  //                 ),
  //                 const SizedBox(
  //                   width: 15,
  //                 ),
  //                 Expanded(
  //                   child: MyText(
  //                     mTitle: menu.items.elementAt(3).title,
  //                     mFontSize: 16,
  //                     mFontStyle: FontStyle.normal,
  //                     mFontWeight: FontWeight.normal,
  //                     mTextColor: white,
  //                     mOverflow: TextOverflow.ellipsis,
  //                     mMaxLine: 2,
  //                     mTextAlign: TextAlign.start,
  //                   ),
  //                 ),
  //                 const SizedBox(
  //                   width: 15,
  //                 ),
  //                 MySvgAssetsImg(
  //                   imageName: "view_more.svg",
  //                   fit: BoxFit.cover,
  //                   imgHeight: 13,
  //                   imgWidth: 7,
  //                   iconColor: white,
  //                 ),
  //                 const SizedBox(
  //                   width: 10,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         InkWell(
  //           onTap: () {
  //             log("Tapped on $reportIssues");
  //             setState(() {
  //               selectedMenuItemId = menu.items.elementAt(4).id;
  //               log("selectedMenuItemId => $selectedMenuItemId");
  //             });
  //             toggleDrawer();
  //           },
  //           child: Container(
  //             margin: const EdgeInsets.only(left: 15, bottom: 5, right: 15),
  //             width: MediaQuery.of(context).size.width * 0.55,
  //             decoration: selectedMenuItemId == menu.items.elementAt(4).id
  //                 ? BoxDecoration(
  //                     color: other50OpacColor,
  //                     borderRadius: BorderRadius.circular(10),
  //                     shape: BoxShape.rectangle,
  //                   )
  //                 : null,
  //             height: 60,
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               mainAxisSize: MainAxisSize.min,
  //               children: <Widget>[
  //                 const SizedBox(
  //                   width: 10,
  //                 ),
  //                 MySvgAssetsImg(
  //                   imageName: "report_issue.svg",
  //                   fit: BoxFit.cover,
  //                   imgHeight: 24,
  //                   iconColor: white,
  //                   imgWidth: 24,
  //                 ),
  //                 const SizedBox(
  //                   width: 15,
  //                 ),
  //                 Expanded(
  //                   child: MyText(
  //                     mTitle: menu.items.elementAt(4).title,
  //                     mFontSize: 16,
  //                     mFontStyle: FontStyle.normal,
  //                     mFontWeight: FontWeight.normal,
  //                     mTextColor: white,
  //                     mOverflow: TextOverflow.ellipsis,
  //                     mMaxLine: 2,
  //                     mTextAlign: TextAlign.start,
  //                   ),
  //                 ),
  //                 const SizedBox(
  //                   width: 15,
  //                 ),
  //                 MySvgAssetsImg(
  //                   imageName: "view_more.svg",
  //                   fit: BoxFit.cover,
  //                   imgHeight: 13,
  //                   imgWidth: 7,
  //                   iconColor: white,
  //                 ),
  //                 const SizedBox(
  //                   width: 10,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         InkWell(
  //           onTap: () {
  //             log("Tapped on $helpCenter");
  //             setState(() {
  //               selectedMenuItemId = menu.items.elementAt(5).id;
  //               log("selectedMenuItemId => $selectedMenuItemId");
  //             });
  //             toggleDrawer();
  //           },
  //           child: Container(
  //             margin: const EdgeInsets.only(left: 15, bottom: 5, right: 15),
  //             width: MediaQuery.of(context).size.width * 0.55,
  //             decoration: selectedMenuItemId == menu.items.elementAt(5).id
  //                 ? BoxDecoration(
  //                     color: other50OpacColor,
  //                     borderRadius: BorderRadius.circular(10),
  //                     shape: BoxShape.rectangle,
  //                   )
  //                 : null,
  //             height: 60,
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               mainAxisSize: MainAxisSize.min,
  //               children: <Widget>[
  //                 const SizedBox(
  //                   width: 10,
  //                 ),
  //                 MySvgAssetsImg(
  //                   imageName: "help_center.svg",
  //                   fit: BoxFit.cover,
  //                   imgHeight: 24,
  //                   imgWidth: 24,
  //                   iconColor: white,
  //                 ),
  //                 const SizedBox(
  //                   width: 15,
  //                 ),
  //                 Expanded(
  //                   child: MyText(
  //                     mTitle: menu.items.elementAt(5).title,
  //                     mFontSize: 16,
  //                     mFontStyle: FontStyle.normal,
  //                     mFontWeight: FontWeight.normal,
  //                     mTextColor: white,
  //                     mOverflow: TextOverflow.ellipsis,
  //                     mMaxLine: 2,
  //                     mTextAlign: TextAlign.start,
  //                   ),
  //                 ),
  //                 const SizedBox(
  //                   width: 15,
  //                 ),
  //                 MySvgAssetsImg(
  //                   imageName: "view_more.svg",
  //                   fit: BoxFit.cover,
  //                   imgHeight: 13,
  //                   imgWidth: 7,
  //                   iconColor: white,
  //                 ),
  //                 const SizedBox(
  //                   width: 10,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //     footerView: InkWell(
  //       onTap: () {
  //         log("Tapped on $logout");
  //         setState(() {
  //           selectedMenuItemId = menu.items.elementAt(6).id;
  //           log("selectedMenuItemId => $selectedMenuItemId");
  //         });
  //         toggleDrawer();
  //       },
  //       child: Container(
  //         margin: const EdgeInsets.only(left: 15, right: 15),
  //         width: MediaQuery.of(context).size.width * 0.55,
  //         decoration: selectedMenuItemId == menu.items.elementAt(6).id
  //             ? BoxDecoration(
  //                 color: other50OpacColor,
  //                 borderRadius: BorderRadius.circular(10),
  //                 shape: BoxShape.rectangle,
  //               )
  //             : null,
  //         height: 60,
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           mainAxisSize: MainAxisSize.min,
  //           children: <Widget>[
  //             const SizedBox(
  //               width: 10,
  //             ),
  //             MySvgAssetsImg(
  //               imageName: "logout.svg",
  //               fit: BoxFit.cover,
  //               imgHeight: 24,
  //               imgWidth: 24,
  //               iconColor: white,
  //             ),
  //             const SizedBox(
  //               width: 15,
  //             ),
  //             Expanded(
  //               child: MyText(
  //                 mTitle: menu.items.elementAt(6).title,
  //                 mFontSize: 16,
  //                 mFontStyle: FontStyle.normal,
  //                 mFontWeight: FontWeight.normal,
  //                 mTextColor: white,
  //                 mOverflow: TextOverflow.ellipsis,
  //                 mMaxLine: 2,
  //                 mTextAlign: TextAlign.start,
  //               ),
  //             ),
  //             const SizedBox(
  //               width: 10,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //     direction: Direction.left,
  //     animation: true,
  //     color: drawerStartColor,
  //     selectedItemId: selectedMenuItemId,
  //   );
  // }

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
