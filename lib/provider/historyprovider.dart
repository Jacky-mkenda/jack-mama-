import 'package:patientapp/model/appointmentmodel.dart';
import 'package:patientapp/utils/constant.dart';
import 'package:patientapp/utils/sharedpre.dart';
import 'package:patientapp/webservice/apiservices.dart';
import 'package:flutter/material.dart';

class HistoryProvider extends ChangeNotifier {
  AppointmentModel appointmentModel = AppointmentModel();

  bool loading = false;

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
}
