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

  Future<void> registerPatient(firstName, lastName, email, password, mobile,
      deviceToken, insCompanyId, insNumber, insImage) async {
    debugPrint("registerPatient firstName :==> $firstName");
    debugPrint("registerPatient lastName :==> $lastName");
    debugPrint("registerPatient email :==> $email");
    debugPrint("registerPatient password :==> $password");
    debugPrint("registerPatient mobile :==> $mobile");
    debugPrint("registerPatient deviceToken :==> $deviceToken");
    debugPrint("registerPatient insCompanyId :==> $insCompanyId");
    debugPrint("registerPatient insNumber :==> $insNumber");
    debugPrint("registerPatient insImage :==> $insImage");

    loading = true;
    loginRegisterModel = await ApiService().patientRegistration(
        email,
        password,
        firstName,
        lastName,
        mobile,
        deviceToken,
        insCompanyId,
        insNumber,
        insImage);
    debugPrint("registration status :==> ${loginRegisterModel.status}");
    debugPrint("registration message :==> ${loginRegisterModel.message}");

    loading = false;
    notifyListeners();
  }

  Future<void> loginPatient(email, password, type, deviceToken) async {
    debugPrint("loginPatient email :==> $email");
    debugPrint("loginPatient password :==> $password");
    debugPrint("loginPatient type :==> $type");
    debugPrint("loginPatient deviceToken :==> $deviceToken");

    loading = true;
    loginRegisterModel =
        await ApiService().patientLogin(email, password, type, deviceToken);
    debugPrint("login status :==> ${loginRegisterModel.status}");
    debugPrint("login message :==> ${loginRegisterModel.message}");
    loading = false;
    notifyListeners();
  }
}
