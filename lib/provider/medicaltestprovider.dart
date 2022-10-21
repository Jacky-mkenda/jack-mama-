import 'dart:developer';

import 'package:patientapp/model/appointmentmodel.dart';
import 'package:patientapp/model/successmodel.dart';
import 'package:patientapp/model/testtimeslotmodel.dart';
import 'package:patientapp/utils/constant.dart';
import 'package:patientapp/utils/sharedpre.dart';
import 'package:patientapp/webservice/apiservices.dart';
import 'package:flutter/material.dart';

class MedicalTestProvider extends ChangeNotifier {
  AppointmentModel appointmentModel = AppointmentModel();
  AppointmentModel patientTestModel = AppointmentModel();
  TestTimeSlotModel testTimeSlotModel = TestTimeSlotModel();
  SuccessModel successModel = SuccessModel();

  int? availableTimePos, appointmentTimePos;
  bool loading = false, isDateSelected = false;

  SharedPre sharePref = SharedPre();

  Future<void> getMedicineHistory() async {
    debugPrint("getMedicineHistory patientID :==> ${Constant.userID}");
    loading = true;
    appointmentModel = await ApiService().medicineHistory();
    debugPrint("get_medicine_history status :==> ${appointmentModel.status}");
    debugPrint("get_medicine_history message :==> ${appointmentModel.message}");
    loading = false;
    notifyListeners();
  }

  Future<void> getTestPatientAppointment() async {
    debugPrint("getTestPatientAppointment patientID :==> ${Constant.userID}");
    loading = true;
    patientTestModel = await ApiService().patientTestAppointment();
    debugPrint(
        "get_test_patient_appoinment status :==> ${patientTestModel.status}");
    debugPrint(
        "get_test_patient_appoinment message :==> ${patientTestModel.message}");
    loading = false;
    notifyListeners();
  }

  Future<void> getTestTimeSlot(date) async {
    debugPrint("getTestTimeSlot date :==> $date");
    debugPrint("getTestTimeSlot patientID :==> ${Constant.userID}");
    loading = true;
    testTimeSlotModel = await ApiService().testTimeSlot(date);
    debugPrint("getTestTimeSlot status :==> ${testTimeSlotModel.status}");
    debugPrint("getTestTimeSlot message :==> ${testTimeSlotModel.message}");
    loading = false;
    notifyListeners();
  }

  Future<void> getMakeTestAppointment(
      date, startTime, slotsId, endTime, description) async {
    debugPrint("getMakeTestAppointment patientID :==> ${Constant.userID}");
    loading = true;
    successModel = await ApiService()
        .makeTestAppoinment(date, startTime, slotsId, endTime, description);
    debugPrint("make_test_appoinment status :==> ${successModel.status}");
    debugPrint("make_test_appoinment message :==> ${successModel.message}");
    loading = false;
    notifyListeners();
  }

  getClickedDate(isClicked) {
    loading = true;
    log("isClicked ===> $isClicked");
    isDateSelected = isClicked;
    loading = false;
    notifyListeners();
  }

  getClickAvailableTime(clickedPos) {
    loading = true;
    log("clickedPos ===> $clickedPos");
    availableTimePos = clickedPos;
    loading = false;
    notifyListeners();
  }

  getClickAappointmentTime(clickedPos) {
    loading = true;
    log("clickedPos ===> $clickedPos");
    appointmentTimePos = clickedPos;
    loading = false;
    notifyListeners();
  }

  clearTestBookProvider() {
    log("<================ clearTestBookProvider ================>");
    appointmentTimePos = -1;
    availableTimePos = -1;
    isDateSelected = false;
    testTimeSlotModel = TestTimeSlotModel();
    successModel = SuccessModel();
  }
}
