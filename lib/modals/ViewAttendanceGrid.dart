import 'dart:convert';
ViewAttendanceGrid leaveApplicationFromJson(String str) => ViewAttendanceGrid.fromJson(json.decode(str));
String leaveApplicationToJson(ViewAttendanceGrid data) => json.encode(data.toJson());

class ViewAttendanceGrid{
  String? employeeId;
  String? date;
  String? status;
  String? workingHour;
  int? dutyHour;
  String? inTime;
  String? outTime;
  String? totalTime;
  String? overTime;
  String? creationDate;
  String? modificationDate;

  ViewAttendanceGrid({
    this.employeeId,
    this.date,
    this.status,
    this.workingHour,
    this.dutyHour,
    this.inTime,
    this.outTime,
    this.totalTime,
    this.overTime,
    this.creationDate,
    this.modificationDate});

  factory ViewAttendanceGrid.fromJson(Map<String, dynamic> json) => ViewAttendanceGrid(
    employeeId: json["employeeId"],
    date: json["date"],
    status: json["status"],
    workingHour: json["workingHour"],
    dutyHour: json["dutyHour"],
    inTime: json["inTime"],
    outTime: json["outTime"],
    totalTime: json["totalTime"],
    overTime: json["overTime"],
    creationDate: json["creationDate"],
    modificationDate: json["modificationDate"],
  );

  Map<String, dynamic> toJson() => {
    "employeeId": employeeId,
    "date": date,
    "status": status,
    "workingHour": workingHour,
    "dutyHour": dutyHour,
    "inTime": inTime,
    "outTime": outTime,
    "totalTime": totalTime,
    "overTime": overTime,
    "creationDate": creationDate,
    "modificationDate": modificationDate,
  };


}