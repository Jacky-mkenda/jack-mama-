import 'dart:developer';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patientapp/pages/nodata.dart';
import 'package:patientapp/provider/bookappointmentprovider.dart';
import 'package:patientapp/utils/colors.dart';
import 'package:patientapp/utils/constant.dart';
import 'package:patientapp/utils/strings.dart';
import 'package:patientapp/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/widgets/mysvgassetsimg.dart';
import 'package:patientapp/widgets/mytext.dart';
import 'package:patientapp/widgets/mytextformfield.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:provider/provider.dart';

class BookAppointment extends StatefulWidget {
  final String? doctorID, doctorName;
  const BookAppointment(this.doctorID, this.doctorName, {Key? key})
      : super(key: key);

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  late ProgressDialog prDialog;
  final DatePickerController mDateController = DatePickerController();
  final mSymtomsController = TextEditingController();
  final mMedicineTakenController = TextEditingController();
  final mDescriptionController = TextEditingController();
  dynamic sAvailableTimePos, sAppointmentTimePos;
  String? strDate = "",
      strStartTime = "",
      strEndTime = "",
      appointmentSlotId = "";

  @override
  void initState() {
    prDialog = ProgressDialog(context);
    log("doctorID ===> ${widget.doctorID}");
    log("doctorName ===> ${widget.doctorName}");
    super.initState();
  }

