import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:patientapp/pages/appointmentdetails.dart';
import 'package:patientapp/pages/bookappointment.dart';
import 'package:patientapp/pages/doctordetails.dart';
import 'package:patientapp/pages/noappointments.dart';
import 'package:patientapp/pages/nodata.dart';
import 'package:patientapp/provider/viewallprovider.dart';
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
  final String appBarTitle, layoutType, searchedText;

  const ViewAll({
    Key? key,
    required this.appBarTitle,
    required this.layoutType,
    required this.searchedText,
  }) : super(key: key);

  @override
  State<ViewAll> createState() => _ViewAllState();
}

class _ViewAllState extends State<ViewAll> {
  @override
  void initState() {
    final viewAllProvider =
        Provider.of<ViewAllProvider>(context, listen: false);
    switch (widget.layoutType) {
      case 'Speciality':
        viewAllProvider.getSpecialities();
        break;
      case 'Appointment':
        viewAllProvider.getUpcomingAppointment();
        break;
      case 'Test':
        viewAllProvider.getUpcomingTestAppointment();
        break;
      case 'Doctors':
        viewAllProvider.getDoctor();
        break;
      case 'BySearch':
        log("searchedText ==> ${widget.searchedText}");
        viewAllProvider.getSearchedDoctor(widget.searchedText);
        break;
      default:
        break;
    }
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
      case 'BySearch':
        return searchedDoctorList();
      default:
        return Container();
    }
  }

  Widget specialityList() {
    return Consumer<ViewAllProvider>(
      builder: (context, viewAllProvider, child) {
        if (!viewAllProvider.loading) {
          if (viewAllProvider.specialityModel.status == 200 &&
              viewAllProvider.specialityModel.result != null) {
            if (viewAllProvider.specialityModel.result!.isNotEmpty) {
              return AlignedGridView.count(
                shrinkWrap: true,
                padding: const EdgeInsets.all(18),
                crossAxisCount: 3,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                itemCount: viewAllProvider.specialityModel.result!.length,
                itemBuilder: (BuildContext context, int position) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      log("Item Clicked! => $position");
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ViewAll(
                            appBarTitle: viewAllProvider.specialityModel.result!
                                    .elementAt(position)
                                    .name ??
                                "",
                            layoutType: 'BySearch',
                            searchedText: viewAllProvider
                                    .specialityModel.result!
                                    .elementAt(position)
                                    .name ??
                                "",
                          ),
                        ),
                      );
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
                            imageUrl: viewAllProvider.specialityModel.result!
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
                              mTitle: viewAllProvider.specialityModel.result!
                                      .elementAt(position)
                                      .name ??
                                  "-",
                              mFontSize: 15,
                              mFontStyle: FontStyle.normal,
                              mFontWeight: FontWeight.w500,
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
            return const NoData();
          }
        } else {
          return Utility.pageLoader();
        }
      },
    );
  }

  Widget upcomingAppintmentList() {
    return Consumer<ViewAllProvider>(
      builder: (context, viewAllProvider, child) {
        if (!viewAllProvider.loading) {
          if (viewAllProvider.appointmentModel.status == 200 &&
              viewAllProvider.appointmentModel.result != null) {
            if (viewAllProvider.appointmentModel.result!.isNotEmpty) {
              return AlignedGridView.count(
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(18, 14, 18, 20),
                mainAxisSpacing: 14,
                crossAxisCount: 1,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: viewAllProvider.appointmentModel.result!.length,
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
                                viewAllProvider.appointmentModel.result!
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
                                                  mTitle: viewAllProvider
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
                                                      mTitle: viewAllProvider
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
                                                      mTitle: viewAllProvider
                                                                  .appointmentModel
                                                                  .result
                                                                  ?.elementAt(
                                                                      position)
                                                                  .status
                                                                  .toString() ==
                                                              "1"
                                                          ? pending
                                                          : (viewAllProvider
                                                                      .appointmentModel
                                                                      .result
                                                                      ?.elementAt(
                                                                          position)
                                                                      .status
                                                                      .toString() ==
                                                                  "2"
                                                              ? approved
                                                              : (viewAllProvider
                                                                          .appointmentModel
                                                                          .result
                                                                          ?.elementAt(
                                                                              position)
                                                                          .status
                                                                          .toString() ==
                                                                      "3"
                                                                  ? rejected
                                                                  : viewAllProvider
                                                                              .appointmentModel
                                                                              .result
                                                                              ?.elementAt(
                                                                                  position)
                                                                              .status
                                                                              .toString() ==
                                                                          "4"
                                                                      ? absent
                                                                      : (viewAllProvider.appointmentModel.result?.elementAt(position).status.toString() ==
                                                                              "5"
                                                                          ? completed
                                                                          : "-"))),
                                                      mFontSize: 12,
                                                      mFontWeight:
                                                          FontWeight.normal,
                                                      mTextAlign:
                                                          TextAlign.start,
                                                      mTextColor: viewAllProvider
                                                                  .appointmentModel
                                                                  .result
                                                                  ?.elementAt(
                                                                      position)
                                                                  .status
                                                                  .toString() ==
                                                              "1"
                                                          ? pendingStatus
                                                          : (viewAllProvider
                                                                      .appointmentModel
                                                                      .result
                                                                      ?.elementAt(
                                                                          position)
                                                                      .status
                                                                      .toString() ==
                                                                  "2"
                                                              ? approvedStatus
                                                              : (viewAllProvider
                                                                          .appointmentModel
                                                                          .result
                                                                          ?.elementAt(
                                                                              position)
                                                                          .status
                                                                          .toString() ==
                                                                      "3"
                                                                  ? rejectedStatus
                                                                  : viewAllProvider
                                                                              .appointmentModel
                                                                              .result
                                                                              ?.elementAt(
                                                                                  position)
                                                                              .status
                                                                              .toString() ==
                                                                          "4"
                                                                      ? absentStatus
                                                                      : (viewAllProvider.appointmentModel.result?.elementAt(position).status.toString() ==
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
                                                  '${Utility.formateDate((viewAllProvider.appointmentModel.result!.elementAt(position).date ?? "").toString())} at ${Utility.formateTime((viewAllProvider.appointmentModel.result!.elementAt(position).startTime ?? ""))} - ${Utility.formateTime((viewAllProvider.appointmentModel.result!.elementAt(position).endTime ?? ""))}',
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
                                      child: const MySvgAssetsImg(
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
                                imageUrl: viewAllProvider
                                        .appointmentModel.result
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
            return const NoAppointments();
          }
        } else {
          return Utility.pageLoader();
        }
      },
    );
  }

  Widget upcomingTestList() {
    return Consumer<ViewAllProvider>(
      builder: (context, viewAllProvider, child) {
        if (!viewAllProvider.loading) {
          if (viewAllProvider.testAppointmentModel.status == 200 &&
              viewAllProvider.testAppointmentModel.result != null) {
            if (viewAllProvider.testAppointmentModel.result!.isNotEmpty) {
              return AlignedGridView.count(
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(18, 14, 18, 20),
                mainAxisSpacing: 14,
                crossAxisCount: 1,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: viewAllProvider.testAppointmentModel.result!.length,
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
                                                  mTitle: viewAllProvider
                                                          .testAppointmentModel
                                                          .result
                                                          ?.elementAt(position)
                                                          .patientsName ??
                                                      "",
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
                                                      mTitle: viewAllProvider
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
                                                        shape: BoxShape.circle,
                                                        color: otherLightColor,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    MyText(
                                                      mTitle: viewAllProvider
                                                                  .testAppointmentModel
                                                                  .result
                                                                  ?.elementAt(
                                                                      position)
                                                                  .status
                                                                  .toString() ==
                                                              "1"
                                                          ? pending
                                                          : (viewAllProvider
                                                                      .testAppointmentModel
                                                                      .result
                                                                      ?.elementAt(
                                                                          position)
                                                                      .status
                                                                      .toString() ==
                                                                  "2"
                                                              ? approved
                                                              : (viewAllProvider
                                                                          .testAppointmentModel
                                                                          .result
                                                                          ?.elementAt(
                                                                              position)
                                                                          .status
                                                                          .toString() ==
                                                                      "3"
                                                                  ? rejected
                                                                  : viewAllProvider
                                                                              .testAppointmentModel
                                                                              .result
                                                                              ?.elementAt(
                                                                                  position)
                                                                              .status
                                                                              .toString() ==
                                                                          "4"
                                                                      ? absent
                                                                      : (viewAllProvider.testAppointmentModel.result?.elementAt(position).status.toString() ==
                                                                              "5"
                                                                          ? completed
                                                                          : "-"))),
                                                      mFontSize: 12,
                                                      mFontWeight:
                                                          FontWeight.normal,
                                                      mTextAlign:
                                                          TextAlign.start,
                                                      mTextColor: viewAllProvider
                                                                  .testAppointmentModel
                                                                  .result
                                                                  ?.elementAt(
                                                                      position)
                                                                  .status
                                                                  .toString() ==
                                                              "1"
                                                          ? pendingStatus
                                                          : (viewAllProvider
                                                                      .testAppointmentModel
                                                                      .result
                                                                      ?.elementAt(
                                                                          position)
                                                                      .status
                                                                      .toString() ==
                                                                  "2"
                                                              ? approvedStatus
                                                              : (viewAllProvider
                                                                          .testAppointmentModel
                                                                          .result
                                                                          ?.elementAt(
                                                                              position)
                                                                          .status
                                                                          .toString() ==
                                                                      "3"
                                                                  ? rejectedStatus
                                                                  : viewAllProvider
                                                                              .testAppointmentModel
                                                                              .result
                                                                              ?.elementAt(
                                                                                  position)
                                                                              .status
                                                                              .toString() ==
                                                                          "4"
                                                                      ? absentStatus
                                                                      : (viewAllProvider.testAppointmentModel.result?.elementAt(position).status.toString() ==
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
                                                  '${Utility.formateDate((viewAllProvider.testAppointmentModel.result!.elementAt(position).date ?? "").toString())} at ${Utility.formateTime((viewAllProvider.testAppointmentModel.result!.elementAt(position).startTime ?? ""))} - ${Utility.formateTime((viewAllProvider.testAppointmentModel.result!.elementAt(position).endTime ?? ""))}',
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
                                                  mTitle: viewAllProvider
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
                                    CupertinoButton(
                                      minSize: double.minPositive,
                                      padding: EdgeInsets.zero,
                                      child: const MySvgAssetsImg(
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
                                imageUrl: viewAllProvider
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
    return Consumer<ViewAllProvider>(
      builder: (context, viewAllProvider, child) {
        if (!viewAllProvider.loading) {
          if (viewAllProvider.doctorModel.status == 200 &&
              viewAllProvider.doctorModel.result != null) {
            if (viewAllProvider.doctorModel.result!.isNotEmpty) {
              return AlignedGridView.count(
                padding: const EdgeInsets.fromLTRB(18, 14, 18, 30),
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 6,
                mainAxisSpacing: 20,
                itemCount: viewAllProvider.doctorModel.result!.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int position) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      log("Item Clicked! => $position");
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DoctorDetails(viewAllProvider
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
                                    imageUrl: viewAllProvider.doctorModel.result
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
                                            "${viewAllProvider.doctorModel.result?.elementAt(position).firstName ?? "-"} ${viewAllProvider.doctorModel.result?.elementAt(position).lastName ?? "-"}",
                                        mFontSize: 15,
                                        mMaxLine: 1,
                                        mOverflow: TextOverflow.ellipsis,
                                        mFontWeight: FontWeight.normal,
                                        mTextAlign: TextAlign.center,
                                        mTextColor: textTitleColor,
                                      ),
                                      const SizedBox(height: 2),
                                      MyText(
                                        mTitle: viewAllProvider
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
                                  viewAllProvider.doctorModel.result!
                                          .elementAt(position)
                                          .id ??
                                      "",
                                  "${viewAllProvider.doctorModel.result!.elementAt(position).firstName} ${viewAllProvider.doctorModel.result!.elementAt(position).lastName}",
                                ),
                              ),
                            );
                          },
                          child: Container(
                            transform: Matrix4.translationValues(0, 10, 0),
                            padding: const EdgeInsets.fromLTRB(23, 8, 23, 8),
                            decoration: Utility.primaryButton(),
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
    return Consumer<ViewAllProvider>(
      builder: (context, viewAllProvider, child) {
        if (!viewAllProvider.loading) {
          if (viewAllProvider.searchedDoctorModel.status == 200 &&
              viewAllProvider.searchedDoctorModel.result != null) {
            if (viewAllProvider.searchedDoctorModel.result!.isNotEmpty) {
              return AlignedGridView.count(
                padding: const EdgeInsets.fromLTRB(18, 14, 18, 30),
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 6,
                mainAxisSpacing: 20,
                itemCount: viewAllProvider.searchedDoctorModel.result!.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int position) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      log("Item Clicked! => $position");
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DoctorDetails(viewAllProvider
                                  .searchedDoctorModel.result!
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
                                    imageUrl: viewAllProvider
                                            .searchedDoctorModel.result
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
                                            "${viewAllProvider.searchedDoctorModel.result?.elementAt(position).firstName ?? "-"} ${viewAllProvider.searchedDoctorModel.result?.elementAt(position).lastName ?? "-"}",
                                        mFontSize: 15,
                                        mMaxLine: 1,
                                        mOverflow: TextOverflow.ellipsis,
                                        mFontWeight: FontWeight.normal,
                                        mTextAlign: TextAlign.center,
                                        mTextColor: textTitleColor,
                                      ),
                                      const SizedBox(height: 2),
                                      MyText(
                                        mTitle: viewAllProvider
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
                                  viewAllProvider.searchedDoctorModel.result!
                                          .elementAt(position)
                                          .id ??
                                      "",
                                  "${viewAllProvider.searchedDoctorModel.result!.elementAt(position).firstName} ${viewAllProvider.searchedDoctorModel.result!.elementAt(position).lastName}",
                                ),
                              ),
                            );
                          },
                          child: Container(
                            transform: Matrix4.translationValues(0, 10, 0),
                            padding: const EdgeInsets.fromLTRB(23, 8, 23, 8),
                            decoration: Utility.primaryButton(),
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
