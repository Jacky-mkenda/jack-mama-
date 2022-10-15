import 'package:patientapp/model/generalsettingmodel.dart';
import 'package:patientapp/model/loginregistermodel.dart';
import 'package:patientapp/utils/sharedpre.dart';
import 'package:patientapp/webservice/apiservices.dart';
import 'package:flutter/material.dart';

class GeneralProvider extends ChangeNotifier {
  GeneralSettingModel generalSettingModel = GeneralSettingModel();
  LoginRegisterModel loginRegisterModel = LoginRegisterModel();

  bool loading = false;

  SharedPre sharePref = SharedPre();

  Future<void> getGeneralsetting(context) async {
    loading = true;
    generalSettingModel = await ApiService().genaralSetting();
    debugPrint("genaral_setting status :==> ${generalSettingModel.status}");
    loading = false;
    notifyListeners();
  }

  Future<void> registerDoctor(
      firstName, lastName, email, password, mobile, deviceToken) async {
    debugPrint("registerDoctor firstName :==> $firstName");
    debugPrint("registerDoctor lastName :==> $lastName");
    debugPrint("registerDoctor email :==> $email");
    debugPrint("registerDoctor password :==> $password");
    debugPrint("registerDoctor mobile :==> $mobile");
    debugPrint("registerDoctor deviceToken :==> $deviceToken");

    loading = true;
    loginRegisterModel = await ApiService().doctorRegistration(
        firstName, lastName, email, password, mobile, deviceToken);
    debugPrint("doctor_registration status :==> ${loginRegisterModel.status}");
    debugPrint(
        "doctor_registration message :==> ${loginRegisterModel.message}");

    loading = false;
    notifyListeners();
  }

  Future<void> loginDoctor(email, password, type, deviceToken) async {
    debugPrint("loginDoctor email :==> $email");
    debugPrint("loginDoctor password :==> $password");
    debugPrint("loginDoctor type :==> $type");
    debugPrint("loginDoctor deviceToken :==> $deviceToken");

    loading = true;
    loginRegisterModel =
        await ApiService().doctorLogin(email, password, type, deviceToken);
    debugPrint("doctor_login status :==> ${loginRegisterModel.status}");
    debugPrint("doctor_login message :==> ${loginRegisterModel.message}");
    loading = false;
    notifyListeners();
  }
}
