import 'package:patientapp/model/appointmentmodel.dart';
import 'package:patientapp/utils/constant.dart';
import 'package:patientapp/utils/sharedpre.dart';
import 'package:patientapp/webservice/apiservices.dart';
import 'package:flutter/material.dart';

class AllAppointmentProvider extends ChangeNotifier {
  AppointmentModel appointmentModel = AppointmentModel();

  bool loading = false;

  SharedPre sharePref = SharedPre();

  Future<void> getAllAppointment() async {
    debugPrint("getAllAppointment patientID :==> ${Constant.userID}");
    loading = true;
    appointmentModel = await ApiService().allAppointment();
    debugPrint("get_all_appoinment status :==> ${appointmentModel.status}");
    debugPrint("get_all_appoinment message :==> ${appointmentModel.message}");
    loading = false;
    notifyListeners();
  }
}
