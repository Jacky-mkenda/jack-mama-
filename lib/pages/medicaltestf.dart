import 'dart:developer';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patientapp/pages/nodata.dart';
import 'package:patientapp/provider/medicaltestprovider.dart';
import 'package:patientapp/utils/colors.dart';
import 'package:patientapp/utils/constant.dart';
import 'package:patientapp/utils/strings.dart';
import 'package:patientapp/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/widgets/mynetworkimg.dart';
import 'package:patientapp/widgets/mysvgassetsimg.dart';
import 'package:patientapp/widgets/mytext.dart';
import 'package:patientapp/widgets/mytextformfield.dart';
import 'package:provider/provider.dart';

class MedicalTestF extends StatefulWidget {
  const MedicalTestF({Key? key}) : super(key: key);

  @override
  State<MedicalTestF> createState() => _MedicalTestFState();
}

class _MedicalTestFState extends State<MedicalTestF> {
  final DatePickerController mDateController = DatePickerController();
  late DateTime selectedDate = DateTime.now();
  final mDescriptionController = TextEditingController();
  dynamic sAvailableTime, sAppointmentTime;

  @override
  void initState() {
    final medicalTestProvider =
        Provider.of<MedicalTestProvider>(context, listen: false);
    medicalTestProvider.getTestPatientAppointment();
    super.initState();
  }

