// To parse this JSON data, do
// final specialityModel = specialityModelFromJson(jsonString);

import 'dart:convert';

SpecialityModel specialityModelFromJson(String str) =>
    SpecialityModel.fromJson(json.decode(str));

String specialityModelToJson(SpecialityModel data) =>
    json.encode(data.toJson());

class SpecialityModel {
  SpecialityModel({
    this.status,
    this.message,
    this.result,
  });

  int? status;
  String? message;
  List<Result>? result;

  factory SpecialityModel.fromJson(Map<String, dynamic> json) =>
      SpecialityModel(
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
    this.name,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.status,
  });

  String? id;
  String? name;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? status;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "created_at": createdAt.toString(),
        "updated_at": updatedAt.toString(),
        "status": status,
      };
}
