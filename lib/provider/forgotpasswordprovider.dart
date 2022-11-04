import 'package:flutter/material.dart';
import 'package:patientapp/model/successmodel.dart';
import 'package:patientapp/utils/sharedpre.dart';
import 'package:patientapp/webservice/apiservices.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  SuccessModel successModel = SuccessModel();

  bool loading = false;

  SharedPre sharePref = SharedPre();

  Future<void> getForgotPassword(email) async {
    debugPrint("getForgotPassword Email :==> $email");
    loading = true;
    successModel = await ApiService().forgotPassword(email);
    debugPrint("forgot_password status :==> ${successModel.status}");
    debugPrint("forgot_password message :==> ${successModel.message}");
    loading = false;
    notifyListeners();
  }
}
