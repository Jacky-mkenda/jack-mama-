import 'package:patientapp/model/profilemodel.dart';
import 'package:patientapp/utils/constant.dart';
import 'package:patientapp/utils/sharedpre.dart';
import 'package:patientapp/webservice/apiservices.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileModel profileModel = ProfileModel();

  bool loading = false;

  SharedPre sharePref = SharedPre();

  Future<void> getPatientProfile() async {
    debugPrint("getPatientProfile patientID :==> ${Constant.userID}");
    loading = true;
    profileModel = await ApiService().patientProfile();
    debugPrint("profile status :==> ${profileModel.status}");
    debugPrint("profile message :==> ${profileModel.message}");
    loading = false;
    notifyListeners();
  }
}
