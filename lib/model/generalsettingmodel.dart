import 'dart:convert';

GeneralSettingModel generalSettingModelFromJson(String str) =>
    GeneralSettingModel.fromJson(json.decode(str));

String generalSettingModelToJson(GeneralSettingModel data) =>
    json.encode(data.toJson());

class GeneralSettingModel {
  GeneralSettingModel({
    this.status,
    this.result,
    this.message,
  });

  int? status;
  List<Result>? result;
  String? message;

  factory GeneralSettingModel.fromJson(Map<String, dynamic> json) =>
      GeneralSettingModel(
        status: json["status"],
        result: json["result"] != null
            ? List<Result>.from(json["result"].map((x) => Result.fromJson(x)))
            : [],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
        "message": message,
      };
}

class Result {
  Result({
    this.id,
    this.key,
    this.value,
  });

  String? id;
  String? key;
  String? value;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "key": key,
        "value": value,
      };
}
