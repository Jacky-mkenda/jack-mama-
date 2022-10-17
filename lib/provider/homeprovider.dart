import 'package:patientapp/model/appointmentmodel.dart';
import 'package:patientapp/model/doctormodel.dart';
import 'package:patientapp/model/notificationmodel.dart';
import 'package:patientapp/model/profilemodel.dart';
import 'package:patientapp/model/specialitymodel.dart';
import 'package:patientapp/model/successmodel.dart';
import 'package:patientapp/utils/constant.dart';
import 'package:patientapp/utils/sharedpre.dart';
import 'package:patientapp/webservice/apiservices.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  ProfileModel profileModel = ProfileModel();
  NotificationModel notificationModel = NotificationModel();
  SpecialityModel specialityModel = SpecialityModel();
  DoctorModel doctorModel = DoctorModel();
  AppointmentModel appointmentModel = AppointmentModel();
  AppointmentModel testAppointmentModel = AppointmentModel();
  SuccessModel successModel = SuccessModel();

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

  Future<void> getSpecialities() async {
    loading = true;
    specialityModel = await ApiService().specialities();
    debugPrint("get_specialities status :==> ${specialityModel.status}");
    debugPrint("get_specialities message :==> ${specialityModel.message}");
    loading = false;
    notifyListeners();
  }

  Future<void> getUpcomingAppointment() async {
    debugPrint("getUpcomingAppointment patientID :==> ${Constant.userID}");
    loading = true;
    appointmentModel = await ApiService().upcomingAppointment();
    debugPrint("upcoming_appoinment status :==> ${appointmentModel.status}");
    debugPrint("upcoming_appoinment message :==> ${appointmentModel.message}");
    loading = false;
    notifyListeners();
  }

  Future<void> getUpcomingTestAppointment() async {
    debugPrint("getUpcomingAppointment patientID :==> ${Constant.userID}");
    loading = true;
    testAppointmentModel = await ApiService().upcomingTestAppoinment();
    debugPrint(
        "upcoming_appoinment status :==> ${testAppointmentModel.status}");
    debugPrint(
        "upcoming_appoinment message :==> ${testAppointmentModel.message}");
    loading = false;
    notifyListeners();
  }

  Future<void> getDoctor() async {
    loading = true;
    doctorModel = await ApiService().doctor();
    debugPrint("get_doctor status :==> ${doctorModel.status}");
    debugPrint("get_doctor message :==> ${doctorModel.message}");
    loading = false;
    notifyListeners();
  }
}
