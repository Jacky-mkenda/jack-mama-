import 'package:patientapp/model/doctormodel.dart';
import 'package:patientapp/webservice/apiservices.dart';
import 'package:flutter/material.dart';

class DoctorDetailProvider extends ChangeNotifier {
  DoctorModel doctorModel = DoctorModel();

  bool loading = false;

  Future<void> getDoctorDetail(doctorId) async {
    debugPrint("getDoctorDetail doctorId :==> $doctorId");
    loading = true;
    doctorModel = await ApiService().doctorDetail(doctorId);
    debugPrint("doctor_detail status :==> ${doctorModel.status}");
    debugPrint("doctor_detail message :==> ${doctorModel.message}");
    loading = false;
    notifyListeners();
  }
}
