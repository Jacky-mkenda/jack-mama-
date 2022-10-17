import 'package:patientapp/model/appointmentmodel.dart';
import 'package:patientapp/webservice/apiservices.dart';
import 'package:flutter/material.dart';

class AppointmentDetailProvider extends ChangeNotifier {
  AppointmentModel appointmentModel = AppointmentModel();

  bool loading = false;

  Future<void> getAppointmentDetail(appointmentId) async {
    debugPrint("getAppointmentDetail appointmentId :==> $appointmentId");
    loading = true;
    appointmentModel = await ApiService().appointmentDetails(appointmentId);
    debugPrint("appoinment_detail status :==> ${appointmentModel.status}");
    debugPrint("appoinment_detail message :==> ${appointmentModel.message}");
    loading = false;
    notifyListeners();
  }
}
