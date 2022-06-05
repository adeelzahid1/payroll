import 'dart:convert';
ViewAttendance leaveApplicationFromJson(String str) => ViewAttendance.fromJson(json.decode(str));
String leaveApplicationToJson(ViewAttendance data) => json.encode(data.toJson());

class ViewAttendance{
  int? id;
  String? employeeId;
  String? employeeName;
  String? startDate;
  String? endDate;
  String? creationDate;
  String? modificationDate;

  ViewAttendance({
    this.id,
    this.employeeId,
    this.employeeName,
    this.startDate,
    this.endDate,
    this.creationDate,
    this.modificationDate});

  factory ViewAttendance.fromJson(Map<String, dynamic> json) => ViewAttendance(
    id: json["id"],
    employeeId: json["employeeId"],
    employeeName: json["employeeName"],
    startDate: json["startDate"],
    endDate: json["endDate"],
    creationDate: json["creationDate"],
    modificationDate: json["modificationDate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "employeeId": employeeId,
    "employeeName": employeeName,
    "startDate": startDate,
    "endDate": endDate,
    "creationDate": creationDate,
    "modificationDate": modificationDate,
  };
  

}