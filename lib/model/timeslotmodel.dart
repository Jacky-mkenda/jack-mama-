// To parse this JSON data, do
// final timeSlotModel = timeSlotModelFromJson(jsonString);

import 'dart:convert';

TimeSlotModel timeSlotModelFromJson(String str) =>
    TimeSlotModel.fromJson(json.decode(str));

String timeSlotModelToJson(TimeSlotModel data) => json.encode(data.toJson());

class TimeSlotModel {
  TimeSlotModel({
    this.status,
    this.message,
    this.result,
  });

  int? status;
  String? message;
  List<Result>? result;

  factory TimeSlotModel.fromJson(Map<String, dynamic> json) => TimeSlotModel(
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
    this.weekDay,
    this.startTime,
    this.endTime,
    this.timeDuration,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.slot,
  });

  String? id;
  String? doctorId;
  String? weekDay;
  String? startTime;
  String? endTime;
  String? timeDuration;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Slot>? slot;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        doctorId: json["doctor_id"],
        weekDay: json["week_day"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        timeDuration: json["time_duration"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        slot: json["slot"] == null
            ? null
            : List<Slot>.from(json["slot"].map((x) => Slot.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "doctor_id": doctorId,
        "week_day": weekDay,
        "start_time": startTime,
        "end_time": endTime,
        "time_duration": timeDuration,
        "status": status,
        "created_at": createdAt.toString(),
        "updated_at": updatedAt.toString(),
        "slot": slot == null
            ? null
            : List<dynamic>.from(slot!.map((x) => x.toJson())),
      };
}

class Slot {
  Slot({
    this.id,
    this.doctorId,
    this.weekDay,
    this.startTime,
    this.endTime,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.appointmentSlotsId,
    this.slotStatus,
  });

  String? id;
  String? doctorId;
  String? weekDay;
  String? startTime;
  String? endTime;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? appointmentSlotsId;
  int? slotStatus;

  factory Slot.fromJson(Map<String, dynamic> json) => Slot(
        id: json["id"],
        doctorId: json["doctor_id"],
        weekDay: json["week_day"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        appointmentSlotsId: json["appointment_slots_id"],
        slotStatus: json["slot_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "doctor_id": doctorId,
        "week_day": weekDay,
        "start_time": startTime,
        "end_time": endTime,
        "status": status,
        "created_at": createdAt.toString(),
        "updated_at": updatedAt.toString(),
        "appointment_slots_id": appointmentSlotsId,
        "slot_status": slotStatus,
      };
}