  @override
  void dispose() {
    mDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: Utility.topRoundBG(),
      child: buildMedicaltestTabs(),
    );
  }

  Widget buildMedicaltestTabs() {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: TabBar(
              isScrollable: false,
              labelColor: primaryColor,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: accentColor,
              indicatorWeight: 1,
              labelPadding: const EdgeInsets.only(top: 5, bottom: 5),
              indicatorPadding: const EdgeInsets.all(0),
              unselectedLabelColor: tabDefaultColor,
              tabs: <Widget>[
                Tab(
                  child: MyText(
                    mTitle: normal,
                    mFontSize: 15,
                    mFontStyle: FontStyle.normal,
                    mFontWeight: FontWeight.w600,
                    mMaxLine: 1,
                    mOverflow: TextOverflow.ellipsis,
                    mTextAlign: TextAlign.center,
                  ),
                ),
                Tab(
                  child: MyText(
                    mTitle: special,
                    mFontSize: 15,
                    mFontStyle: FontStyle.normal,
                    mFontWeight: FontWeight.w600,
                    mMaxLine: 1,
                    mOverflow: TextOverflow.ellipsis,
                    mTextAlign: TextAlign.center,
                  ),
                ),
                Tab(
                  child: MyText(
                    mTitle: all,
                    mFontSize: 15,
                    mFontStyle: FontStyle.normal,
                    mFontWeight: FontWeight.w600,
                    mMaxLine: 1,
                    mOverflow: TextOverflow.ellipsis,
                    mTextAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 30, right: 30),
            width: MediaQuery.of(context).size.width,
            height: 0.5,
            color: boxBorderColor,
          ),
          Expanded(
            child: TabBarView(
              children: [
                normalTestTab(),
                specialTestTab(),
                allTestTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget normalTestTab() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 24,
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: MyText(
              mTitle: selectAppointmentDate,
              mFontSize: 16,
              mFontStyle: FontStyle.normal,
              mFontWeight: FontWeight.bold,
              mMaxLine: 1,
              mTextAlign: TextAlign.start,
              mTextColor: textTitleColor,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: DatePicker(
              DateTime.now(),
              controller: mDateController,
              selectionColor: primaryColor,
              selectedTextColor: white,
              deactivatedColor: white,
              onDateChange: (date) {
                log('$date');
                // New date selected
                setState(() {
                  selectedDate = date;
                });
              },
              monthTextStyle: GoogleFonts.roboto(
                textStyle: const TextStyle(
                  fontSize: 13,
                  color: textTitleColor,
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0.28,
                ),
              ),
              dateTextStyle: GoogleFonts.roboto(
                textStyle: const TextStyle(
                  fontSize: 16,
                  color: textTitleColor,
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0.28,
                ),
              ),
              dayTextStyle: GoogleFonts.roboto(
                textStyle: const TextStyle(
                  fontSize: 13,
                  color: textTitleColor,
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0.28,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: Utility.topRoundWhiteBG(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 17,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: MyText(
                    mTitle: availableTime,
                    mFontSize: 16,
                    mFontStyle: FontStyle.normal,
                    mFontWeight: FontWeight.bold,
                    mMaxLine: 1,
                    mTextAlign: TextAlign.start,
                    mTextColor: textTitleColor,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  child: availableTimeList(),
                ),
                const SizedBox(
                  height: 17,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: MyText(
                    mTitle: pickAppointmentTime,
                    mFontSize: 16,
                    mFontStyle: FontStyle.normal,
                    mFontWeight: FontWeight.bold,
                    mMaxLine: 1,
                    mTextAlign: TextAlign.start,
                    mTextColor: textTitleColor,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: 62,
                  child: appointmentTimeList(),
                ),
                const SizedBox(
                  height: 17,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: MyText(
                    mTitle: description,
                    mFontSize: 16,
                    mFontStyle: FontStyle.normal,
                    mFontWeight: FontWeight.bold,
                    mMaxLine: 1,
                    mTextAlign: TextAlign.start,
                    mTextColor: textTitleColor,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 100,
                    minWidth: MediaQuery.of(context).size.width,
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    decoration: Utility.r10BGWithBorder(),
                    child: MyTextFormField(
                      mHint: textHere,
                      mController: mDescriptionController,
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
                  height: 20,
                ),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(4),
                    onTap: () {
                      log('Tapped on $makeAnAppointment');
                      showMyDialog();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: Constant.buttonHeight,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(4),
                        shape: BoxShape.rectangle,
                      ),
                      child: MyText(
                        mTitle: makeAnAppointment,
                        mFontSize: 16,
                        mFontStyle: FontStyle.normal,
                        mFontWeight: FontWeight.w600,
                        mMaxLine: 1,
                        mOverflow: TextOverflow.ellipsis,
                        mTextAlign: TextAlign.center,
                        mTextColor: white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget specialTestTab() {
    return Center(
      child: MyText(
        mTitle: 'Coming Soon...',
        mFontSize: 16,
        mFontWeight: FontWeight.bold,
        mFontStyle: FontStyle.normal,
        mTextAlign: TextAlign.start,
        mTextColor: accentColor,
      ),
    );
  }

  Widget allTestTab() {
    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height,
        minWidth: MediaQuery.of(context).size.width,
      ),
      child: historyList(),
    );
  }

  Widget availableTimeList() {
    return AlignedGridView.count(
      shrinkWrap: true,
      crossAxisCount: 5,
      crossAxisSpacing: 9,
      mainAxisSpacing: 9,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(left: 20, right: 20),
      itemCount: 12,
      itemBuilder: (BuildContext context, int position) {
        return InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            log("Item Clicked!");
            onAvailableTimeClick(position);
          },
          child: Container(
            constraints: const BoxConstraints(
              minHeight: 60,
              minWidth: 60,
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: sAvailableTime != null && sAvailableTime == position
                  ? primaryColor
                  : timeDisableBGColor,
            ),
            child: MyText(
              mTitle: '10:00\nAM',
              mFontSize: 14,
              mFontStyle: FontStyle.normal,
              mFontWeight: FontWeight.normal,
              mTextAlign: TextAlign.center,
              mTextColor: sAvailableTime != null && sAvailableTime == position
                  ? white
                  : otherLightColor,
            ),
          ),
        );
      },
    );
  }

  void onAvailableTimeClick(int sPosition) {
    log('Clicked on => $sPosition');
    setState(() {
      sAvailableTime = sPosition;
    });
  }

  Widget appointmentTimeList() {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.only(left: 20, right: 20),
      scrollDirection: Axis.horizontal,
      itemCount: 8,
      separatorBuilder: (context, index) => const SizedBox(
        width: 9,
      ),
      itemBuilder: (BuildContext context, int position) => InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          log("Item Clicked!");
          onAppointmentTimeClick(position);
        },
        child: Container(
          width: 60,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: sAppointmentTime != null && sAppointmentTime == position
                ? primaryColor
                : timeDisableBGColor,
          ),
          child: MyText(
            mTitle: '10:00\nAM',
            mFontSize: 14,
            mFontStyle: FontStyle.normal,
            mFontWeight: FontWeight.normal,
            mTextAlign: TextAlign.center,
            mTextColor: sAppointmentTime != null && sAppointmentTime == position
                ? white
                : otherLightColor,
          ),
        ),
      ),
    );
  }

  void onAppointmentTimeClick(int sPosition) {
    log('Clicked on => $sPosition');
    setState(() {
      sAppointmentTime = sPosition;
    });
  }

  Widget historyList() {
    return Consumer<MedicalTestProvider>(
      builder: (context, medicalTestProvider, child) {
        if (!medicalTestProvider.loading) {
          if (medicalTestProvider.patientTestModel.status == 200 &&
              medicalTestProvider.patientTestModel.result != null) {
            if (medicalTestProvider.patientTestModel.result!.isNotEmpty) {
              return AlignedGridView.count(
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(18, 14, 18, 20),
                mainAxisSpacing: 14,
                crossAxisCount: 1,
                itemCount: medicalTestProvider.patientTestModel.result!.length,
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
                                                  mTitle: medicalTestProvider
                                                          .patientTestModel
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
                                                      mTitle: medicalTestProvider
                                                              .patientTestModel
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
                                                      mTitle: medicalTestProvider
                                                                  .patientTestModel
                                                                  .result
                                                                  ?.elementAt(
                                                                      position)
                                                                  .status
                                                                  .toString() ==
                                                              "1"
                                                          ? pending
                                                          : (medicalTestProvider
                                                                      .patientTestModel
                                                                      .result
                                                                      ?.elementAt(
                                                                          position)
                                                                      .status
                                                                      .toString() ==
                                                                  "2"
                                                              ? approved
                                                              : (medicalTestProvider
                                                                          .patientTestModel
                                                                          .result
                                                                          ?.elementAt(
                                                                              position)
                                                                          .status
                                                                          .toString() ==
                                                                      "3"
                                                                  ? rejected
                                                                  : medicalTestProvider
                                                                              .patientTestModel
                                                                              .result
                                                                              ?.elementAt(
                                                                                  position)
                                                                              .status
                                                                              .toString() ==
                                                                          "4"
                                                                      ? absent
                                                                      : (medicalTestProvider.patientTestModel.result?.elementAt(position).status.toString() ==
                                                                              "5"
                                                                          ? completed
                                                                          : "-"))),
                                                      mFontSize: 12,
                                                      mFontWeight:
                                                          FontWeight.normal,
                                                      mTextAlign:
                                                          TextAlign.start,
                                                      mTextColor: medicalTestProvider
                                                                  .patientTestModel
                                                                  .result
                                                                  ?.elementAt(
                                                                      position)
                                                                  .status
                                                                  .toString() ==
                                                              "1"
                                                          ? pendingStatus
                                                          : (medicalTestProvider
                                                                      .patientTestModel
                                                                      .result
                                                                      ?.elementAt(
                                                                          position)
                                                                      .status
                                                                      .toString() ==
                                                                  "2"
                                                              ? approvedStatus
                                                              : (medicalTestProvider
                                                                          .patientTestModel
                                                                          .result
                                                                          ?.elementAt(
                                                                              position)
                                                                          .status
                                                                          .toString() ==
                                                                      "3"
                                                                  ? rejectedStatus
                                                                  : medicalTestProvider
                                                                              .patientTestModel
                                                                              .result
                                                                              ?.elementAt(
                                                                                  position)
                                                                              .status
                                                                              .toString() ==
                                                                          "4"
                                                                      ? absentStatus
                                                                      : (medicalTestProvider.patientTestModel.result?.elementAt(position).status.toString() ==
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
                                                  '${Utility.formateDate((medicalTestProvider.patientTestModel.result!.elementAt(position).date ?? "").toString())} at ${Utility.formateTime((medicalTestProvider.patientTestModel.result!.elementAt(position).startTime ?? ""))} - ${Utility.formateTime((medicalTestProvider.patientTestModel.result!.elementAt(position).endTime ?? ""))}',
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
                                                  mTitle: medicalTestProvider
                                                          .patientTestModel
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
                                imageUrl: medicalTestProvider
                                        .patientTestModel.result!
                                        .elementAt(position)
                                        .doctorImage ??
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

  Future<void> showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registration Details'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                MyText(
                  mTitle:
                      "Date : $selectedDate\nDescription : ${mDescriptionController.text}",
                  mTextColor: black,
                  mFontSize: 16,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: MyText(
                mTitle: okay,
                mTextColor: primaryDarkColor,
                mFontSize: 20,
                mFontStyle: FontStyle.normal,
                mFontWeight: FontWeight.w600,
                mTextAlign: TextAlign.center,
              ),
              onPressed: () {
                mDescriptionController.clear();
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }
}
