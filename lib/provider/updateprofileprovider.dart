import 'package:patientapp/model/profilemodel.dart';
import 'package:patientapp/model/successmodel.dart';
import 'package:patientapp/utils/constant.dart';
import 'package:patientapp/utils/sharedpre.dart';
import 'package:patientapp/webservice/apiservices.dart';
import 'package:flutter/material.dart';

class UpdateProfileProvider extends ChangeNotifier {
  ProfileModel profileModel = ProfileModel();
  SuccessModel successPersonalModel = SuccessModel();
  SuccessModel successBMIModel = SuccessModel();

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

  Future<void> getUpdatePersonalDetails(
      email,
      firstName,
      lastName,
      mobileNumber,
      insCompanyId,
      insNumber,
      insImage,
      patientProfileImg) async {
    debugPrint("getUpdatePersonalDetails patientID :==> ${Constant.userID}");
    loading = true;
    successPersonalModel = await ApiService().updatePersonalDetails(
        Constant.userID,
        email,
        firstName,
        lastName,
        mobileNumber,
        insCompanyId,
        insNumber,
        insImage,
        patientProfileImg);
    debugPrint("updateprofile status :==> ${successPersonalModel.status}");
    debugPrint("updateprofile message :==> ${successPersonalModel.message}");
    loading = false;
    notifyListeners();
  }

  Future<void> getUpdateBMI(allergiesToMedicine, cHeight, cWeight, bMI) async {
    debugPrint("getUpdatePatientProfile patientID :==> ${Constant.userID}");
    loading = true;
    successBMIModel = await ApiService().updateBMIDetails(
        Constant.userID, allergiesToMedicine, cHeight, cWeight, bMI);
    debugPrint("updateprofile status :==> ${successBMIModel.status}");
    debugPrint("updateprofile message :==> ${successBMIModel.message}");
    loading = false;
    notifyListeners();
  }
}
