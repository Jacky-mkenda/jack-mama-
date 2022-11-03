import 'dart:developer';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patientapp/pages/appointmentdetails.dart';
import 'package:patientapp/pages/bookappointment.dart';
import 'package:patientapp/pages/doctordetails.dart';
import 'package:patientapp/pages/noappointments.dart';
import 'package:patientapp/pages/nodata.dart';
import 'package:patientapp/pages/viewall.dart';
import 'package:patientapp/provider/homeprovider.dart';
import 'package:patientapp/utils/colors.dart';
import 'package:patientapp/utils/constant.dart';
import 'package:patientapp/utils/strings.dart';
import 'package:patientapp/utils/utility.dart';
import 'package:patientapp/widgets/mynetworkimg.dart';
import 'package:patientapp/widgets/mysvgassetsimg.dart';
import 'package:patientapp/widgets/mytext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeF extends StatefulWidget {
  const HomeF({Key? key}) : super(key: key);

  @override
  State<HomeF> createState() => _HomeFState();
}

class _HomeFState extends State<HomeF> {
  late bool isSearching;
  final mSearchController = TextEditingController();

  @override
  void initState() {
    isSearching = false;
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.getPatientProfile();
    homeProvider.getSpecialities();
    homeProvider.getUpcomingAppointment();
    homeProvider.getUpcomingTestAppointment();
    homeProvider.getDoctor();
    super.initState();
  }

