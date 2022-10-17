import 'package:patientapp/model/notificationmodel.dart';
import 'package:patientapp/model/successmodel.dart';
import 'package:patientapp/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/utils/sharedpre.dart';
import 'package:patientapp/webservice/apiservices.dart';

class NotificationProvider extends ChangeNotifier {
  NotificationModel notificationModel = NotificationModel();
  SuccessModel successModel = SuccessModel();

  bool loading = false;
  SharedPre sharePref = SharedPre();

  Future<void> getPatientNotification() async {
    debugPrint("getPatientNotification patientID :==> ${Constant.userID}");
    loading = true;
    notificationModel = await ApiService().getPatientNotification();
    debugPrint(
        "get_patient_appoinment status :==> ${notificationModel.status}");
    debugPrint(
        "get_patient_appoinment message :==> ${notificationModel.message}");
    loading = false;
    notifyListeners();
  }

  Future<void> removeNotification(itemID, status) async {
    debugPrint("removeNotification itemID :==> $itemID");
    debugPrint("removeNotification status :==> $status");
    loading = true;
    successModel = await ApiService().updateNotificationStatus(itemID, status);
    debugPrint("updateNotificationStatus status :==> ${successModel.status}");
    debugPrint("updateNotificationStatus message :==> ${successModel.message}");
    loading = false;
    notifyListeners();
  }
}
