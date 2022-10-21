import 'dart:developer';

import 'package:patientapp/model/successmodel.dart';
import 'package:patientapp/model/timeslotmodel.dart';
import 'package:patientapp/utils/constant.dart';
import 'package:patientapp/utils/sharedpre.dart';
import 'package:patientapp/webservice/apiservices.dart';
import 'package:flutter/material.dart';

class BookAppointmentProvider extends ChangeNotifier {
  TimeSlotModel timeSlotModel = TimeSlotModel();
  SuccessModel successModel = SuccessModel();

  bool loading = false, isDateSelected = false;
  int? availableTimePos, appointmentTimePos;

  SharedPre sharePref = SharedPre();

  Future<void> getTimeSlotByDoctorId(doctorId, date) async {
    debugPrint("getTimeSlotByDoctorId doctorId :==> $doctorId");
    debugPrint("getTimeSlotByDoctorId date :==> $date");
    loading = true;
    timeSlotModel = await ApiService().timeSlotByDoctorId(doctorId, date);
    debugPrint("getTimeSlotByDoctorId status :==> ${timeSlotModel.status}");
    debugPrint("getTimeSlotByDoctorId message :==> ${timeSlotModel.message}");
    loading = false;
    notifyListeners();
  }

  Future<void> getMakeAppointment(doctorId, date, startTime, slotsId, endTime,
      symptoms, medicinesTaken, description) async {
    debugPrint("getMakeAppointment patientID :==> ${Constant.userID}");
    loading = true;
    successModel = await ApiService().makeAppoinment(doctorId, date, startTime,
        slotsId, endTime, symptoms, medicinesTaken, description);
    debugPrint("make_appoinment status :==> ${successModel.status}");
    debugPrint("make_appoinment message :==> ${successModel.message}");
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

  clearBookProvider() {
    log("<================ clearBookProvider ================>");
    appointmentTimePos = -1;
    availableTimePos = -1;
    isDateSelected = false;
    timeSlotModel = TimeSlotModel();
    successModel = SuccessModel();
  }
}
