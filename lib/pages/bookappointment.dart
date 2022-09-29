import 'dart:developer';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patientapp/utils/colors.dart';
import 'package:patientapp/utils/constant.dart';
import 'package:patientapp/utils/strings.dart';
import 'package:patientapp/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/widgets/mytext.dart';
import 'package:patientapp/widgets/mytextformfield.dart';

class BookAppointment extends StatefulWidget {
  const BookAppointment({Key? key}) : super(key: key);

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  final DatePickerController mDateController = DatePickerController();
  late DateTime selectedDate = DateTime.now();
  final mSymtomsController = TextEditingController();
  final mMedicineTakenController = TextEditingController();
  final mDescriptionController = TextEditingController();
  dynamic sAvailableTime, sAppointmentTime;

  @override
  void initState() {
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
      appBar: Utility.appBarCommon(makeAnAppointment),
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
              children: <Widget>[
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: DatePicker(
                    DateTime.now(),
                    controller: mDateController,
                    initialSelectedDate: DateTime.now(),
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
                        child: appointmentTimeList(),
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
                            showMyDialog();
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
    return AlignedGridView.count(
      shrinkWrap: true,
      crossAxisCount: 5,
      crossAxisSpacing: 9,
      mainAxisSpacing: 9,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(left: 20, right: 20),
      itemCount: 12,
      itemBuilder: (BuildContext context, int position) => InkWell(
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
      ),
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
                      "Date : $selectedDate\nSymptoms : ${mSymtomsController.text}\nMedicine Taken : ${mMedicineTakenController.text}\nDescription : ${mDescriptionController.text}",
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

  void clearTextFormField() {
    mSymtomsController.clear();
    mMedicineTakenController.clear();
    mDescriptionController.clear();
  }
}
