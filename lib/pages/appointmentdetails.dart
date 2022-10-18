import 'dart:developer';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:patientapp/pages/nodata.dart';
import 'package:patientapp/provider/appointmentdetailprovider.dart';
import 'package:patientapp/utils/colors.dart';
import 'package:patientapp/utils/constant.dart';
import 'package:patientapp/utils/strings.dart';
import 'package:patientapp/utils/utility.dart';
import 'package:patientapp/widgets/mynetworkimg.dart';
import 'package:patientapp/widgets/mysvgassetsimg.dart';
import 'package:patientapp/widgets/mytext.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/widgets/mytextformfield.dart';
import 'package:provider/provider.dart';

class AppointmentDetails extends StatefulWidget {
  final String appoitnmentID;
  const AppointmentDetails(this.appoitnmentID, {Key? key}) : super(key: key);

  @override
  State<AppointmentDetails> createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  final mAddCommentController = TextEditingController();
  @override
  void initState() {
    final detailProvider =
        Provider.of<AppointmentDetailProvider>(context, listen: false);
    detailProvider.getAppointmentDetail(widget.appoitnmentID);
    super.initState();
  }

  @override
  void dispose() {
    mAddCommentController.dispose();
    super.dispose();
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
          child: Consumer<AppointmentDetailProvider>(
              builder: (context, detailProvider, child) {
            if (!detailProvider.loading) {
              if (detailProvider.appointmentModel.status == 200) {
                if (detailProvider.appointmentModel.result != null) {
                  if (detailProvider.appointmentModel.result!.isNotEmpty) {
                    return Column(
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
                                  imageUrl: detailProvider
                                          .appointmentModel.result
                                          ?.elementAt(0)
                                          .doctorImage
                                          .toString() ??
                                      "",
                                  fit: BoxFit.fill,
                                  imgHeight: 66,
                                  imgWidth: 66,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 13, right: 13),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      MyText(
                                        mTitle: detailProvider
                                                .appointmentModel.result!
                                                .elementAt(0)
                                                .doctorName!
                                                .isNotEmpty
                                            ? (detailProvider
                                                    .appointmentModel.result!
                                                    .elementAt(0)
                                                    .doctorName ??
                                                "-")
                                            : "-",
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          MyText(
                                            mTitle: detailProvider
                                                    .appointmentModel.result!
                                                    .elementAt(0)
                                                    .specialitiesName!
                                                    .isNotEmpty
                                                ? (detailProvider
                                                        .appointmentModel
                                                        .result!
                                                        .elementAt(0)
                                                        .specialitiesName ??
                                                    "-")
                                                : "-",
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
                                            mTitle: detailProvider
                                                    .appointmentModel.result!
                                                    .elementAt(0)
                                                    .status!
                                                    .isNotEmpty
                                                ? detailProvider.appointmentModel.result
                                                            ?.elementAt(0)
                                                            .status
                                                            .toString() ==
                                                        "1"
                                                    ? pending
                                                    : (detailProvider
                                                                .appointmentModel
                                                                .result
                                                                ?.elementAt(0)
                                                                .status
                                                                .toString() ==
                                                            "2"
                                                        ? approved
                                                        : (detailProvider
                                                                    .appointmentModel
                                                                    .result
                                                                    ?.elementAt(
                                                                        0)
                                                                    .status
                                                                    .toString() ==
                                                                "3"
                                                            ? rejected
                                                            : detailProvider
                                                                        .appointmentModel
                                                                        .result
                                                                        ?.elementAt(
                                                                            0)
                                                                        .status
                                                                        .toString() ==
                                                                    "4"
                                                                ? absent
                                                                : (detailProvider.appointmentModel.result
                                                                            ?.elementAt(0)
                                                                            .status
                                                                            .toString() ==
                                                                        "5"
                                                                    ? completed
                                                                    : "-")))
                                                : "-",
                                            mFontSize: 12,
                                            mFontWeight: FontWeight.normal,
                                            mTextAlign: TextAlign.start,
                                            mTextColor: detailProvider
                                                    .appointmentModel.result!
                                                    .elementAt(0)
                                                    .status!
                                                    .isNotEmpty
                                                ? detailProvider
                                                            .appointmentModel
                                                            .result
                                                            ?.elementAt(0)
                                                            .status
                                                            .toString() ==
                                                        "1"
                                                    ? pendingStatus
                                                    : (detailProvider
                                                                .appointmentModel
                                                                .result
                                                                ?.elementAt(0)
                                                                .status
                                                                .toString() ==
                                                            "2"
                                                        ? approvedStatus
                                                        : (detailProvider
                                                                    .appointmentModel
                                                                    .result
                                                                    ?.elementAt(
                                                                        0)
                                                                    .status
                                                                    .toString() ==
                                                                "3"
                                                            ? rejectedStatus
                                                            : detailProvider
                                                                        .appointmentModel
                                                                        .result
                                                                        ?.elementAt(
                                                                            0)
                                                                        .status
                                                                        .toString() ==
                                                                    "4"
                                                                ? absentStatus
                                                                : (detailProvider.appointmentModel.result?.elementAt(0).status.toString() ==
                                                                        "5"
                                                                    ? completedStatus
                                                                    : black)))
                                                : black,
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
                                  Utility.launchPhoneDialer(detailProvider
                                          .appointmentModel.result
                                          ?.elementAt(0)
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
                                mTitle: contactNo,
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
                                mTitle: detailProvider.appointmentModel.result!
                                        .elementAt(0)
                                        .doctorMobileNumber!
                                        .isNotEmpty
                                    ? (detailProvider.appointmentModel.result!
                                            .elementAt(0)
                                            .doctorMobileNumber ??
                                        "-")
                                    : "-",
                                mFontSize: 14,
                                mFontWeight: FontWeight.normal,
                                mFontStyle: FontStyle.normal,
                                mTextAlign: TextAlign.start,
                                mTextColor: textTitleColor,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        MyText(
                                          mTitle: date,
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
                                          mTitle: Utility.formateInMMMMDD(
                                              detailProvider
                                                      .appointmentModel.result
                                                      ?.elementAt(0)
                                                      .date
                                                      .toString() ??
                                                  ""),
                                          mFontSize: 14,
                                          mFontWeight: FontWeight.normal,
                                          mMaxLine: 1,
                                          mOverflow: TextOverflow.ellipsis,
                                          mFontStyle: FontStyle.normal,
                                          mTextAlign: TextAlign.start,
                                          mTextColor: textTitleColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        MyText(
                                          mTitle: time,
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
                                          mTitle: Utility.formateTime(
                                              detailProvider
                                                      .appointmentModel.result
                                                      ?.elementAt(0)
                                                      .startTime
                                                      .toString() ??
                                                  "-"),
                                          mFontSize: 14,
                                          mMaxLine: 1,
                                          mOverflow: TextOverflow.ellipsis,
                                          mFontWeight: FontWeight.normal,
                                          mFontStyle: FontStyle.normal,
                                          mTextAlign: TextAlign.start,
                                          mTextColor: textTitleColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              MyText(
                                mTitle: emailAddress,
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
                                mTitle: detailProvider.appointmentModel.result!
                                        .elementAt(0)
                                        .doctorEmail!
                                        .isNotEmpty
                                    ? (detailProvider.appointmentModel.result!
                                            .elementAt(0)
                                            .doctorEmail ??
                                        "-")
                                    : "-",
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
                                mTitle: allergiesToMedicine,
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
                                mTitle: detailProvider.appointmentModel.result!
                                        .elementAt(0)
                                        .allergiesToMedicine!
                                        .isNotEmpty
                                    ? (detailProvider.appointmentModel.result!
                                            .elementAt(0)
                                            .allergiesToMedicine ??
                                        "-")
                                    : "-",
                                mFontSize: 14,
                                mMaxLine: 3,
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
                                mTitle: medicineTaken,
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
                                mTitle: detailProvider.appointmentModel.result!
                                        .elementAt(0)
                                        .medicinesTaken!
                                        .isNotEmpty
                                    ? (detailProvider.appointmentModel.result!
                                            .elementAt(0)
                                            .medicinesTaken ??
                                        "-")
                                    : "-",
                                mFontSize: 14,
                                mMaxLine: 2,
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
                                mTitle: description,
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
                                mTitle: detailProvider.appointmentModel.result!
                                        .elementAt(0)
                                        .description!
                                        .isNotEmpty
                                    ? (detailProvider.appointmentModel.result!
                                            .elementAt(0)
                                            .description ??
                                        "-")
                                    : "-",
                                mFontSize: 14,
                                mMaxLine: 5,
                                mOverflow: TextOverflow.ellipsis,
                                mFontWeight: FontWeight.normal,
                                mFontStyle: FontStyle.normal,
                                mTextAlign: TextAlign.start,
                                mTextColor: textTitleColor,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 65,
                        ),
                        Visibility(
                          visible: detailProvider.appointmentModel.result!
                                  .elementAt(0)
                                  .status ==
                              "5",
                          child: InkWell(
                            borderRadius: BorderRadius.circular(4),
                            onTap: () {
                              log("Tapped on $giveFeedBack");
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(30),
                                  ),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                builder: (BuildContext context) {
                                  return Wrap(children: <Widget>[
                                    buildAddFeedBackDialog(),
                                  ]);
                                },
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: Constant.buttonHeight,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(4),
                                shape: BoxShape.rectangle,
                              ),
                              child: MyText(
                                mTitle: giveFeedBack,
                                mFontSize: 16,
                                mFontStyle: FontStyle.normal,
                                mFontWeight: FontWeight.w600,
                                mMaxLine: 1,
                                mTextAlign: TextAlign.center,
                                mTextColor: primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
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
            } else {
              return Utility.pageLoader();
            }
          }),
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
        mTitle: appointments,
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

  Widget buildAddFeedBackDialog() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 13, 20, 9),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 40,
            height: 2,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: boxBorderColor,
              borderRadius: BorderRadius.circular(1),
              shape: BoxShape.rectangle,
            ),
          ),
          const SizedBox(
            height: 13,
          ),
          MyText(
            mTitle: giveFeedBack,
            mFontSize: 18,
            mFontStyle: FontStyle.normal,
            mFontWeight: FontWeight.bold,
            mMaxLine: 1,
            mOverflow: TextOverflow.ellipsis,
            mTextAlign: TextAlign.center,
            mTextColor: textTitleColor,
          ),
          const SizedBox(
            height: 13,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 0.5,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: boxBorderColor,
              borderRadius: BorderRadius.circular(1),
              shape: BoxShape.rectangle,
            ),
          ),
          const SizedBox(
            height: 13,
          ),
          MyText(
            mTitle: giveRating,
            mFontSize: 14,
            mFontStyle: FontStyle.normal,
            mFontWeight: FontWeight.w600,
            mMaxLine: 1,
            mOverflow: TextOverflow.ellipsis,
            mTextAlign: TextAlign.center,
            mTextColor: textTitleColor,
          ),
          const SizedBox(
            height: 12,
          ),
          RatingBar(
            initialRating: 0,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            ratingWidget: RatingWidget(
              full: MySvgAssetsImg(
                imageName: 'star_full.svg',
                fit: BoxFit.cover,
              ),
              half: MySvgAssetsImg(
                imageName: 'star_border.svg',
                fit: BoxFit.cover,
              ),
              empty: MySvgAssetsImg(
                imageName: 'star_border.svg',
                fit: BoxFit.cover,
              ),
            ),
            itemPadding: const EdgeInsets.symmetric(horizontal: 4),
            onRatingUpdate: (rating) {
              log('$rating');
            },
          ),
          const SizedBox(
            height: 24,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 118,
              minWidth: MediaQuery.of(context).size.width,
            ),
            child: Container(
              padding: const EdgeInsets.only(left: 15, right: 15),
              decoration: Utility.r10BGWithBorder(),
              child: MyTextFormField(
                mHint: addCommentHint,
                mController: mAddCommentController,
                mObscureText: false,
                mHintTextColor: textHintColor,
                mTextColor: textTitleColor,
                mkeyboardType: TextInputType.multiline,
                mTextInputAction: TextInputAction.done,
                mInputBorder: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(
            height: 19,
          ),
          InkWell(
            onTap: () {
              log('Tapped on $submit');
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: Constant.buttonHeight,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(4),
                shape: BoxShape.rectangle,
              ),
              child: MyText(
                mTitle: submit,
                mFontSize: 16,
                mFontStyle: FontStyle.normal,
                mFontWeight: FontWeight.w600,
                mMaxLine: 1,
                mTextAlign: TextAlign.center,
                mTextColor: white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
