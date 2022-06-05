// To parse this JSON data, do
//
//     final attendanceInOut = attendanceInOutFromJson(jsonString);

import 'dart:convert';

AttendanceInOut attendanceInOutFromJson(String str) => AttendanceInOut.fromJson(json.decode(str));

String attendanceInOutToJson(AttendanceInOut data) => json.encode(data.toJson());

class AttendanceInOut {
  AttendanceInOut({
    this.id,
    this.employeeId,
    this.employeeName,
    this.inTime,
    this.outTime,
    this.status,
    this.creationDate,
    this.modificationDate,
  });

  int? id;
  String? employeeId;
  String? employeeName;
  String? inTime;
  String? outTime;
  String? status;
  String? creationDate;
  String? modificationDate;

  factory AttendanceInOut.fromJson(Map<String, dynamic> json) => AttendanceInOut(
    id: json["id"],
    employeeId: json["employeeId"],
    // employeeName: json["employeeName"],
    inTime: json["inTime"],
    outTime: json["outTime"],
    status: json["status"],
    creationDate: json["creationDate"],
    modificationDate: json["modificationDate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "employeeId": employeeId,
    "employeeName": employeeName,
    "inTime": inTime,
    "outTime": outTime,
    "status": status,
    "creationDate": creationDate,
    "modificationDate": modificationDate,
  };

}
