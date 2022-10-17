import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:patientapp/pages/appointmentdetails.dart';
import 'package:patientapp/pages/bookappointment.dart';
import 'package:patientapp/pages/doctordetails.dart';
import 'package:patientapp/pages/historydetails.dart';
import 'package:patientapp/pages/noappointments.dart';
import 'package:patientapp/pages/nodata.dart';
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

class ViewAll extends StatefulWidget {
  final String appBarTitle, layoutType;

  const ViewAll({
    Key? key,
    required this.appBarTitle,
    required this.layoutType,
  }) : super(key: key);

  @override
  State<ViewAll> createState() => _ViewAllState();
}

class _ViewAllState extends State<ViewAll> {
  @override
  void initState() {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.getSpecialities();
    homeProvider.getUpcomingAppointment();
    homeProvider.getUpcomingTestAppointment();
    homeProvider.getDoctor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: primaryColor,
      appBar: Utility.myAppBar(context, widget.appBarTitle),
      body: SizedBox(
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
            child: setLayoutByType(widget.layoutType),
          ),
        ),
      ),
    );
  }

  Widget setLayoutByType(String layoutType) {
    switch (layoutType) {
      case 'Speciality':
        return specialityList();
      case 'Appointment':
        return upcomingAppintmentList();
      case 'Test':
        return upcomingTestList();
      case 'Doctors':
        return availableDoctorList();
      default:
        return Container();
    }
  }

  Widget specialityList() {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, child) {
        if (!homeProvider.loading) {
          if (homeProvider.specialityModel.status == 200 &&
              homeProvider.specialityModel.result != null) {
            if (homeProvider.specialityModel.result!.isNotEmpty) {
              return AlignedGridView.count(
                shrinkWrap: true,
                padding: const EdgeInsets.all(18),
                crossAxisCount: 3,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                itemCount: homeProvider.specialityModel.result!.length,
                itemBuilder: (BuildContext context, int position) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      log("Item Clicked! => $position");
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ViewAll(
                                appBarTitle: availableDoctors,
                                layoutType: 'Doctors',
                              )));
                    },
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
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
                            imgHeight: 40,
                            imgWidth: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 3, right: 3),
                            child: MyText(
                              mTitle: homeProvider.specialityModel.result!
                                      .elementAt(position)
                                      .name ??
                                  "-",
                              mFontSize: 15,
                              mFontStyle: FontStyle.normal,
                              mFontWeight: FontWeight.normal,
                              mMaxLine: 2,
                              mOverflow: TextOverflow.ellipsis,
                              mTextAlign: TextAlign.center,
                              mTextColor: white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return const NoData();
            }
          } else {
            return Utility.pageLoader();
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
              return AlignedGridView.count(
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(18, 14, 18, 20),
                mainAxisSpacing: 14,
                crossAxisCount: 1,
                physics: const NeverScrollableScrollPhysics(),
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
                                homeProvider.appointmentModel.result!
                                        .elementAt(position)
                                        .id ??
                                    ""),
                          ),
                        );
                      },
                      child: Stack(
                        children: <Widget>[
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                              minHeight: 82,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                            margin:
                                                const EdgeInsets.only(left: 60),
                                            alignment: Alignment.topLeft,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                MyText(
                                                  mTitle: homeProvider
                                                          .appointmentModel
                                                          .result!
                                                          .elementAt(position)
                                                          .doctorName ??
                                                      "-",
                                                  mFontSize: 14,
                                                  mFontWeight: FontWeight.bold,
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
                                                              .result!
                                                              .elementAt(
                                                                  position)
                                                              .specialitiesName ??
                                                          "",
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
                                                        shape: BoxShape.circle,
                                                        color: otherLightColor,
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
                                                                  : homeProvider
                                                                              .appointmentModel
                                                                              .result
                                                                              ?.elementAt(
                                                                                  position)
                                                                              .status
                                                                              .toString() ==
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
                                                                  : homeProvider
                                                                              .appointmentModel
                                                                              .result
                                                                              ?.elementAt(
                                                                                  position)
                                                                              .status
                                                                              .toString() ==
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
                                              mOverflow: TextOverflow.ellipsis,
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
                                    CupertinoButton(
                                      minSize: double.minPositive,
                                      padding: EdgeInsets.zero,
                                      child: MySvgAssetsImg(
                                        imageName: "delete.svg",
                                        fit: BoxFit.cover,
                                        imgHeight: 25,
                                        imgWidth: 25,
                                      ),
                                      onPressed: () {
                                        log("on Delete Click!");
                                      },
                                    ),
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
              );
            } else {
              return const NoAppointments();
            }
          } else {
            return Utility.pageLoader();
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
              return AlignedGridView.count(
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(18, 14, 18, 20),
                mainAxisSpacing: 14,
                crossAxisCount: 1,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: homeProvider.testAppointmentModel.result!.length,
                itemBuilder: (BuildContext context, int position) {
                  return Container(
                    padding: const EdgeInsets.only(top: 12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        log("Item Clicked!");
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const HistoryDetails(),
                          ),
                        );
                      },
                      child: Stack(
                        children: <Widget>[
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: 82,
                              minWidth: MediaQuery.of(context).size.width * 0.5,
                              maxWidth: MediaQuery.of(context).size.width * 0.9,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                            margin:
                                                const EdgeInsets.only(left: 60),
                                            alignment: Alignment.topLeft,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                MyText(
                                                  mTitle: Constant.dummyDataList
                                                      .elementAt(position)
                                                      .title,
                                                  mFontSize: 14,
                                                  mFontWeight: FontWeight.bold,
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
                                                      mTitle: Constant
                                                          .dummyDataList
                                                          .elementAt(position)
                                                          .speciality,
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
                                                        shape: BoxShape.circle,
                                                        color: otherLightColor,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    MyText(
                                                      mTitle: Constant
                                                          .dummyDataList
                                                          .elementAt(position)
                                                          .status,
                                                      mFontSize: 12,
                                                      mFontWeight:
                                                          FontWeight.normal,
                                                      mTextAlign:
                                                          TextAlign.start,
                                                      mTextColor: pendingStatus,
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
                                              mTitle: Constant.dummyDataList
                                                  .elementAt(position)
                                                  .date,
                                              mFontSize: 13,
                                              mOverflow: TextOverflow.ellipsis,
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
                                              MySvgAssetsImg(
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
                                                  mTitle: Constant.dummyDataList
                                                      .elementAt(position)
                                                      .testDesc,
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
                                    CupertinoButton(
                                      minSize: double.minPositive,
                                      padding: EdgeInsets.zero,
                                      child: MySvgAssetsImg(
                                        imageName: "delete.svg",
                                        fit: BoxFit.cover,
                                        imgHeight: 25,
                                        imgWidth: 25,
                                      ),
                                      onPressed: () {
                                        log("on Delete Click!");
                                      },
                                    ),
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
                                imageUrl: Constant.dummyDataList
                                    .elementAt(position)
                                    .imageUrl,
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
              );
            } else {
              return const NoData();
            }
          } else {
            return Utility.pageLoader();
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
              return AlignedGridView.count(
                padding: const EdgeInsets.fromLTRB(18, 14, 18, 30),
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 6,
                mainAxisSpacing: 20,
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
                                  .doctorModel.result!
                                  .elementAt(position)
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
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
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
                                        mTitle: homeProvider.doctorModel.result
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
                                builder: (context) => const BookAppointment(),
                              ),
                            );
                          },
                          child: Container(
                            transform: Matrix4.translationValues(0, 10, 0),
                            padding: const EdgeInsets.fromLTRB(23, 8, 23, 8),
                            decoration: Utility.primaryButton(),
                            child: MyText(
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
              );
            } else {
              return const NoData();
            }
          } else {
            return Utility.pageLoader();
          }
        } else {
          return Utility.pageLoader();
        }
      },
    );
  }
}
