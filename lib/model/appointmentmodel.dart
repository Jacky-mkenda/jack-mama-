// To parse this JSON data, do
// final appointmentModel = appointmentModelFromJson(jsonString);

import 'dart:convert';

AppointmentModel appointmentModelFromJson(String str) =>
    AppointmentModel.fromJson(json.decode(str));

String appointmentModelToJson(AppointmentModel data) =>
    json.encode(data.toJson());

class AppointmentModel {
  AppointmentModel({
    this.status,
    this.message,
    this.result,
  });

  int? status;
  String? message;
  List<Result>? result;

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      AppointmentModel(
        status: json["status"],
        message: json["message"],
        result: json["result"] != null
            ? List<Result>.from(json["result"].map((x) => Result.fromJson(x)))
            : <Result>[],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": result != null
            ? List<dynamic>.from(result!.map((x) => x.toJson()))
            : <Result>[],
      };
}

class Result {
  Result({
    this.id,
    this.doctorId,
    this.patientId,
    this.date,
    this.appointmentSlotsId,
    this.startTime,
    this.endTime,
    this.description,
    this.symptoms,
    this.doctorSymptoms,
    this.doctorDiagnosis,
    this.medicinesTaken,
    this.insuranceDetails,
    this.status,
    this.mobileNumber,
    this.createdAt,
    this.specialitiesName,
    this.specialitiesImage,
    this.doctorName,
    this.doctorImage,
    this.doctorEmail,
    this.doctorMobileNumber,
    this.patientsName,
    this.patientsEmail,
    this.patientsProfileImg,
    this.patientsMobileNumber,
    this.insuranceCompanyId,
    this.insuranceNo,
    this.insuranceCardPic,
    this.allergiesToMedicine,
    this.patientsQrcodeImg,
  });

  String? id;
  String? doctorId;
  String? patientId;
  DateTime? date;
  String? appointmentSlotsId;
  String? startTime;
  String? endTime;
  String? description;
  String? symptoms;
  String? doctorSymptoms;
  String? doctorDiagnosis;
  String? medicinesTaken;
  String? insuranceDetails;
  String? status;
  String? mobileNumber;
  DateTime? createdAt;
  String? specialitiesName;
  String? specialitiesImage;
  String? doctorName;
  String? doctorImage;
  String? doctorEmail;
  String? doctorMobileNumber;
  String? patientsName;
  String? patientsEmail;
  String? patientsProfileImg;
  String? patientsMobileNumber;
  String? insuranceCompanyId;
  String? insuranceNo;
  String? insuranceCardPic;
  String? allergiesToMedicine;
  String? patientsQrcodeImg;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        doctorId: json["doctor_id"],
        patientId: json["patient_id"],
        date: DateTime.parse(json["date"]),
        appointmentSlotsId: json["appointment_slots_id"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        description: json["description"],
        symptoms: json["symptoms"],
        doctorSymptoms: json["doctor_symptoms"],
        doctorDiagnosis: json["doctor_diagnosis"],
        medicinesTaken: json["medicines_taken"],
        insuranceDetails: json["insurance_details"],
        status: json["status"],
        mobileNumber: json["mobile_number"],
        createdAt: DateTime.parse(json["created_at"]),
        specialitiesName: json["specialities_name"],
        specialitiesImage: json["specialities_image"],
        doctorName: json["doctor_name"],
        doctorImage: json["doctor_image"],
        doctorEmail: json["doctor_email"],
        doctorMobileNumber: json["doctor_mobile_number"],
        patientsName: json["patients_name"],
        patientsEmail: json["patients_email"],
        patientsProfileImg: json["patients_profile_img"],
        patientsMobileNumber: json["patients_mobile_number"],
        insuranceCompanyId: json["insurance_company_id"],
        insuranceNo: json["insurance_no"],
        insuranceCardPic: json["insurance_card_pic"],
        allergiesToMedicine: json["allergies_to_medicine"],
        patientsQrcodeImg: json["patients_qrcode_img"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "doctor_id": doctorId,
        "patient_id": patientId,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "appointment_slots_id": appointmentSlotsId,
        "startTime": startTime,
        "endTime": endTime,
        "description": description,
        "symptoms": symptoms,
        "doctor_symptoms": doctorSymptoms,
        "doctor_diagnosis": doctorDiagnosis,
        "medicines_taken": medicinesTaken,
        "insurance_details": insuranceDetails,
        "status": status,
        "mobile_number": mobileNumber,
        "created_at": createdAt.toString(),
        "specialities_name": specialitiesName,
        "specialities_image": specialitiesImage,
        "doctor_name": doctorName,
        "doctor_image": doctorImage,
        "doctor_email": doctorEmail,
        "doctor_mobile_number": doctorMobileNumber,
        "patients_name": patientsName,
        "patients_email": patientsEmail,
        "patients_profile_img": patientsProfileImg,
        "patients_mobile_number": patientsMobileNumber,
        "insurance_company_id": insuranceCompanyId,
        "insurance_no": insuranceNo,
        "insurance_card_pic": insuranceCardPic,
        "allergies_to_medicine": allergiesToMedicine,
        "patients_qrcode_img": patientsQrcodeImg,
      };
}
