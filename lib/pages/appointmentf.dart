import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:patientapp/pages/appointmentdetails.dart';
import 'package:patientapp/pages/nodata.dart';
import 'package:patientapp/provider/allappointmentprovider.dart';
import 'package:patientapp/utils/colors.dart';
import 'package:patientapp/utils/constant.dart';
import 'package:patientapp/utils/strings.dart';
import 'package:patientapp/utils/utility.dart';
import 'package:patientapp/widgets/mynetworkimg.dart';
import 'package:patientapp/widgets/mysvgassetsimg.dart';
import 'package:patientapp/widgets/mytext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppointmentF extends StatefulWidget {
  const AppointmentF({Key? key}) : super(key: key);

  @override
  State<AppointmentF> createState() => _AppointmentFState();
}

class _AppointmentFState extends State<AppointmentF> {
  @override
  void initState() {
    final allAppointmentProvider =
        Provider.of<AllAppointmentProvider>(context, listen: false);
    allAppointmentProvider.getAllAppointment();
    super.initState();
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
          child: appointmentList(),
        ),
      ),
    );
  }

  Widget appointmentList() {
    return Consumer<AllAppointmentProvider>(
      builder: (context, allAppointmentProvider, child) {
        if (!allAppointmentProvider.loading) {
          if (allAppointmentProvider.appointmentModel.status == 200 &&
              allAppointmentProvider.appointmentModel.result != null) {
            if (allAppointmentProvider.appointmentModel.result!.isNotEmpty) {
              return AlignedGridView.count(
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(18, 14, 18, 20),
                mainAxisSpacing: 14,
                crossAxisCount: 1,
                physics: const NeverScrollableScrollPhysics(),
                itemCount:
                    allAppointmentProvider.appointmentModel.result!.length,
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
                              allAppointmentProvider.appointmentModel.result!
                                      .elementAt(position)
                                      .id ??
                                  "",
                            ),
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
                                                  mTitle: allAppointmentProvider
                                                          .appointmentModel
                                                          .result!
                                                          .elementAt(position)
                                                          .doctorName ??
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
                                                      mTitle: allAppointmentProvider
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
                                                      mTitle: allAppointmentProvider
                                                                  .appointmentModel
                                                                  .result
                                                                  ?.elementAt(
                                                                      position)
                                                                  .status
                                                                  .toString() ==
                                                              "1"
                                                          ? pending
                                                          : (allAppointmentProvider
                                                                      .appointmentModel
                                                                      .result
                                                                      ?.elementAt(
                                                                          position)
                                                                      .status
                                                                      .toString() ==
                                                                  "2"
                                                              ? approved
                                                              : (allAppointmentProvider
                                                                          .appointmentModel
                                                                          .result
                                                                          ?.elementAt(
                                                                              position)
                                                                          .status
                                                                          .toString() ==
                                                                      "3"
                                                                  ? rejected
                                                                  : allAppointmentProvider
                                                                              .appointmentModel
                                                                              .result
                                                                              ?.elementAt(
                                                                                  position)
                                                                              .status
                                                                              .toString() ==
                                                                          "4"
                                                                      ? absent
                                                                      : (allAppointmentProvider.appointmentModel.result?.elementAt(position).status.toString() ==
                                                                              "5"
                                                                          ? completed
                                                                          : "-"))),
                                                      mFontSize: 12,
                                                      mFontWeight:
                                                          FontWeight.normal,
                                                      mTextAlign:
                                                          TextAlign.start,
                                                      mTextColor: allAppointmentProvider
                                                                  .appointmentModel
                                                                  .result
                                                                  ?.elementAt(
                                                                      position)
                                                                  .status
                                                                  .toString() ==
                                                              "1"
                                                          ? pendingStatus
                                                          : (allAppointmentProvider
                                                                      .appointmentModel
                                                                      .result
                                                                      ?.elementAt(
                                                                          position)
                                                                      .status
                                                                      .toString() ==
                                                                  "2"
                                                              ? approvedStatus
                                                              : (allAppointmentProvider
                                                                          .appointmentModel
                                                                          .result
                                                                          ?.elementAt(
                                                                              position)
                                                                          .status
                                                                          .toString() ==
                                                                      "3"
                                                                  ? rejectedStatus
                                                                  : allAppointmentProvider
                                                                              .appointmentModel
                                                                              .result
                                                                              ?.elementAt(
                                                                                  position)
                                                                              .status
                                                                              .toString() ==
                                                                          "4"
                                                                      ? absentStatus
                                                                      : (allAppointmentProvider.appointmentModel.result?.elementAt(position).status.toString() ==
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
                                                  '${Utility.formateDate((allAppointmentProvider.appointmentModel.result!.elementAt(position).date ?? "").toString())} at ${Utility.formateTime((allAppointmentProvider.appointmentModel.result!.elementAt(position).startTime ?? ""))} - ${Utility.formateTime((allAppointmentProvider.appointmentModel.result!.elementAt(position).endTime ?? ""))}',
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
                                imageUrl: allAppointmentProvider
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
