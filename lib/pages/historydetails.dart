import 'dart:developer';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:patientapp/model/prescriptiondetailmodel.dart';
import 'package:patientapp/provider/historyprovider.dart';
import 'package:patientapp/utils/colors.dart';
import 'package:patientapp/utils/constant.dart';
import 'package:patientapp/utils/strings.dart';
import 'package:patientapp/utils/utility.dart';
import 'package:patientapp/widgets/mynetworkimg.dart';
import 'package:patientapp/widgets/mysvgassetsimg.dart';
import 'package:patientapp/widgets/mytext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:patientapp/model/appointmentmodel.dart' as history;

class HistoryDetails extends StatefulWidget {
  final List<history.Result>? historyList;
  final int position;
  const HistoryDetails(this.historyList, this.position, {Key? key})
      : super(key: key);

  @override
  State<HistoryDetails> createState() => _HistoryDetailsState();
}

class _HistoryDetailsState extends State<HistoryDetails> {
  String? appointmentId = "";
  List<Prescription>? prescriptionList;

  @override
  void initState() {
    prescriptionList = <Prescription>[];
    appointmentId = widget.historyList?.elementAt(widget.position).id;
    log("appointmentId ==>>>> $appointmentId");
    final prescriptionHistorProvider =
        Provider.of<HistoryProvider>(context, listen: false);
    prescriptionHistorProvider.getPrescriptionHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: primaryColor,
      appBar: myAppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(8),
                  shape: BoxShape.rectangle,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      clipBehavior: Clip.antiAlias,
                      child: MyNetworkImage(
                        imageUrl: widget.historyList
                                ?.elementAt(widget.position)
                                .doctorImage
                                .toString() ??
                            Constant.userPlaceholder,
                        fit: BoxFit.fill,
                        imgHeight: 66,
                        imgWidth: 66,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 13, right: 13),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            MyText(
                              mTitle: widget.historyList
                                      ?.elementAt(widget.position)
                                      .doctorName
                                      .toString() ??
                                  guestDoctor,
                              mTextAlign: TextAlign.start,
                              mTextColor: textTitleColor,
                              mFontSize: 14,
                              mFontStyle: FontStyle.normal,
                              mFontWeight: FontWeight.bold,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                MyText(
                                  mTitle: widget.historyList
                                          ?.elementAt(widget.position)
                                          .specialitiesName
                                          .toString() ??
                                      "-",
                                  mFontSize: 12,
                                  mFontWeight: FontWeight.normal,
                                  mTextAlign: TextAlign.start,
                                  mTextColor: otherLightColor,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Container(
                                  width: 4,
                                  height: 4,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: otherLightColor,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                MyText(
                                  mTitle: widget.historyList
                                              ?.elementAt(widget.position)
                                              .status
                                              .toString() ==
                                          "1"
                                      ? pending
                                      : (widget.historyList
                                                  ?.elementAt(widget.position)
                                                  .status
                                                  .toString() ==
                                              "2"
                                          ? approved
                                          : (widget.historyList
                                                      ?.elementAt(
                                                          widget.position)
                                                      .status
                                                      .toString() ==
                                                  "3"
                                              ? rejected
                                              : widget.historyList
                                                          ?.elementAt(
                                                              widget.position)
                                                          .status
                                                          .toString() ==
                                                      "4"
                                                  ? absent
                                                  : (widget.historyList
                                                              ?.elementAt(widget
                                                                  .position)
                                                              .status
                                                              .toString() ==
                                                          "5"
                                                      ? completed
                                                      : "-"))),
                                  mFontSize: 12,
                                  mFontWeight: FontWeight.normal,
                                  mTextAlign: TextAlign.start,
                                  mTextColor: widget.historyList
                                              ?.elementAt(widget.position)
                                              .status
                                              .toString() ==
                                          "1"
                                      ? pendingStatus
                                      : (widget.historyList
                                                  ?.elementAt(widget.position)
                                                  .status
                                                  .toString() ==
                                              "2"
                                          ? approvedStatus
                                          : (widget.historyList
                                                      ?.elementAt(
                                                          widget.position)
                                                      .status
                                                      .toString() ==
                                                  "3"
                                              ? rejectedStatus
                                              : widget.historyList
                                                          ?.elementAt(
                                                              widget.position)
                                                          .status
                                                          .toString() ==
                                                      "4"
                                                  ? absentStatus
                                                  : (widget.historyList
                                                              ?.elementAt(widget
                                                                  .position)
                                                              .status
                                                              .toString() ==
                                                          "5"
                                                      ? completedStatus
                                                      : black))),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        log('Clicked on call!');
                        Utility.launchPhoneDialer(widget.historyList
                                ?.elementAt(widget.position)
                                .doctorMobileNumber
                                .toString() ??
                            "");
                      },
                      child: MySvgAssetsImg(
                        imageName: "mobile_dark.svg",
                        fit: BoxFit.cover,
                        imgHeight: 38,
                        imgWidth: 38,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(8),
                  shape: BoxShape.rectangle,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MyText(
                      mTitle: doctorSymptoms,
                      mFontSize: 12,
                      mFontWeight: FontWeight.normal,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: otherLightColor,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    MyText(
                      mTitle: widget.historyList
                              ?.elementAt(widget.position)
                              .doctorSymptoms
                              .toString() ??
                          "-",
                      mFontSize: 14,
                      mFontWeight: FontWeight.normal,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: textTitleColor,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    MyText(
                      mTitle: doctorDiagnosis,
                      mFontSize: 12,
                      mFontWeight: FontWeight.normal,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: otherLightColor,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    MyText(
                      mTitle: widget.historyList
                              ?.elementAt(widget.position)
                              .doctorDiagnosis
                              .toString() ??
                          "-",
                      mFontSize: 14,
                      mMaxLine: 1,
                      mOverflow: TextOverflow.ellipsis,
                      mFontWeight: FontWeight.normal,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: textTitleColor,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    MyText(
                      mTitle: doctorPrescription,
                      mFontSize: 12,
                      mFontWeight: FontWeight.normal,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: otherLightColor,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Consumer<HistoryProvider>(
                      builder: (context, prescriptionProvider, child) {
                        if (!prescriptionProvider.loading) {
                          if (prescriptionProvider
                                  .prescriptionDetailModel.status ==
                              200) {
                            if (prescriptionProvider
                                    .prescriptionDetailModel.result !=
                                null) {
                              if (prescriptionProvider
                                  .prescriptionDetailModel.result!.isNotEmpty) {
                                for (int i = 0;
                                    i <
                                        prescriptionProvider
                                            .prescriptionDetailModel
                                            .result!
                                            .length;
                                    i++) {
                                  for (int j = 0;
                                      j <
                                          prescriptionProvider
                                              .prescriptionDetailModel.result!
                                              .elementAt(i)
                                              .prescription!
                                              .length;
                                      j++) {
                                    prescriptionList?.add(prescriptionProvider
                                        .prescriptionDetailModel.result!
                                        .elementAt(i)
                                        .prescription!
                                        .elementAt(j));
                                    log("prescriptionList length ==>> ${prescriptionList!.length}");
                                  }
                                }
                                return ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: prescriptionList!.length,
                                  itemBuilder:
                                      (BuildContext context, int position) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        MyText(
                                          mTitle: prescriptionList!
                                                  .elementAt(position)
                                                  .name ??
                                              "-",
                                          mFontSize: 14,
                                          mFontWeight: FontWeight.normal,
                                          mFontStyle: FontStyle.normal,
                                          mTextAlign: TextAlign.start,
                                          mTextColor: textTitleColor,
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              width: 4,
                                              height: 4,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: otherLightColor,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            MyText(
                                              mTitle: prescriptionList!
                                                      .elementAt(position)
                                                      .power ??
                                                  "-",
                                              mFontSize: 12,
                                              mFontWeight: FontWeight.normal,
                                              mTextAlign: TextAlign.start,
                                              mTextColor: textTitleColor,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Container(
                                              width: 4,
                                              height: 4,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: otherLightColor,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            MyText(
                                              mTitle: prescriptionList!
                                                      .elementAt(position)
                                                      .form ??
                                                  "-",
                                              mFontSize: 12,
                                              mFontWeight: FontWeight.normal,
                                              mTextAlign: TextAlign.start,
                                              mTextColor: textTitleColor,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                return Container();
                              }
                            } else {
                              return Container();
                            }
                          } else {
                            return Container();
                          }
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(8),
                  shape: BoxShape.rectangle,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MyText(
                      mTitle: feedback,
                      mFontSize: 14,
                      mFontWeight: FontWeight.bold,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: textTitleColor,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int position) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              RatingBarIndicator(
                                rating: 4.5,
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color: starColor,
                                ),
                                itemPadding: const EdgeInsets.only(right: 1),
                                itemCount: 5,
                                itemSize: 12,
                                direction: Axis.horizontal,
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              MyText(
                                mTitle:
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                                mFontSize: 12,
                                mFontWeight: FontWeight.normal,
                                mTextAlign: TextAlign.start,
                                mTextColor: otherColor,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar myAppBar() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: statusBarColor,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: MySvgAssetsImg(
          imageName: "back.svg",
          fit: BoxFit.contain,
          imgHeight: Constant.backBtnHeight,
          imgWidth: Constant.backBtnWidth,
        ),
      ),
      title: MyText(
        mTitle: historyDetails,
        mFontSize: 20,
        mFontStyle: FontStyle.normal,
        mFontWeight: FontWeight.normal,
        mTextAlign: TextAlign.center,
        mTextColor: white,
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            log('Delete pressed!');
          },
          icon: MySvgAssetsImg(
            imageName: 'delete_green.svg',
            fit: BoxFit.cover,
            imgWidth: 30,
            imgHeight: 30,
          ),
        ),
      ],
    );
  }
}
