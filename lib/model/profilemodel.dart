import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    this.status,
    this.message,
    this.result,
  });

  int? status;
  String? message;
  Result? result;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        status: json["status"],
        message: json["message"],
        result: Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": result!.toJson(),
      };
}

class Result {
  Result({
    this.id,
    this.patientId,
    this.firebaseId,
    this.fullname,
    this.firstName,
    this.lastName,
    this.userName,
    this.email,
    this.profileImg,
    this.instagramUrl,
    this.facebookUrl,
    this.twitterUrl,
    this.biodata,
    this.password,
    this.type,
    this.mobileNumber,
    this.location,
    this.insuranceCompanyId,
    this.insuranceNo,
    this.insuranceCardPic,
    this.allergiesToMedicine,
    this.currentHeight,
    this.currentWeight,
    this.bmi,
    this.referenceCode,
    this.totalPoints,
    this.deviceToken,
    this.date,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.insuranceCompanyName,
    this.patientsQrcodeImg,
  });

  String? id;
  String? patientId;
  String? firebaseId;
  String? fullname;
  String? firstName;
  String? lastName;
  String? userName;
  String? email;
  String? profileImg;
  String? instagramUrl;
  String? facebookUrl;
  String? twitterUrl;
  String? biodata;
  String? password;
  String? type;
  String? mobileNumber;
  String? location;
  String? insuranceCompanyId;
  String? insuranceNo;
  String? insuranceCardPic;
  String? allergiesToMedicine;
  String? currentHeight;
  String? currentWeight;
  String? bmi;
  String? referenceCode;
  String? totalPoints;
  String? deviceToken;
  String? date;
  String? createdAt;
  String? updatedAt;
  String? status;
  String? insuranceCompanyName;
  String? patientsQrcodeImg;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        patientId: json["patient_id"],
        firebaseId: json["firebase_id"],
        fullname: json["fullname"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        userName: json["user_name"],
        email: json["email"],
        profileImg: json["profile_img"],
        instagramUrl: json["instagram_url"],
        facebookUrl: json["facebook_url"],
        twitterUrl: json["twitter_url"],
        biodata: json["biodata"],
        password: json["password"],
        type: json["type"],
        mobileNumber: json["mobile_number"],
        location: json["location"],
        insuranceCompanyId: json["insurance_company_id"],
        insuranceNo: json["insurance_no"],
        insuranceCardPic: json["insurance_card_pic"],
        allergiesToMedicine: json["allergies_to_medicine"],
        currentHeight: json["current_height"],
        currentWeight: json["current_weight"],
        bmi: json["BMI"],
        referenceCode: json["reference_code"],
        totalPoints: json["total_points"],
        deviceToken: json["device_token"],
        date: json["date"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        status: json["status"],
        insuranceCompanyName: json["insurance_company_name"],
        patientsQrcodeImg: json["patients_qrcode_img"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "patient_id": patientId,
        "firebase_id": firebaseId,
        "fullname": fullname,
        "first_name": firstName,
        "last_name": lastName,
        "user_name": userName,
        "email": email,
        "profile_img": profileImg,
        "instagram_url": instagramUrl,
        "facebook_url": facebookUrl,
        "twitter_url": twitterUrl,
        "biodata": biodata,
        "password": password,
        "type": type,
        "mobile_number": mobileNumber,
        "location": location,
        "insurance_company_id": insuranceCompanyId,
        "insurance_no": insuranceNo,
        "insurance_card_pic": insuranceCardPic,
        "allergies_to_medicine": allergiesToMedicine,
        "current_height": currentHeight,
        "current_weight": currentWeight,
        "BMI": bmi,
        "reference_code": referenceCode,
        "total_points": totalPoints,
        "device_token": deviceToken,
        "date": date,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "status": status,
        "insurance_company_name": insuranceCompanyName,
        "patients_qrcode_img": patientsQrcodeImg,
      };
}
