// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    this.status,
    this.message,
    this.result,
  });

  int? status;
  String? message;
  List<Result>? result;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
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
    this.title,
    this.fromUserId,
    this.doctorId,
    this.patientId,
    this.appointmentId,
    this.type,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.doctorName,
    this.doctorProfileImg,
  });

  String? id;
  String? title;
  String? fromUserId;
  String? doctorId;
  String? patientId;
  String? appointmentId;
  String? type;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? doctorName;
  String? doctorProfileImg;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        title: json["title"],
        fromUserId: json["from_user_id"],
        doctorId: json["doctor_id"],
        patientId: json["patient_id"],
        appointmentId: json["appointment_id"],
        type: json["type"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        doctorName: json["doctor_name"],
        doctorProfileImg: json["doctor_profile_img"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "from_user_id": fromUserId,
        "doctor_id": doctorId,
        "patient_id": patientId,
        "appointment_id": appointmentId,
        "type": type,
        "status": status,
        "created_at": createdAt.toString(),
        "updated_at": updatedAt.toString(),
        "doctor_name": doctorName,
        "doctor_profile_img": doctorProfileImg,
      };
}
