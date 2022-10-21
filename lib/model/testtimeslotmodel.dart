// To parse this JSON data, do
// final testTimeSlotModel = testTimeSlotModelFromJson(jsonString);

import 'dart:convert';

TestTimeSlotModel testTimeSlotModelFromJson(String str) =>
    TestTimeSlotModel.fromJson(json.decode(str));

String testTimeSlotModelToJson(TestTimeSlotModel data) =>
    json.encode(data.toJson());

class TestTimeSlotModel {
  TestTimeSlotModel({
    this.status,
    this.message,
    this.result,
  });

  int? status;
  String? message;
  List<Result>? result;

  factory TestTimeSlotModel.fromJson(Map<String, dynamic> json) =>
      TestTimeSlotModel(
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
        weekDay: json["week_day"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        timeDuration: json["time_duration"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        slot: json["slot"] == null
            ? <Slot>[]
            : List<Slot>.from(json["slot"].map((x) => Slot.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "week_day": weekDay,
        "start_time": startTime,
        "end_time": endTime,
        "time_duration": timeDuration,
        "status": status,
        "created_at": createdAt.toString(),
        "updated_at": updatedAt.toString(),
        "slot": slot == null
            ? <Slot>[]
            : List<dynamic>.from(slot!.map((x) => x.toJson())),
      };
}

class Slot {
  Slot({
    this.id,
    this.weekDay,
    this.startTime,
    this.endTime,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.testAppointmentSlotsId,
    this.slotStatus,
    this.totalBookingUser,
  });

  String? id;
  String? weekDay;
  String? startTime;
  String? endTime;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? testAppointmentSlotsId;
  int? slotStatus;
  int? totalBookingUser;

  factory Slot.fromJson(Map<String, dynamic> json) => Slot(
        id: json["id"],
        weekDay: json["week_day"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        testAppointmentSlotsId: json["test_appointment_slots_id"],
        slotStatus: json["slot_status"],
        totalBookingUser: json["totle_booking_user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "week_day": weekDay,
        "start_time": startTime,
        "end_time": endTime,
        "status": status,
        "created_at": createdAt.toString(),
        "updated_at": updatedAt.toString(),
        "test_appointment_slots_id": testAppointmentSlotsId,
        "slot_status": slotStatus,
        "totle_booking_user": totalBookingUser,
      };
}