  @override
  void dispose() {
    mSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
            minWidth: MediaQuery.of(context).size.width,
          ),
          decoration: Utility.topRoundBG(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Consumer<HomeProvider>(
                  builder: (context, homeProvider, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          mTitle: !homeProvider.loading
                              ? homeProvider.profileModel.status == 200
                                  ? homeProvider.profileModel.result != null
                                      ? homeProvider
                                              .profileModel.result!.isNotEmpty
                                          ? ("Hi, ${homeProvider.profileModel.result!.elementAt(0).fullname ?? guestUser}")
                                          : ("Hi, $guestUser")
                                      : ("Hi, $guestUser")
                                  : ("Hi, $guestUser")
                              : ("Hi, $guestUser"),
                          mTextColor: textTitleColor,
                          mTextAlign: TextAlign.start,
                          mFontWeight: FontWeight.normal,
                          mFontSize: 20,
                        ),
                        const MyText(
                          mTitle: welcomeBack,
                          mTextColor: textTitleColor,
                          mTextAlign: TextAlign.start,
                          mFontWeight: FontWeight.bold,
                          mFontSize: 22,
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 14),
              Container(
                height: 50,
                margin: const EdgeInsets.only(left: 20, right: 20),
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(5),
                  shape: BoxShape.rectangle,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 5),
                      blurRadius: 15,
                      spreadRadius: 2,
                      color: shadowColor.withOpacity(0.05),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: mSearchController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        obscureText: false,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        readOnly: false,
                        onFieldSubmitted: (searchedText) async {
                          log("searchedText ==> $searchedText");
                          if (searchedText.toString().isNotEmpty) {
                            setState(() {
                              isSearching = true;
                            });
                            final homeProvider = Provider.of<HomeProvider>(
                                context,
                                listen: false);
                            await homeProvider
                                .getSearchedDoctor(searchedText.toString());
                          }
                        },
                        decoration: InputDecoration(
                          hintText: searchHint,
                          hintStyle: GoogleFonts.roboto(
                            fontSize: 16,
                            color: textEdtHintColor,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                          ),
                          border: InputBorder.none,
                        ),
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            color: textTitleColor,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        log("isSearching ======> $isSearching");
                        if (isSearching) {
                          setState(() {
                            isSearching = false;
                          });
                        }
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(5),
                          shape: BoxShape.rectangle,
                        ),
                        child: MySvgAssetsImg(
                          imageName: !isSearching ? 'search.svg' : 'close.svg',
                          imgHeight: 18,
                          imgWidth: 18,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              /* All Data */
              Visibility(
                visible: !isSearching,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          const MyText(
                            mTitle: speciality,
                            mFontSize: 16,
                            mFontWeight: FontWeight.bold,
                            mOverflow: TextOverflow.ellipsis,
                            mTextAlign: TextAlign.start,
                            mTextColor: textTitleColor,
                          ),
                          InkWell(
                            onTap: () {
                              log("Tapped on $seeAll");
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const ViewAll(
                                    appBarTitle: speciality,
                                    layoutType: "Speciality",
                                    searchedText: "",
                                  ),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(5),
                            child: const MyText(
                              mTitle: seeAll,
                              mFontSize: 16,
                              mFontWeight: FontWeight.normal,
                              mOverflow: TextOverflow.ellipsis,
                              mTextAlign: TextAlign.end,
                              mTextColor: textSeeAllColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    specialityList(),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          const MyText(
                            mTitle: upcomingAppointments,
                            mFontSize: 16,
                            mFontWeight: FontWeight.bold,
                            mOverflow: TextOverflow.ellipsis,
                            mTextAlign: TextAlign.start,
                            mTextColor: textTitleColor,
                          ),
                          InkWell(
                            onTap: () {
                              log("Tapped on $seeAll");
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const ViewAll(
                                    appBarTitle: upcomingAppointments,
                                    layoutType: "Appointment",
                                    searchedText: "",
                                  ),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(5),
                            child: const MyText(
                              mTitle: seeAll,
                              mFontSize: 16,
                              mFontWeight: FontWeight.normal,
                              mOverflow: TextOverflow.ellipsis,
                              mTextAlign: TextAlign.end,
                              mTextColor: textSeeAllColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    upcomingAppintmentList(),
                    const SizedBox(height: 24),
                    // Container(
                    //   padding: const EdgeInsets.only(left: 20, right: 20),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     mainAxisSize: MainAxisSize.max,
                    //     children: <Widget>[
                    //       const MyText(
                    //         mTitle: upcomingTests,
                    //         mFontSize: 16,
                    //         mFontWeight: FontWeight.bold,
                    //         mOverflow: TextOverflow.ellipsis,
                    //         mTextAlign: TextAlign.start,
                    //         mTextColor: textTitleColor,
                    //       ),
                    //       InkWell(
                    //         onTap: () {
                    //           log("Tapped on $seeAll");
                    //           Navigator.of(context).push(
                    //             MaterialPageRoute(
                    //               builder: (context) => const ViewAll(
                    //                 appBarTitle: upcomingTests,
                    //                 layoutType: "Test",
                    //                 searchedText: "",
                    //               ),
                    //             ),
                    //           );
                    //         },
                    //         borderRadius: BorderRadius.circular(5),
                    //         child: const MyText(
                    //           mTitle: seeAll,
                    //           mFontSize: 16,
                    //           mFontWeight: FontWeight.normal,
                    //           mOverflow: TextOverflow.ellipsis,
                    //           mTextAlign: TextAlign.end,
                    //           mTextColor: textSeeAllColor,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // const SizedBox(height: 8),
                    // upcomingTestList(),
                    // const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          const MyText(
                            mTitle: availableDoctors,
                            mFontSize: 16,
                            mFontWeight: FontWeight.bold,
                            mOverflow: TextOverflow.ellipsis,
                            mTextAlign: TextAlign.start,
                            mTextColor: textTitleColor,
                          ),
                          InkWell(
                            onTap: () {
                              log("Tapped on $seeAll");
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const ViewAll(
                                    appBarTitle: availableDoctors,
                                    layoutType: "Doctors",
                                    searchedText: "",
                                  ),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(5),
                            child: const MyText(
                              mTitle: seeAll,
                              mFontSize: 16,
                              mFontWeight: FontWeight.normal,
                              mOverflow: TextOverflow.ellipsis,
                              mTextAlign: TextAlign.end,
                              mTextColor: textSeeAllColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    availableDoctorList(),
                    const SizedBox(height: 8),
                  ],
                ),
              ),

              /* Searched Doctors */
              Visibility(
                visible: isSearching,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          const MyText(
                            mTitle: availableDoctors,
                            mFontSize: 16,
                            mFontWeight: FontWeight.bold,
                            mOverflow: TextOverflow.ellipsis,
                            mTextAlign: TextAlign.start,
                            mTextColor: textTitleColor,
                          ),
                          InkWell(
                            onTap: () {
                              log("Tapped on $seeAll");
                              log("mSearchController Text :==> ${mSearchController.text.toString()}");
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ViewAll(
                                    appBarTitle: availableDoctors,
                                    layoutType: "BySearch",
                                    searchedText:
                                        mSearchController.text.toString(),
                                  ),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(5),
                            child: const MyText(
                              mTitle: seeAll,
                              mFontSize: 16,
                              mFontWeight: FontWeight.normal,
                              mOverflow: TextOverflow.ellipsis,
                              mTextAlign: TextAlign.end,
                              mTextColor: textSeeAllColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    searchedDoctorList(),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget specialityList() {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, child) {
        if (!homeProvider.loading) {
          if (homeProvider.specialityModel.status == 200 &&
              homeProvider.specialityModel.result != null) {
            if (homeProvider.specialityModel.result!.isNotEmpty) {
              return Container(
                constraints: const BoxConstraints(
                  minHeight: 90,
                  maxHeight: 90,
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: homeProvider.specialityModel.result!.length,
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 10,
                  ),
                  itemBuilder: (BuildContext context, int position) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        log("Item Clicked! => $position");
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ViewAll(
                              appBarTitle: homeProvider.specialityModel.result!
                                      .elementAt(position)
                                      .name ??
                                  "",
                              layoutType: 'BySearch',
                              searchedText: homeProvider.specialityModel.result!
                                      .elementAt(position)
                                      .name ??
                                  "",
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 95,
                        width: 85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            image: ExactAssetImage(
                              Constant.gradientBG.elementAt(position % 8),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            MyNetworkImage(
                              imageUrl: homeProvider.specialityModel.result!
                                      .elementAt(position)
                                      .image ??
                                  "",
                              fit: BoxFit.cover,
                              imgHeight: 32,
                              imgWidth: 32,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 3, right: 3),
                              child: MyText(
                                mTitle: homeProvider.specialityModel.result!
                                        .elementAt(position)
                                        .name ??
                                    "",
                                mFontSize: 12,
                                mMaxLine: 1,
                                mOverflow: TextOverflow.ellipsis,
                                mFontStyle: FontStyle.normal,
                                mFontWeight: FontWeight.w500,
                                mTextAlign: TextAlign.center,
                                mTextColor: white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return const NoData();
            }
          } else {
            return const NoData();
          }
        } else {
          return Utility.pageLoader();
        }
      },
    );
  }

  Widget upcomingAppintmentList() {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, child) {
        if (!homeProvider.loading) {
          if (homeProvider.appointmentModel.status == 200 &&
              homeProvider.appointmentModel.result != null) {
            if (homeProvider.appointmentModel.result!.isNotEmpty) {
              return Container(
                constraints: const BoxConstraints(
                  minHeight: 105,
                  maxHeight: 110,
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(left: 18, right: 18),
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 3,
                  ),
                  itemCount: homeProvider.appointmentModel.result!.length,
                  itemBuilder: (BuildContext context, int position) {
                    return Container(
                      padding: const EdgeInsets.only(top: 12),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          log("Item Clicked!");
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AppointmentDetails(
                                  homeProvider.appointmentModel.result
                                          ?.elementAt(position)
                                          .id ??
                                      ""),
                            ),
                          );
                        },
                        child: Stack(
                          children: <Widget>[
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: 82,
                                minWidth:
                                    MediaQuery.of(context).size.width * 0.5,
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.9,
                              ),
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                elevation: 3,
                                color: white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 60),
                                              alignment: Alignment.topLeft,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  MyText(
                                                    mTitle: homeProvider
                                                            .appointmentModel
                                                            .result
                                                            ?.elementAt(
                                                                position)
                                                            .doctorName ??
                                                        "-",
                                                    mFontSize: 14,
                                                    mFontWeight:
                                                        FontWeight.bold,
                                                    mTextAlign: TextAlign.start,
                                                    mTextColor: textTitleColor,
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      MyText(
                                                        mTitle: homeProvider
                                                                .appointmentModel
                                                                .result
                                                                ?.elementAt(
                                                                    position)
                                                                .specialitiesName ??
                                                            "-",
                                                        mFontSize: 12,
                                                        mFontWeight:
                                                            FontWeight.normal,
                                                        mTextAlign:
                                                            TextAlign.start,
                                                        mTextColor:
                                                            otherLightColor,
                                                      ),
                                                      const SizedBox(
                                                        width: 4,
                                                      ),
                                                      Container(
                                                        width: 4,
                                                        height: 4,
                                                        decoration:
                                                            const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color:
                                                              otherLightColor,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 4,
                                                      ),
                                                      MyText(
                                                        mTitle: homeProvider
                                                                    .appointmentModel
                                                                    .result
                                                                    ?.elementAt(
                                                                        position)
                                                                    .status
                                                                    .toString() ==
                                                                "1"
                                                            ? pending
                                                            : (homeProvider
                                                                        .appointmentModel
                                                                        .result
                                                                        ?.elementAt(
                                                                            position)
                                                                        .status
                                                                        .toString() ==
                                                                    "2"
                                                                ? approved
                                                                : (homeProvider
                                                                            .appointmentModel
                                                                            .result
                                                                            ?.elementAt(
                                                                                position)
                                                                            .status
                                                                            .toString() ==
                                                                        "3"
                                                                    ? rejected
                                                                    : homeProvider.appointmentModel.result?.elementAt(position).status.toString() ==
                                                                            "4"
                                                                        ? absent
                                                                        : (homeProvider.appointmentModel.result?.elementAt(position).status.toString() ==
                                                                                "5"
                                                                            ? completed
                                                                            : "-"))),
                                                        mFontSize: 12,
                                                        mFontWeight:
                                                            FontWeight.normal,
                                                        mTextAlign:
                                                            TextAlign.start,
                                                        mTextColor: homeProvider
                                                                    .appointmentModel
                                                                    .result
                                                                    ?.elementAt(
                                                                        position)
                                                                    .status
                                                                    .toString() ==
                                                                "1"
                                                            ? pendingStatus
                                                            : (homeProvider
                                                                        .appointmentModel
                                                                        .result
                                                                        ?.elementAt(
                                                                            position)
                                                                        .status
                                                                        .toString() ==
                                                                    "2"
                                                                ? approvedStatus
                                                                : (homeProvider
                                                                            .appointmentModel
                                                                            .result
                                                                            ?.elementAt(
                                                                                position)
                                                                            .status
                                                                            .toString() ==
                                                                        "3"
                                                                    ? rejectedStatus
                                                                    : homeProvider.appointmentModel.result?.elementAt(position).status.toString() ==
                                                                            "4"
                                                                        ? absentStatus
                                                                        : (homeProvider.appointmentModel.result?.elementAt(position).status.toString() ==
                                                                                "5"
                                                                            ? completedStatus
                                                                            : black))),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 13,
                                            ),
                                            Container(
                                              alignment: Alignment.topLeft,
                                              child: MyText(
                                                mTitle:
                                                    '${Utility.formateDate((homeProvider.appointmentModel.result!.elementAt(position).date ?? "").toString())} at ${Utility.formateTime((homeProvider.appointmentModel.result!.elementAt(position).startTime ?? ""))} - ${Utility.formateTime((homeProvider.appointmentModel.result!.elementAt(position).endTime ?? ""))}',
                                                mFontSize: 13,
                                                mOverflow:
                                                    TextOverflow.ellipsis,
                                                mMaxLine: 1,
                                                mFontWeight: FontWeight.normal,
                                                mTextAlign: TextAlign.start,
                                                mTextColor: textTitleColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      // CupertinoButton(
                                      //   minSize: double.minPositive,
                                      //   padding: EdgeInsets.zero,
                                      //   child: const MySvgAssetsImg(
                                      //     imageName: "delete.svg",
                                      //     fit: BoxFit.cover,
                                      //     imgHeight: 25,
                                      //     imgWidth: 25,
                                      //   ),
                                      //   onPressed: () {
                                      //     log("on Delete Click!");
                                      //   },
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              transform: Matrix4.translationValues(12, -10, 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4.0),
                                clipBehavior: Clip.antiAlias,
                                child: MyNetworkImage(
                                  imageUrl: homeProvider.appointmentModel.result
                                          ?.elementAt(position)
                                          .doctorImage
                                          .toString() ??
                                      Constant.userPlaceholder,
                                  fit: BoxFit.fill,
                                  imgHeight: 61,
                                  imgWidth: 54,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return const NoAppointments();
            }
          } else {
            return const NoAppointments();
          }
        } else {
          return Utility.pageLoader();
        }
      },
    );
  }

  Widget upcomingTestList() {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, child) {
        if (!homeProvider.loading) {
          if (homeProvider.testAppointmentModel.status == 200 &&
              homeProvider.testAppointmentModel.result != null) {
            if (homeProvider.testAppointmentModel.result!.isNotEmpty) {
              return Container(
                constraints: const BoxConstraints(
                  minHeight: 110,
                  maxHeight: 120,
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(left: 18, right: 18),
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 3,
                  ),
                  itemCount: homeProvider.testAppointmentModel.result!.length,
                  itemBuilder: (BuildContext context, int position) {
                    return Container(
                      padding: const EdgeInsets.only(top: 12),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          log("Item Clicked!");
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) => const HistoryDetails(),
                          //   ),
                          // );
                        },
                        child: Stack(
                          children: <Widget>[
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: 82,
                                minWidth:
                                    MediaQuery.of(context).size.width * 0.5,
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.9,
                              ),
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                elevation: 3,
                                color: white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 60),
                                              alignment: Alignment.topLeft,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  MyText(
                                                    mTitle: homeProvider
                                                            .testAppointmentModel
                                                            .result
                                                            ?.elementAt(
                                                                position)
                                                            .patientsName ??
                                                        "",
                                                    mFontSize: 14,
                                                    mFontWeight:
                                                        FontWeight.bold,
                                                    mTextAlign: TextAlign.start,
                                                    mTextColor: textTitleColor,
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      MyText(
                                                        mTitle: homeProvider
                                                                .testAppointmentModel
                                                                .result
                                                                ?.elementAt(
                                                                    position)
                                                                .patientsMobileNumber ??
                                                            "-",
                                                        mFontSize: 12,
                                                        mFontWeight:
                                                            FontWeight.normal,
                                                        mTextAlign:
                                                            TextAlign.start,
                                                        mTextColor:
                                                            otherLightColor,
                                                      ),
                                                      const SizedBox(
                                                        width: 4,
                                                      ),
                                                      Container(
                                                        width: 4,
                                                        height: 4,
                                                        decoration:
                                                            const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color:
                                                              otherLightColor,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 4,
                                                      ),
                                                      MyText(
                                                        mTitle: homeProvider
                                                                    .testAppointmentModel
                                                                    .result
                                                                    ?.elementAt(
                                                                        position)
                                                                    .status
                                                                    .toString() ==
                                                                "1"
                                                            ? pending
                                                            : (homeProvider
                                                                        .testAppointmentModel
                                                                        .result
                                                                        ?.elementAt(
                                                                            position)
                                                                        .status
                                                                        .toString() ==
                                                                    "2"
                                                                ? approved
                                                                : (homeProvider
                                                                            .testAppointmentModel
                                                                            .result
                                                                            ?.elementAt(
                                                                                position)
                                                                            .status
                                                                            .toString() ==
                                                                        "3"
                                                                    ? rejected
                                                                    : homeProvider.testAppointmentModel.result?.elementAt(position).status.toString() ==
                                                                            "4"
                                                                        ? absent
                                                                        : (homeProvider.testAppointmentModel.result?.elementAt(position).status.toString() ==
                                                                                "5"
                                                                            ? completed
                                                                            : "-"))),
                                                        mFontSize: 12,
                                                        mFontWeight:
                                                            FontWeight.normal,
                                                        mTextAlign:
                                                            TextAlign.start,
                                                        mTextColor: homeProvider
                                                                    .testAppointmentModel
                                                                    .result
                                                                    ?.elementAt(
                                                                        position)
                                                                    .status
                                                                    .toString() ==
                                                                "1"
                                                            ? pendingStatus
                                                            : (homeProvider
                                                                        .testAppointmentModel
                                                                        .result
                                                                        ?.elementAt(
                                                                            position)
                                                                        .status
                                                                        .toString() ==
                                                                    "2"
                                                                ? approvedStatus
                                                                : (homeProvider
                                                                            .testAppointmentModel
                                                                            .result
                                                                            ?.elementAt(
                                                                                position)
                                                                            .status
                                                                            .toString() ==
                                                                        "3"
                                                                    ? rejectedStatus
                                                                    : homeProvider.testAppointmentModel.result?.elementAt(position).status.toString() ==
                                                                            "4"
                                                                        ? absentStatus
                                                                        : (homeProvider.testAppointmentModel.result?.elementAt(position).status.toString() ==
                                                                                "5"
                                                                            ? completedStatus
                                                                            : black))),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 13,
                                            ),
                                            Container(
                                              alignment: Alignment.topLeft,
                                              child: MyText(
                                                mTitle:
                                                    '${Utility.formateDate((homeProvider.testAppointmentModel.result!.elementAt(position).date ?? "").toString())} at ${Utility.formateTime((homeProvider.testAppointmentModel.result!.elementAt(position).startTime ?? ""))} - ${Utility.formateTime((homeProvider.testAppointmentModel.result!.elementAt(position).endTime ?? ""))}',
                                                mFontSize: 13,
                                                mOverflow:
                                                    TextOverflow.ellipsis,
                                                mMaxLine: 1,
                                                mFontWeight: FontWeight.normal,
                                                mTextAlign: TextAlign.start,
                                                mTextColor: textTitleColor,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                const MySvgAssetsImg(
                                                  imageName: "test_desc.svg",
                                                  fit: BoxFit.cover,
                                                  imgHeight: 15,
                                                  imgWidth: 15,
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Flexible(
                                                  child: MyText(
                                                    mTitle: homeProvider
                                                            .testAppointmentModel
                                                            .result!
                                                            .elementAt(position)
                                                            .description ??
                                                        "-",
                                                    mFontSize: 12,
                                                    mMaxLine: 1,
                                                    mOverflow:
                                                        TextOverflow.ellipsis,
                                                    mFontWeight:
                                                        FontWeight.normal,
                                                    mTextAlign: TextAlign.start,
                                                    mTextColor: otherColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      // CupertinoButton(
                                      //   minSize: double.minPositive,
                                      //   padding: EdgeInsets.zero,
                                      //   child: const MySvgAssetsImg(
                                      //     imageName: "delete.svg",
                                      //     fit: BoxFit.cover,
                                      //     imgHeight: 25,
                                      //     imgWidth: 25,
                                      //   ),
                                      //   onPressed: () {
                                      //     log("on Delete Click!");
                                      //   },
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              transform: Matrix4.translationValues(12, -10, 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4.0),
                                clipBehavior: Clip.antiAlias,
                                child: MyNetworkImage(
                                  imageUrl: homeProvider
                                          .testAppointmentModel.result
                                          ?.elementAt(position)
                                          .patientsProfileImg
                                          .toString() ??
                                      Constant.userPlaceholder,
                                  fit: BoxFit.fill,
                                  imgHeight: 61,
                                  imgWidth: 54,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return const NoData();
            }
          } else {
            return const NoData();
          }
        } else {
          return Utility.pageLoader();
        }
      },
    );
  }

  Widget availableDoctorList() {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, child) {
        if (!homeProvider.loading) {
          if (homeProvider.doctorModel.status == 200 &&
              homeProvider.doctorModel.result != null) {
            if (homeProvider.doctorModel.result!.isNotEmpty) {
              return Container(
                constraints: const BoxConstraints(
                  minHeight: 0,
                ),
                child: AlignedGridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 20,
                  padding:
                      const EdgeInsets.only(left: 18, right: 18, bottom: 20),
                  itemCount: homeProvider.doctorModel.result!.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int position) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        log("Item Clicked! => $position");
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DoctorDetails(homeProvider
                                    .doctorModel.result
                                    ?.elementAt(position)
                                    .id ??
                                ""),
                          ),
                        );
                      },
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        clipBehavior: Clip.antiAlias,
                        children: <Widget>[
                          Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: 3,
                            color: white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Container(
                              constraints: const BoxConstraints(
                                minHeight: 215,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    height: 145,
                                    width: MediaQuery.of(context).size.width,
                                    child: MyNetworkImage(
                                      imageUrl: homeProvider.doctorModel.result
                                              ?.elementAt(position)
                                              .doctorImage ??
                                          Constant.userPlaceholder,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        const SizedBox(height: 4),
                                        MyText(
                                          mTitle:
                                              "${homeProvider.doctorModel.result?.elementAt(position).firstName ?? "-"} ${homeProvider.doctorModel.result?.elementAt(position).lastName ?? "-"}",
                                          mFontSize: 15,
                                          mMaxLine: 1,
                                          mOverflow: TextOverflow.ellipsis,
                                          mFontWeight: FontWeight.normal,
                                          mTextAlign: TextAlign.center,
                                          mTextColor: textTitleColor,
                                        ),
                                        const SizedBox(height: 2),
                                        MyText(
                                          mTitle: homeProvider
                                                  .doctorModel.result
                                                  ?.elementAt(position)
                                                  .specialitiesName ??
                                              "-",
                                          mFontSize: 12,
                                          mFontWeight: FontWeight.normal,
                                          mMaxLine: 1,
                                          mOverflow: TextOverflow.ellipsis,
                                          mTextAlign: TextAlign.center,
                                          mTextColor: otherColor,
                                        ),
                                        const SizedBox(height: 25),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              log("Item Clicked! => $position");
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => BookAppointment(
                                    homeProvider.doctorModel.result!
                                            .elementAt(position)
                                            .id ??
                                        "",
                                    "${homeProvider.doctorModel.result!.elementAt(position).firstName} ${homeProvider.doctorModel.result!.elementAt(position).lastName}",
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              transform: Matrix4.translationValues(0, 10, 0),
                              padding: const EdgeInsets.fromLTRB(23, 8, 23, 8),
                              decoration: Utility.primaryButton(),
                              clipBehavior: Clip.antiAlias,
                              child: const MyText(
                                mTitle: bookNow,
                                mFontSize: 12,
                                mFontStyle: FontStyle.normal,
                                mFontWeight: FontWeight.normal,
                                mMaxLine: 1,
                                mOverflow: TextOverflow.ellipsis,
                                mTextColor: white,
                                mTextAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            } else {
              return const NoData();
            }
          } else {
            return const NoData();
          }
        } else {
          return Utility.pageLoader();
        }
      },
    );
  }

  Widget searchedDoctorList() {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, child) {
        if (!homeProvider.loading) {
          if (homeProvider.searchedDoctorModel.status == 200 &&
              homeProvider.searchedDoctorModel.result != null) {
            if (homeProvider.searchedDoctorModel.result!.isNotEmpty) {
              return Container(
                constraints: const BoxConstraints(
                  minHeight: 0,
                ),
                child: AlignedGridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 20,
                  padding:
                      const EdgeInsets.only(left: 18, right: 18, bottom: 20),
                  itemCount: homeProvider.searchedDoctorModel.result!.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int position) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        log("Item Clicked! => $position");
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DoctorDetails(homeProvider
                                    .searchedDoctorModel.result
                                    ?.elementAt(position)
                                    .id ??
                                ""),
                          ),
                        );
                      },
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        clipBehavior: Clip.antiAlias,
                        children: <Widget>[
                          Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: 3,
                            color: white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Container(
                              constraints: const BoxConstraints(
                                minHeight: 215,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    height: 145,
                                    width: MediaQuery.of(context).size.width,
                                    child: MyNetworkImage(
                                      imageUrl: homeProvider
                                              .searchedDoctorModel.result
                                              ?.elementAt(position)
                                              .doctorImage ??
                                          Constant.userPlaceholder,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        const SizedBox(height: 4),
                                        MyText(
                                          mTitle:
                                              "${homeProvider.searchedDoctorModel.result?.elementAt(position).firstName ?? "-"} ${homeProvider.searchedDoctorModel.result?.elementAt(position).lastName ?? "-"}",
                                          mFontSize: 15,
                                          mMaxLine: 1,
                                          mOverflow: TextOverflow.ellipsis,
                                          mFontWeight: FontWeight.normal,
                                          mTextAlign: TextAlign.center,
                                          mTextColor: textTitleColor,
                                        ),
                                        const SizedBox(height: 2),
                                        MyText(
                                          mTitle: homeProvider
                                                  .searchedDoctorModel.result
                                                  ?.elementAt(position)
                                                  .specialitiesName ??
                                              "-",
                                          mFontSize: 12,
                                          mFontWeight: FontWeight.normal,
                                          mMaxLine: 1,
                                          mOverflow: TextOverflow.ellipsis,
                                          mTextAlign: TextAlign.center,
                                          mTextColor: otherColor,
                                        ),
                                        const SizedBox(height: 25),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              log("Item Clicked! => $position");
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => BookAppointment(
                                    homeProvider.searchedDoctorModel.result!
                                            .elementAt(position)
                                            .id ??
                                        "",
                                    "${homeProvider.searchedDoctorModel.result!.elementAt(position).firstName} ${homeProvider.searchedDoctorModel.result!.elementAt(position).lastName}",
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              transform: Matrix4.translationValues(0, 10, 0),
                              padding: const EdgeInsets.fromLTRB(23, 8, 23, 8),
                              decoration: Utility.primaryButton(),
                              clipBehavior: Clip.antiAlias,
                              child: const MyText(
                                mTitle: bookNow,
                                mFontSize: 12,
                                mFontStyle: FontStyle.normal,
                                mFontWeight: FontWeight.normal,
                                mMaxLine: 1,
                                mOverflow: TextOverflow.ellipsis,
                                mTextColor: white,
                                mTextAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            } else {
              return const NoData();
            }
          } else {
            return const NoData();
          }
        } else {
          return Utility.pageLoader();
        }
      },
    );
  }
}
