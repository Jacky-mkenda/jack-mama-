// To parse this JSON data, do
// final doctorModel = doctorModelFromJson(jsonString);

import 'dart:convert';

DoctorModel doctorModelFromJson(String str) =>
    DoctorModel.fromJson(json.decode(str));

String doctorModelToJson(DoctorModel data) => json.encode(data.toJson());

class DoctorModel {
  DoctorModel({
    this.status,
    this.message,
    this.result,
  });

  int? status;
  String? message;
  List<Result>? result;

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
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
    this.firstName,
    this.lastName,
    this.email,
    this.profileImg,
    this.instagramUrl,
    this.facebookUrl,
    this.twitterUrl,
    this.services,
    this.aboutUs,
    this.workingTime,
    this.healthCare,
    this.address,
    this.latitude,
    this.longitude,
    this.specialtiesId,
    this.type,
    this.mobileNumber,
    this.referenceCode,
    this.totalPoints,
    this.deviceToken,
    this.status,
    this.createdAt,
    this.specialitiesName,
    this.doctorImage,
  });

  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? profileImg;
  String? instagramUrl;
  String? facebookUrl;
  String? twitterUrl;
  String? services;
  String? aboutUs;
  String? workingTime;
  String? healthCare;
  String? address;
  String? latitude;
  String? longitude;
  String? specialtiesId;
  String? type;
  String? mobileNumber;
  String? referenceCode;
  String? totalPoints;
  String? deviceToken;
  String? status;
  DateTime? createdAt;
  String? specialitiesName;
  String? doctorImage;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        profileImg: json["profile_img"],
        instagramUrl: json["instagram_url"],
        facebookUrl: json["facebook_url"],
        twitterUrl: json["twitter_url"],
        services: json["services"],
        aboutUs: json["about_us"],
        workingTime: json["working_time"],
        healthCare: json["health_care"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        specialtiesId: json["specialties_id"],
        type: json["type"],
        mobileNumber: json["mobile_number"],
        referenceCode: json["reference_code"],
        totalPoints: json["total_points"],
        deviceToken: json["device_token"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        specialitiesName: json["specialities_name"],
        doctorImage: json["doctor_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "profile_img": profileImg,
        "instagram_url": instagramUrl,
        "facebook_url": facebookUrl,
        "twitter_url": twitterUrl,
        "services": services,
        "about_us": aboutUs,
        "working_time": workingTime,
        "health_care": healthCare,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "specialties_id": specialtiesId,
        "type": type,
        "mobile_number": mobileNumber,
        "reference_code": referenceCode,
        "total_points": totalPoints,
        "device_token": deviceToken,
        "status": status,
        "created_at": createdAt.toString(),
        "specialities_name": specialitiesName,
        "doctor_image": doctorImage,
      };
}
