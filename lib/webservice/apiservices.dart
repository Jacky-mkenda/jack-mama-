import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_logger/dio_logger.dart';
import 'package:patientapp/model/appointmentmodel.dart';
import 'package:patientapp/model/doctormodel.dart';
import 'package:patientapp/model/generalsettingmodel.dart';
import 'package:patientapp/model/loginregistermodel.dart';
import 'package:patientapp/model/notificationmodel.dart';
import 'package:patientapp/model/prescriptiondetailmodel.dart';
import 'package:patientapp/model/profilemodel.dart';
import 'package:patientapp/model/specialitymodel.dart';
import 'package:patientapp/model/successmodel.dart';
import 'package:patientapp/model/testtimeslotmodel.dart';
import 'package:patientapp/model/timeslotmodel.dart';
import 'package:patientapp/utils/constant.dart';

class ApiService {
  String baseUrl = '${Constant.baseurl}/api/';

  late Dio dio;

  ApiService() {
    dio = Dio();
    dio.interceptors.add(dioLoggerInterceptor);
  }

  // genaral_setting API
  Future<GeneralSettingModel> genaralSetting() async {
    GeneralSettingModel generalSettingModel;
    String generalsetting = "genaral_setting";
    Response response = await dio.post('$baseUrl$generalsetting');
    generalSettingModel = GeneralSettingModel.fromJson(response.data);
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
    Response response = await dio.post(
      '$baseUrl$registrationAPI',
      data: FormData.fromMap({
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
        'mobile_number': mobileNumber,
        'device_token': deviceToken,
        'insurance_company_id': "",
        'insurance_no': "",
        "insurance_card_pic": "",
      }),
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    loginRegisterModel = LoginRegisterModel.fromJson(response.data);
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
    loginModel = LoginRegisterModel.fromJson(response.data);
    return loginModel;
  }

  // forgot_password API
  Future<SuccessModel> forgotPassword(email) async {
    log("email :==> $email");

    SuccessModel successModel;
    String doctorLogin = "forgot_password";
    Response response = await dio.post(
      '$baseUrl$doctorLogin',
      data: {
        'email': email,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    log("forgotPassword statuscode :===> ${response.statusCode}");
    log("forgotPassword Message :===> ${response.statusMessage}");
    log("forgotPassword data :===> ${response.data}");
    successModel = SuccessModel.fromJson(response.data);
    return successModel;
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
    profileModel = ProfileModel.fromJson(response.data);
    return profileModel;
  }

  // updateprofile API
  Future<SuccessModel> updatePersonalDetails(
      userId,
      email,
      firstName,
      lastName,
      mobileNumber,
      insCompanyId,
      insNumber,
      File? insImage,
      File? patientProfileImg) async {
    SuccessModel successModel;
    String patientUpdateProfile = "updateprofile";
    log("PatientUpdateProfile API :==> $baseUrl$patientUpdateProfile");
    log("insuranceImg Filename :==> ${insImage!.path.split('/').last}");
    log("insuranceImg Extension :==> ${insImage.path.split('/').last.split(".").last}");
    log("patientProfileImg Filename :==> ${patientProfileImg!.path.split('/').last}");
    log("patientProfileImg Extension :==> ${patientProfileImg.path.split('/').last.split(".").last}");
    Response response = await dio.post(
      '$baseUrl$patientUpdateProfile',
      data: FormData.fromMap({
        'user_id': userId,
        'email': email ?? "",
        'first_name': firstName ?? "",
        'last_name': lastName ?? "",
        'mobile_number': mobileNumber ?? "",
        'insurance_company_id': insCompanyId ?? "",
        'insurance_no': insNumber ?? "",
        "insurance_card_pic": insImage.path.isNotEmpty
            ? (await MultipartFile.fromFile(
                insImage.path,
                filename: insImage.path.split('/').last,
              ))
            : "",
        "profile_img": patientProfileImg.path.isNotEmpty
            ? (await MultipartFile.fromFile(
                patientProfileImg.path,
                filename: patientProfileImg.path.split('/').last,
              ))
            : "",
      }),
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    log("updatePatientProfile statuscode :===> ${response.statusCode}");
    log("updatePatientProfile Message :===> ${response.statusMessage}");
    log("updatePatientProfile data :===> ${response.data}");
    successModel = SuccessModel.fromJson(response.data);
    return successModel;
  }

  // updateprofile API
  Future<SuccessModel> updateBMIDetails(
      userId, allergiesToMedicine, cWeight, cHeight, bMI) async {
    SuccessModel successModel;
    String patientUpdateProfile = "updateprofile";
    log("PatientUpdateProfile API :==> $baseUrl$patientUpdateProfile");
    Response response = await dio.post(
      '$baseUrl$patientUpdateProfile',
      data: {
        'user_id': userId,
        'allergies_to_medicine': allergiesToMedicine ?? "",
        'current_height': cWeight ?? "",
        'current_weight': cHeight ?? "",
        'BMI': bMI ?? "",
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    log("updatePatientProfile statuscode :===> ${response.statusCode}");
    log("updatePatientProfile Message :===> ${response.statusMessage}");
    log("updatePatientProfile data :===> ${response.data}");
    successModel = SuccessModel.fromJson(response.data);
    return successModel;
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
    notificationModel = NotificationModel.fromJson(response.data);
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
    successModel = SuccessModel.fromJson(response.data);
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
    specialityModel = SpecialityModel.fromJson(response.data);
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
    doctorModel = DoctorModel.fromJson(response.data);
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
    doctorModel = DoctorModel.fromJson(response.data);
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
    doctorModel = DoctorModel.fromJson(response.data);
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
    appointmentModel = AppointmentModel.fromJson(response.data);
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
    appointmentModel = AppointmentModel.fromJson(response.data);
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
    appointmentModel = AppointmentModel.fromJson(response.data);
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
    appointmentModel = AppointmentModel.fromJson(response.data);
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
    appointmentModel = AppointmentModel.fromJson(response.data);
    return appointmentModel;
  }

  // get_prescription_detail API
  Future<PrescriptionDetailModel> prescriptionHistory() async {
    log("patientID :==> ${Constant.userID}");

    PrescriptionDetailModel prescriptionDetailModel;
    String prescriptionHistory = "get_prescription_detail";
    log("prescriptionHistory API :==> $baseUrl$prescriptionHistory");
    Response response = await dio.post(
      '$baseUrl$prescriptionHistory',
      data: {
        'patient_id': Constant.userID,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    log("prescriptionHistory statuscode :===> ${response.statusCode}");
    log("prescriptionHistory Message :===> ${response.statusMessage}");
    log("prescriptionHistory data :===> ${response.data}");
    prescriptionDetailModel = PrescriptionDetailModel.fromJson(response.data);
    return prescriptionDetailModel;
  }

  // get_test_patient_appoinment API
  Future<AppointmentModel> patientTestAppointment() async {
    log("patientID :==> ${Constant.userID}");

    AppointmentModel appointmentModel;
    String patientTestAppointment = "get_test_patient_appoinment";
    log("patientTestAppointment API :==> $baseUrl$patientTestAppointment");
    Response response = await dio.post(
      '$baseUrl$patientTestAppointment',
      data: {
        'patient_id': Constant.userID,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    log("patientTestAppointment statuscode :===> ${response.statusCode}");
    log("patientTestAppointment Message :===> ${response.statusMessage}");
    log("patientTestAppointment data :===> ${response.data}");
    appointmentModel = AppointmentModel.fromJson(response.data);
    return appointmentModel;
  }

  // getTimeSlotByDoctorId API
  Future<TimeSlotModel> timeSlotByDoctorId(doctorId, date) async {
    log("doctorId :==> $doctorId");
    log("date :==> $date");

    TimeSlotModel timeSlotModel;
    String timeSlotByDoctor = "getTimeSlotByDoctorId";
    log("timeSlotByDoctorId API :==> $baseUrl$timeSlotByDoctor");
    Response response = await dio.post(
      '$baseUrl$timeSlotByDoctor',
      data: {
        'doctor_id': doctorId,
        'date': date,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    log("timeSlotByDoctorId statuscode :===> ${response.statusCode}");
    log("timeSlotByDoctorId Message :===> ${response.statusMessage}");
    log("timeSlotByDoctorId data :===> ${response.data}");
    timeSlotModel = TimeSlotModel.fromJson(response.data);
    return timeSlotModel;
  }

  // make_appoinment API
  Future<SuccessModel> makeAppoinment(doctorId, date, startTime, slotsId,
      endTime, symptoms, medicinesTaken, description) async {
    log("doctorId :==> $doctorId");
    log("date :==> $date");
    log("startTime :==> $startTime");
    log("slotsId :==> $slotsId");
    log("endTime :==> $endTime");
    log("symptoms :==> $symptoms");
    log("medicinesTaken :==> $medicinesTaken");
    log("description :==> $description");

    SuccessModel successModel;
    String makeAppoinment = "make_appoinment";
    log("makeAppoinment API :==> $baseUrl$makeAppoinment");
    Response response = await dio.post(
      '$baseUrl$makeAppoinment',
      data: {
        'doctor_id': doctorId,
        'patient_id': Constant.userID,
        'date': date,
        'startTime': startTime,
        'appointment_slots_id': slotsId,
        'endTime': endTime,
        'symptoms': symptoms,
        'medicines_taken': medicinesTaken,
        'description': description,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    log("timeSlotByDoctorId statuscode :===> ${response.statusCode}");
    log("timeSlotByDoctorId Message :===> ${response.statusMessage}");
    log("timeSlotByDoctorId data :===> ${response.data}");
    successModel = SuccessModel.fromJson(response.data);
    return successModel;
  }

  // getTimeSlotByDoctorId API
  Future<TestTimeSlotModel> testTimeSlot(date) async {
    log("date :==> $date");

    TestTimeSlotModel testTimeSlotModel;
    String testTimeSlot = "getTestTimeSlot";
    log("TestTimeSlot API :==> $baseUrl$testTimeSlot");
    Response response = await dio.post(
      '$baseUrl$testTimeSlot',
      data: {
        'date': date,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    log("testTimeSlot statuscode :===> ${response.statusCode}");
    log("testTimeSlot Message :===> ${response.statusMessage}");
    log("testTimeSlot data :===> ${response.data}");
    testTimeSlotModel = TestTimeSlotModel.fromJson(response.data);
    return testTimeSlotModel;
  }

  // make_appoinment API
  Future<SuccessModel> makeTestAppoinment(
      date, startTime, slotsId, endTime, description) async {
    log("date :==> $date");
    log("startTime :==> $startTime");
    log("slotsId :==> $slotsId");
    log("endTime :==> $endTime");
    log("description :==> $description");

    SuccessModel successModel;
    String makeTestAppoinment = "make_test_appoinment";
    log("makeTestAppoinment API :==> $baseUrl$makeTestAppoinment");
    Response response = await dio.post(
      '$baseUrl$makeTestAppoinment',
      data: {
        'patient_id': Constant.userID,
        'date': date,
        'startTime': startTime,
        'test_appointment_slots_id': slotsId,
        'endTime': endTime,
        'description': description,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    log("makeTestAppoinment statuscode :===> ${response.statusCode}");
    log("makeTestAppoinment Message :===> ${response.statusMessage}");
    log("makeTestAppoinment data :===> ${response.data}");
    successModel = SuccessModel.fromJson(response.data);
    return successModel;
  }
}
