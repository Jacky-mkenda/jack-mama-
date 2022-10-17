import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:patientapp/model/appointmentmodel.dart';
import 'package:patientapp/model/doctormodel.dart';
import 'package:patientapp/model/generalsettingmodel.dart';
import 'package:patientapp/model/loginregistermodel.dart';
import 'package:patientapp/model/notificationmodel.dart';
import 'package:patientapp/model/profilemodel.dart';
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

  // registration API
  Future<LoginRegisterModel> patientRegistration(
      email,
      password,
      firstName,
      lastName,
      mobileNumber,
      deviceToken,
      insCompanyId,
      insNumber,
      File? insImageFile) async {
    LoginRegisterModel loginRegisterModel;
    String registrationAPI = "registration";
    log("registration API :==> $baseUrl$registrationAPI");
    log("Insurance Filename :==> ${insImageFile!.path.split('/').last}");
    log("Insurance Extension :==> ${insImageFile.path.split('/').last.split(".").last}");
    Response response = await dio.post(
      '$baseUrl$registrationAPI',
      data: FormData.fromMap({
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
        'mobile_number': mobileNumber,
        'device_token': deviceToken,
        'insurance_company_id': insCompanyId ?? "0",
        'insurance_no': insNumber ?? "0",
        "insurance_card_pic": insImageFile.path.isNotEmpty
            ? (await MultipartFile.fromFile(
                insImageFile.path,
                filename: insImageFile.path.split('/').last,
              ))
            : "",
      }),
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    log("patientRegistration statuscode :===> ${response.statusCode}");
    log("patientRegistration Message :===> ${response.statusMessage}");
    log("patientRegistration data :===> ${response.data}");
    loginRegisterModel = loginRegisterModelFromJson(response.data.toString());
    return loginRegisterModel;
  }

  // login API
  Future<LoginRegisterModel> patientLogin(
      email, password, type, deviceToken) async {
    log("email :==> $email");
    log("password :==> $password");
    log("type :==> $type");
    log("deviceToken :==> $deviceToken");

    LoginRegisterModel loginModel;
    String doctorLogin = "login";
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

    log("patientLogin statuscode :===> ${response.statusCode}");
    log("patientLogin Message :===> ${response.statusMessage}");
    log("patientLogin data :===> ${response.data}");
    loginModel = loginRegisterModelFromJson(response.data.toString());
    return loginModel;
  }

  // profile API
  Future<ProfileModel> patientProfile() async {
    log("userId :==> ${Constant.userID}");

    ProfileModel profileModel;
    String doctorLogin = "profile";
    Response response = await dio.post(
      '$baseUrl$doctorLogin',
      data: {
        'user_id': Constant.userID,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    log("patientProfile statuscode :===> ${response.statusCode}");
    log("patientProfile Message :===> ${response.statusMessage}");
    log("patientProfile data :===> ${response.data}");
    profileModel = profileModelFromJson(response.data.toString());
    return profileModel;
  }

  // get_patient_appoinment API
  Future<NotificationModel> getPatientNotification() async {
    log("patientID :==> ${Constant.userID}");

    NotificationModel notificationModel;
    String patientAppoinments = "get_patient_appoinment";
    log("Notification API :==> $baseUrl$patientAppoinments");
    Response response = await dio.post(
      '$baseUrl$patientAppoinments',
      data: {
        'patient_id': Constant.userID,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    log("getPatientNotification statuscode :===> ${response.statusCode}");
    log("getPatientNotification Message :===> ${response.statusMessage}");
    log("getPatientNotification data :===> ${response.data}");
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
  Future<SpecialityModel> specialities() async {
    SpecialityModel specialityModel;
    String getSpecialities = "get_specialities";
    log("Speciality API :==> $baseUrl$getSpecialities");
    Response response = await dio.post(
      '$baseUrl$getSpecialities',
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    log("specialities statuscode :===> ${response.statusCode}");
    log("specialities Message :===> ${response.statusMessage}");
    log("specialities data :===> ${response.data}");
    specialityModel = specialityModelFromJson(response.data.toString());
    return specialityModel;
  }

  // get_doctor API
  Future<DoctorModel> doctor() async {
    DoctorModel doctorModel;
    String getDoctor = "get_doctor";
    log("Doctor API :==> $baseUrl$getDoctor");
    Response response = await dio.post(
      '$baseUrl$getDoctor',
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    log("doctor statuscode :===> ${response.statusCode}");
    log("doctor Message :===> ${response.statusMessage}");
    log("doctor data :===> ${response.data}");
    doctorModel = doctorModelFromJson(response.data.toString());
    return doctorModel;
  }

  // doctor_detail API
  Future<DoctorModel> doctorDetail(doctorId) async {
    log("doctorID :==> $doctorId");

    DoctorModel doctorModel;
    String doctorDetail = "doctor_detail";
    log("DoctorDetail API :==> $baseUrl$doctorDetail");
    Response response = await dio.post(
      '$baseUrl$doctorDetail',
      data: {
        'id': doctorId,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    log("doctorDetail statuscode :===> ${response.statusCode}");
    log("doctorDetail Message :===> ${response.statusMessage}");
    log("doctorDetail data :===> ${response.data}");
    doctorModel = doctorModelFromJson(response.data.toString());
    return doctorModel;
  }

  // searchDoctor API
  Future<DoctorModel> searchDoctor(strName) async {
    log("strName :==> $strName");

    DoctorModel doctorModel;
    String searchDoctor = "searchDoctor";
    log("searchDoctor API :==> $baseUrl$searchDoctor");
    Response response = await dio.post(
      '$baseUrl$searchDoctor',
      data: {
        'name': strName,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    log("searchDoctor statuscode :===> ${response.statusCode}");
    log("searchDoctor Message :===> ${response.statusMessage}");
    log("searchDoctor data :===> ${response.data}");
    doctorModel = doctorModelFromJson(response.data.toString());
    return doctorModel;
  }

  // upcoming_appoinment API
  Future<AppointmentModel> upcomingAppointment() async {
    log("patientID :==> ${Constant.userID}");

    AppointmentModel appointmentModel;
    String upcomingAppoinment = "upcoming_appoinment";
    log("upcomingAppoinment API :==> $baseUrl$upcomingAppoinment");
    Response response = await dio.post(
      '$baseUrl$upcomingAppoinment',
      data: {
        'user_id': Constant.userID,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    log("upcomingAppointment statuscode :===> ${response.statusCode}");
    log("upcomingAppointment Message :===> ${response.statusMessage}");
    log("upcomingAppointment data :===> ${response.data}");
    appointmentModel = appointmentModelFromJson(response.data.toString());
    return appointmentModel;
  }

  // get_test_patient_appoinment API
  Future<AppointmentModel> upcomingTestAppoinment() async {
    log("patientID :==> ${Constant.userID}");

    AppointmentModel appointmentModel;
    String upcomingTestAppoinment = "get_test_patient_appoinment";
    log("upcomingTestAppoinment API :==> $baseUrl$upcomingTestAppoinment");
    Response response = await dio.post(
      '$baseUrl$upcomingTestAppoinment',
      data: {
        'patient_id': Constant.userID,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    log("upcomingTestAppoinment statuscode :===> ${response.statusCode}");
    log("upcomingTestAppoinment Message :===> ${response.statusMessage}");
    log("upcomingTestAppoinment data :===> ${response.data}");
    appointmentModel = appointmentModelFromJson(response.data.toString());
    return appointmentModel;
  }

  // appoinment_detail API
  Future<AppointmentModel> appointmentDetails(appointmentId) async {
    log("appointmentId :==> $appointmentId");

    AppointmentModel appointmentModel;
    String appoinmentDetail = "appoinment_detail";
    log("appoinmentDetail API :==> $baseUrl$appoinmentDetail");
    Response response = await dio.post(
      '$baseUrl$appoinmentDetail',
      data: {
        'id': appointmentId,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    log("appointmentDetails statuscode :===> ${response.statusCode}");
    log("appointmentDetails Message :===> ${response.statusMessage}");
    log("appointmentDetails data :===> ${response.data}");
    appointmentModel = appointmentModelFromJson(response.data.toString());
    return appointmentModel;
  }

  // get_all_appoinment API
  Future<AppointmentModel> allAppointment() async {
    log("patientID :==> ${Constant.userID}");

    AppointmentModel appointmentModel;
    String allAppoinment = "get_all_appoinment";
    log("allAppoinment API :==> $baseUrl$allAppoinment");
    Response response = await dio.post(
      '$baseUrl$allAppoinment',
      data: {
        'user_id': Constant.userID,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    log("allAppointment statuscode :===> ${response.statusCode}");
    log("allAppointment Message :===> ${response.statusMessage}");
    log("allAppointment data :===> ${response.data}");
    appointmentModel = appointmentModelFromJson(response.data.toString());
    return appointmentModel;
  }

  // get_medicine_history API
  Future<AppointmentModel> medicineHistory() async {
    log("patientID :==> ${Constant.userID}");

    AppointmentModel appointmentModel;
    String medicineHistory = "get_medicine_history";
    log("medicineHistory API :==> $baseUrl$medicineHistory");
    Response response = await dio.post(
      '$baseUrl$medicineHistory',
      data: {
        'patient_id': Constant.userID,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    log("medicineHistory statuscode :===> ${response.statusCode}");
    log("medicineHistory Message :===> ${response.statusMessage}");
    log("medicineHistory data :===> ${response.data}");
    appointmentModel = appointmentModelFromJson(response.data.toString());
    return appointmentModel;
  }
}
