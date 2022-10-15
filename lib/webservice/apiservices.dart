import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:patientapp/model/generalsettingmodel.dart';
import 'package:patientapp/model/loginregistermodel.dart';
import 'package:patientapp/model/notificationmodel.dart';
import 'package:patientapp/model/specialitymodel.dart';
import 'package:patientapp/model/successmodel.dart';
import 'package:patientapp/utils/constant.dart';

class ApiService {
  String baseUrl = '${Constant.baseurl}/api/';

  late Dio dio;

  ApiService() {
    dio = Dio();
  }

  // genaral_setting API
  Future<GeneralSettingModel> genaralSetting() async {
    GeneralSettingModel generalSettingModel;
    String generalsetting = "genaral_setting";
    Response response = await dio.get('$baseUrl$generalsetting');
    log('genaralSetting response ==>>> ${response.data}');
    log('genaralSetting statusCode ==>>> ${response.statusCode}');
    generalSettingModel = generalSettingModelFromJson(response.data.toString());
    return generalSettingModel;
  }

  // doctor_registration API
  Future<LoginRegisterModel> doctorRegistration(
      firstName, lastName, email, password, mobile, deviceToken) async {
    log("firstName :==> $firstName");
    log("lastName :==> $lastName");
    log("email :==> $email");
    log("password :==> $password");
    log("mobile :==> $mobile");
    log("deviceToken :==> $deviceToken");

    LoginRegisterModel registerModel;
    String registration = "doctor_registration";
    Response response = await dio.post(
      '$baseUrl$registration',
      data: {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
        'mobile_number': mobile,
        'device_token': deviceToken
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    log("doctorRegistration statuscode :===> ${response.statusCode}");
    log("doctorRegistration Message :===> ${response.statusMessage}");
    log("doctorRegistration data :===> ${response.data}");
    registerModel = loginRegisterModelFromJson(response.data.toString());
    return registerModel;
  }

  // doctor_login API
  Future<LoginRegisterModel> doctorLogin(
      email, password, type, deviceToken) async {
    log("email :==> $email");
    log("password :==> $password");
    log("type :==> $type");
    log("deviceToken :==> $deviceToken");

    LoginRegisterModel loginModel;
    String doctorLogin = "doctor_login";
    Response response = await dio.post(
      '$baseUrl$doctorLogin',
      data: {
        'email': email,
        'password': password,
        'type': type,
        'device_token': deviceToken
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    log("doctorLogin statuscode :===> ${response.statusCode}");
    log("doctorLogin Message :===> ${response.statusMessage}");
    log("doctorLogin data :===> ${response.data}");
    loginModel = loginRegisterModelFromJson(response.data.toString());
    return loginModel;
  }

  // get_doctor_appoinment API
  Future<NotificationModel> getDoctorNotification() async {
    log("doctorID :==> ${Constant.userID}");

    NotificationModel notificationModel;
    String doctorAppoinments = "get_doctor_appoinment";
    log("Notification API :==> $baseUrl$doctorAppoinments");
    Response response = await dio.post(
      '$baseUrl$doctorAppoinments',
      data: {
        'doctor_id': Constant.userID,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    log("getDoctorNotification statuscode :===> ${response.statusCode}");
    log("getDoctorNotification Message :===> ${response.statusMessage}");
    log("getDoctorNotification data :===> ${response.data}");
    notificationModel = notificationModelFromJson(response.data.toString());
    return notificationModel;
  }

  // updateNotificationStatus API
  Future<SuccessModel> updateNotificationStatus(itemID, status) async {
    log("itemID :==> $itemID");
    log("status :==> $status");

    SuccessModel successModel;
    String updateNotificationStatus = "updateNotificationStatus";
    log("updateNotificationStatus API :==> $baseUrl$updateNotificationStatus");
    Response response = await dio.post(
      '$baseUrl$updateNotificationStatus',
      data: {
        'id': itemID,
        'status': status,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    log("updateNotificationStatus statuscode :===> ${response.statusCode}");
    log("updateNotificationStatus Message :===> ${response.statusMessage}");
    log("updateNotificationStatus data :===> ${response.data}");
    successModel = successModelFromJson(response.data.toString());
    return successModel;
  }

  // get_specialities API
  Future<SpecialityModel> getDoctorSpecialities() async {
    SpecialityModel specialityModel;
    String getSpecialities = "get_specialities";
    log("Speciality API :==> $baseUrl$getSpecialities");
    Response response = await dio.post(
      '$baseUrl$getSpecialities',
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    log("getDoctorSpecialities statuscode :===> ${response.statusCode}");
    log("getDoctorSpecialities Message :===> ${response.statusMessage}");
    log("getDoctorSpecialities data :===> ${response.data}");
    specialityModel = specialityModelFromJson(response.data.toString());
    return specialityModel;
  }
}
