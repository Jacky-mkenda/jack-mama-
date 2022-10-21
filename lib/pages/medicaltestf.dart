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
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:provider/provider.dart';

class MedicalTestF extends StatefulWidget {
  const MedicalTestF({Key? key}) : super(key: key);

  @override
  State<MedicalTestF> createState() => _MedicalTestFState();
}

class _MedicalTestFState extends State<MedicalTestF> {
  late ProgressDialog prDialog;
  late MedicalTestProvider medicalTestProvider;
  final DatePickerController mDateController = DatePickerController();
  late DateTime selectedDate = DateTime.now();
  final mDescriptionController = TextEditingController();
  String? strDate = "",
      strStartTime = "",
      strEndTime = "",
      appointmentSlotId = "";

  @override
  void initState() {
    prDialog = ProgressDialog(context);
    medicalTestProvider =
        Provider.of<MedicalTestProvider>(context, listen: false);
    medicalTestProvider.getTestPatientAppointment();
    super.initState();
  }

  @override
  void dispose() {
    log("============ dispose called! ============");
    mDescriptionController.dispose();
    medicalTestProvider.clearTestBookProvider();
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
         const  Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: TabBar(
              isScrollable: false,
              labelColor: primaryColor,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: accentColor,
              indicatorWeight: 1,
              labelPadding: EdgeInsets.only(top: 5, bottom: 5),
              indicatorPadding: EdgeInsets.all(0),
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
            child:const  MyText(
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
              onDateChange: (date) async {
                log('Clicked date ==>> $date');
                strDate = Utility.formateFullDate(date.toString());
                log('strDate ==>> $strDate');
                final bookAppointmentProvider =
                    Provider.of<MedicalTestProvider>(context, listen: false);
                await bookAppointmentProvider.getClickedDate(true);
                await bookAppointmentProvider.getTestTimeSlot(strDate);
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
                  child: const MyText(
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
                  child: const MyText(
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
                  child:const  MyText(
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
                      validateAndMake();
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
                      child: const MyText(
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
    return const Center(
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
    return Consumer<MedicalTestProvider>(
      builder: (context, timeSlotProvider, child) {
        if (timeSlotProvider.isDateSelected) {
          if (!timeSlotProvider.loading) {
            if (timeSlotProvider.testTimeSlotModel.status == 200) {
              if (timeSlotProvider.testTimeSlotModel.result != null) {
                if (timeSlotProvider.testTimeSlotModel.result!.isNotEmpty) {
                  return AlignedGridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 5,
                    crossAxisSpacing: 9,
                    mainAxisSpacing: 9,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    itemCount:
                        timeSlotProvider.testTimeSlotModel.result!.length,
                    itemBuilder: (BuildContext context, int position) {
                      return InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () async {
                          log("Item Clicked!");
                          log("Clicked position ===>  $position");
                          final bookAppointmentProvider =
                              Provider.of<MedicalTestProvider>(context,
                                  listen: false);
                          await bookAppointmentProvider
                              .getClickAvailableTime(position);
                        },
                        child: Container(
                          constraints: const BoxConstraints(
                            minHeight: 60,
                            minWidth: 60,
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: timeSlotProvider.availableTimePos != null &&
                                    timeSlotProvider.availableTimePos ==
                                        position
                                ? primaryColor
                                : timeDisableBGColor,
                          ),
                          child: MyText(
                            mTitle: Utility.formateTimeSetInColumn(
                                timeSlotProvider.testTimeSlotModel.result!
                                        .elementAt(position)
                                        .startTime ??
                                    ""),
                            mFontSize: 14,
                            mFontStyle: FontStyle.normal,
                            mFontWeight: FontWeight.normal,
                            mTextAlign: TextAlign.center,
                            mTextColor:
                                timeSlotProvider.availableTimePos != null &&
                                        timeSlotProvider.availableTimePos ==
                                            position
                                    ? white
                                    : otherLightColor,
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const NoData();
                }
              } else {
                return Container();
              }
            } else {
              return Container();
            }
          } else {
            return Utility.pageLoader();
          }
        } else {
          return Container();
        }
      },
    );
  }

  Widget appointmentTimeList() {
    return Consumer<MedicalTestProvider>(
      builder: (context, timeSlotProvider, child) {
        if (!timeSlotProvider.loading) {
          if (timeSlotProvider.testTimeSlotModel.status == 200) {
            if (timeSlotProvider.testTimeSlotModel.result != null) {
              if (timeSlotProvider.testTimeSlotModel.result!.isNotEmpty) {
                if (timeSlotProvider.availableTimePos != null) {
                  log("timeSlotProvider availableTimePos ====> ${timeSlotProvider.availableTimePos}");
                  if (timeSlotProvider.availableTimePos! >= 0) {
                    if (timeSlotProvider.testTimeSlotModel.result!
                        .elementAt(timeSlotProvider.availableTimePos!)
                        .slot!
                        .isNotEmpty) {
                      return ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        scrollDirection: Axis.horizontal,
                        itemCount: timeSlotProvider.testTimeSlotModel.result!
                            .elementAt(timeSlotProvider.availableTimePos!)
                            .slot!
                            .length,
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 9,
                        ),
                        itemBuilder: (BuildContext context, int position) =>
                            InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () async {
                            log("Item Clicked!");
                            log('Clicked on position => $position');

                            final bookAppointmentProvider =
                                Provider.of<MedicalTestProvider>(context,
                                    listen: false);
                            await bookAppointmentProvider
                                .getClickAappointmentTime(position);

                            strStartTime = timeSlotProvider
                                    .testTimeSlotModel.result!
                                    .elementAt(
                                        timeSlotProvider.availableTimePos!)
                                    .slot!
                                    .elementAt(position)
                                    .startTime ??
                                "";
                            strEndTime = timeSlotProvider
                                    .testTimeSlotModel.result!
                                    .elementAt(
                                        timeSlotProvider.availableTimePos!)
                                    .slot!
                                    .elementAt(position)
                                    .endTime ??
                                "";
                            appointmentSlotId = timeSlotProvider
                                    .testTimeSlotModel.result!
                                    .elementAt(
                                        timeSlotProvider.availableTimePos!)
                                    .slot!
                                    .elementAt(position)
                                    .testAppointmentSlotsId ??
                                "";
                            log('strStartTime ======> $strStartTime');
                            log('strEndTime ======> $strEndTime');
                            log('appointmentSlotId ======> $appointmentSlotId');
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  timeSlotProvider.appointmentTimePos != null &&
                                          timeSlotProvider.appointmentTimePos ==
                                              position
                                      ? primaryColor
                                      : timeDisableBGColor,
                            ),
                            child: MyText(
                              mTitle: Utility.formateTimeSetInColumn(
                                  timeSlotProvider.testTimeSlotModel.result!
                                          .elementAt(timeSlotProvider
                                              .availableTimePos!)
                                          .slot!
                                          .elementAt(position)
                                          .startTime ??
                                      ""),
                              mFontSize: 14,
                              mFontStyle: FontStyle.normal,
                              mFontWeight: FontWeight.normal,
                              mTextAlign: TextAlign.center,
                              mTextColor:
                                  timeSlotProvider.appointmentTimePos != null &&
                                          timeSlotProvider.appointmentTimePos ==
                                              position
                                      ? white
                                      : otherLightColor,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const NoData();
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
    );
  }

  void validateAndMake() async {
    String addNote = mDescriptionController.text.toString().trim();
    log("strDate :==> $strDate");
    log("strStartTime :==> $strStartTime");
    log("strEndTime :==> $strEndTime");
    log("appointmentSlotId :==> $appointmentSlotId");
    log("symptoms :==> $symptoms");
    log("medicineTaken :==> $medicineTaken");
    log("additional Note :==> $addNote");
    if (addNote.isEmpty) {
      addNote = "";
    }
    if (strDate!.isEmpty) {
      Utility.showToast(selectAppointmentDate);
    } else if (strStartTime!.isEmpty) {
      Utility.showToast(selectAppointmentTime);
    } else {
      final bookAppointmentProvider =
          Provider.of<MedicalTestProvider>(context, listen: false);
      // login API call
      Utility.showProgress(context, prDialog);
      await bookAppointmentProvider.getMakeTestAppointment(
          strDate, strStartTime, appointmentSlotId, strEndTime, addNote);
      await prDialog.hide();
      mDescriptionController.clear();
      showMyDialog();
    }
  }

  Future<void> showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                MySvgAssetsImg(
                  imageName: "thumb.svg",
                  fit: BoxFit.contain,
                  imgHeight: 112,
                  imgWidth: 112,
                ),
                SizedBox(height: 30),
                MyText(
                  mTitle: thankYou,
                  mTextColor: black,
                  mFontSize: 30,
                  mFontStyle: FontStyle.normal,
                  mFontWeight: FontWeight.w600,
                  mTextAlign: TextAlign.center,
                ),
                SizedBox(height: 15),
                MyText(
                  mTitle: successfulTestBookingDesc,
                  mTextColor: black,
                  mFontSize: 15,
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
                foregroundColor: Colors.white,
                backgroundColor: primaryDarkColor, // foreground
              ),
              child: const MyText(
                mTitle: done,
                mTextColor: white,
                mFontSize: 20,
                mFontStyle: FontStyle.normal,
                mFontWeight: FontWeight.w600,
                mTextAlign: TextAlign.center,
              ),
              onPressed: () {
                Navigator.pop(context);
                mDescriptionController.clear();
                mDateController.animateToSelection();
                medicalTestProvider.clearTestBookProvider();
              },
            )
          ],
        );
      },
    );
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
                                                      mTitle: medicalTestProvider
                                                              .patientTestModel
                                                              .result!
                                                              .elementAt(
                                                                  position)
                                                              .patientsMobileNumber ??
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
                                             const  MySvgAssetsImg(
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
                                imageUrl: medicalTestProvider
                                        .patientTestModel.result!
                                        .elementAt(position)
                                        .patientsProfileImg ??
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
}