  @override
  void dispose() {
    mSymtomsController.dispose();
    mMedicineTakenController.dispose();
    mDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: primaryColor,
      appBar: Utility.appBarCommon(widget.doctorName),
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
                    onDateChange: (date) async {
                      log('Clicked date ==>> $date');
                      strDate = Utility.formateFullDate(date.toString());
                      log('strDate ==>> $strDate');
                      final bookAppointmentProvider =
                          Provider.of<BookAppointmentProvider>(context,
                              listen: false);
                      await bookAppointmentProvider.getTimeSlotByDoctorId(
                          widget.doctorID, strDate);
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
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                    minWidth: MediaQuery.of(context).size.width,
                  ),
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
                        child: appointmentTimeList(0),
                      ),
                      const SizedBox(
                        height: 17,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: MyText(
                          mTitle: symptoms,
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
                            mController: mSymtomsController,
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
                        height: 17,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: MyText(
                          mTitle: medicineTaken,
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
                            mController: mMedicineTakenController,
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
                            validateAndMake();
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
                              mTitle: makeAnAppointment,
                              mFontSize: 16,
                              mFontStyle: FontStyle.normal,
                              mFontWeight: FontWeight.w600,
                              mMaxLine: 1,
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
          ),
        ),
      ),
    );
  }

  Widget availableTimeList() {
    return Consumer<BookAppointmentProvider>(
      builder: (context, timeSlotProvider, child) {
        if (!timeSlotProvider.loading) {
          if (timeSlotProvider.timeSlotModel.status == 200) {
            if (timeSlotProvider.timeSlotModel.result != null) {
              if (timeSlotProvider.timeSlotModel.result!.isNotEmpty) {
                return AlignedGridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 5,
                  crossAxisSpacing: 9,
                  mainAxisSpacing: 9,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  itemCount: timeSlotProvider.timeSlotModel.result!.length,
                  itemBuilder: (BuildContext context, int position) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        log("Clicked position ===>  $position");
                        setState(() {
                          sAvailableTimePos = position;
                        });
                      },
                      child: Container(
                        constraints: const BoxConstraints(
                          minHeight: 60,
                          minWidth: 60,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: sAvailableTimePos != null &&
                                  sAvailableTimePos == position
                              ? primaryColor
                              : timeDisableBGColor,
                        ),
                        child: MyText(
                          mTitle: Utility.formateTimeSetInColumn(
                              timeSlotProvider.timeSlotModel.result!
                                      .elementAt(position)
                                      .startTime ??
                                  ""),
                          mFontSize: 14,
                          mFontStyle: FontStyle.normal,
                          mFontWeight: FontWeight.normal,
                          mTextAlign: TextAlign.center,
                          mTextColor: sAvailableTimePos != null &&
                                  sAvailableTimePos == position
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
      },
    );
  }

  void onAvailableTimeClick(int sPosition) {
    log('Clicked on => $sPosition');
  }

  Widget appointmentTimeList(int aTimePos) {
    return Consumer<BookAppointmentProvider>(
      builder: (context, timeSlotProvider, child) {
        if (!timeSlotProvider.loading) {
          if (timeSlotProvider.timeSlotModel.status == 200) {
            if (timeSlotProvider.timeSlotModel.result != null) {
              if (timeSlotProvider.timeSlotModel.result!.isNotEmpty) {
                if (timeSlotProvider.timeSlotModel.result!
                    .elementAt(aTimePos)
                    .slot!
                    .isNotEmpty) {
                  return ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    scrollDirection: Axis.horizontal,
                    itemCount: timeSlotProvider.timeSlotModel.result!
                        .elementAt(aTimePos)
                        .slot!
                        .length,
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 9,
                    ),
                    itemBuilder: (BuildContext context, int position) {
                      return InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          log('Clicked on position => $position');
                          setState(() {
                            strStartTime = timeSlotProvider
                                    .timeSlotModel.result!
                                    .elementAt(aTimePos)
                                    .slot!
                                    .elementAt(position)
                                    .startTime ??
                                "";
                            strEndTime = timeSlotProvider.timeSlotModel.result!
                                    .elementAt(aTimePos)
                                    .slot!
                                    .elementAt(position)
                                    .endTime ??
                                "";
                            appointmentSlotId = timeSlotProvider
                                    .timeSlotModel.result!
                                    .elementAt(aTimePos)
                                    .slot!
                                    .elementAt(position)
                                    .appointmentSlotsId ??
                                "";
                            log('strStartTime ======> $strStartTime');
                            log('strEndTime ======> $strEndTime');
                            log('appointmentSlotId ======> $appointmentSlotId');
                            sAppointmentTimePos = position;
                          });
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: sAppointmentTimePos != null &&
                                    sAppointmentTimePos == position
                                ? primaryColor
                                : timeDisableBGColor,
                          ),
                          child: MyText(
                            mTitle: Utility.formateTimeSetInColumn(
                                timeSlotProvider.timeSlotModel.result!
                                        .elementAt(aTimePos)
                                        .slot!
                                        .elementAt(position)
                                        .startTime ??
                                    ""),
                            mFontSize: 14,
                            mFontStyle: FontStyle.normal,
                            mFontWeight: FontWeight.normal,
                            mTextAlign: TextAlign.center,
                            mTextColor: sAppointmentTimePos != null &&
                                    sAppointmentTimePos == position
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
            return Container();
          }
        } else {
          return Container();
        }
      },
    );
  }

  void validateAndMake() async {
    String symptoms = mSymtomsController.text.toString().trim();
    String medicineTaken = mMedicineTakenController.text.toString().trim();
    String addNote = mDescriptionController.text.toString().trim();
    log("strDate :==> $strDate");
    log("strStartTime :==> $strStartTime");
    log("strEndTime :==> $strEndTime");
    log("appointmentSlotId :==> $appointmentSlotId");
    log("symptoms :==> $symptoms");
    log("medicineTaken :==> $medicineTaken");
    log("additional Note :==> $addNote");
    if (symptoms.isEmpty) {
      symptoms = "";
    }
    if (medicineTaken.isEmpty) {
      medicineTaken = "";
    }
    if (addNote.isEmpty) {
      addNote = "";
    }
    if (strDate!.isEmpty) {
      Utility.showToast(selectAppointmentDate);
    } else if (strStartTime!.isEmpty) {
      Utility.showToast(selectAppointmentTime);
    } else {
      final bookAppointmentProvider =
          Provider.of<BookAppointmentProvider>(context, listen: false);
      // login API call
      Utility.showProgress(context, prDialog);
      await bookAppointmentProvider.getMakeAppointment(
          widget.doctorID,
          strDate,
          strStartTime,
          appointmentSlotId,
          strEndTime,
          symptoms,
          medicineTaken,
          addNote);
      await prDialog.hide();
      clearTextFormField();
      showMyDialog();
    }
  }

  void clearTextFormField() {
    mSymtomsController.clear();
    mMedicineTakenController.clear();
    mDescriptionController.clear();
  }

  Future<void> showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                MySvgAssetsImg(
                  imageName: "thumb.svg",
                  fit: BoxFit.contain,
                  imgHeight: 112,
                  imgWidth: 112,
                ),
                const SizedBox(height: 30),
                MyText(
                  mTitle: thankYou,
                  mTextColor: black,
                  mFontSize: 30,
                  mFontStyle: FontStyle.normal,
                  mFontWeight: FontWeight.w600,
                  mTextAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                MyText(
                  mTitle: successfulBookingDesc,
                  mTextColor: black,
                  mFontSize: 15,
                  mFontStyle: FontStyle.normal,
                  mFontWeight: FontWeight.normal,
                  mTextAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                MyText(
                  mTitle: "$youBookedAnAppointmentWith ${widget.doctorName}.",
                  mTextColor: otherColor,
                  mFontSize: 15,
                  mFontStyle: FontStyle.normal,
                  mFontWeight: FontWeight.normal,
                  mTextAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: MyText(
                mTitle: done,
                mTextColor: primaryDarkColor,
                mFontSize: 20,
                mFontStyle: FontStyle.normal,
                mFontWeight: FontWeight.w600,
                mTextAlign: TextAlign.center,
              ),
              onPressed: () {
                clearTextFormField();
                Navigator.pop(context);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
