// To parse this JSON data, do
// final loginRegisterModel = loginRegisterModelFromJson(jsonString);

import 'dart:convert';

LoginRegisterModel loginRegisterModelFromJson(String str) =>
    LoginRegisterModel.fromJson(json.decode(str));

String loginRegisterModelToJson(LoginRegisterModel data) =>
    json.encode(data.toJson());

class LoginRegisterModel {
  LoginRegisterModel({
    this.status,
    this.message,
    this.result,
  });

  int? status;
  String? message;
  List<Result>? result;

  factory LoginRegisterModel.fromJson(Map<String, dynamic> json) =>
      LoginRegisterModel(
        status: json["status"],
        message: json["message"],
        result: json["result"] != null
            ? List<Result>.from(json["result"].map((x) => Result.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
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
    this.password,
    this.type,
    this.mobileNumber,
    this.referenceCode,
    this.totalPoints,
    this.deviceToken,
    this.status,
    this.createdAt,
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
  String? password;
  String? type;
  String? mobileNumber;
  String? referenceCode;
  String? totalPoints;
  String? deviceToken;
  String? status;
  DateTime? createdAt;

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
        password: json["password"],
        type: json["type"],
        mobileNumber: json["mobile_number"],
        referenceCode: json["reference_code"],
        totalPoints: json["total_points"],
        deviceToken: json["device_token"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
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
        "password": password,
        "type": type,
        "mobile_number": mobileNumber,
        "reference_code": referenceCode,
        "total_points": totalPoints,
        "device_token": deviceToken,
        "status": status,
        "created_at": createdAt.toString(),
      };
}
