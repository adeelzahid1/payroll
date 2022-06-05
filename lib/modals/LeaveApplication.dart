import 'dart:convert';



LeaveApplication leaveApplicationFromJson(String str) => LeaveApplication.fromJson(json.decode(str));
String leaveApplicationToJson(LeaveApplication data) => json.encode(data.toJson());

class LeaveApplication{
  int? id;
  String? employeeId;
  String? employeeName;
  int? leaveTypeId;
  String? startDate;
  String? endDate;
  String? applicantName;
  String? reason;
  String? creationDate;
  String? modificationDate;

  LeaveApplication({
    this.id,
    this.employeeId,
    this.employeeName,
    this.leaveTypeId,
    this.startDate,
    this.endDate,
    this.applicantName,
    this.reason,
    this.creationDate,
    this.modificationDate});

  factory LeaveApplication.fromJson(Map<String, dynamic> json) => LeaveApplication(
    id: json["id"],
    employeeId: json["employeeId"],
    employeeName: json["employeeName"],
    leaveTypeId: json["leaveTypeId"],
    startDate: json["startDate"],
    endDate: json["endDate"],
    // startDate: DateTime.parse(json["startDate"]),
    // endDate: DateTime.parse(json["endDate"]),
    applicantName: json["applicantName"] == null ? json[null] : json["applicantName"],  // "null"
    reason: json["reason"],
    creationDate: json["creationDate"],
    modificationDate: json["modificationDate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "employeeId": employeeId,
    "employeeName": employeeName,
    "leaveTypeId": leaveTypeId,
    "startDate": startDate,
    "endDate": endDate,
    // "startDate": startDate!.toIso8601String(),
    // "endDate": endDate!.toIso8601String(),
    "applicantName": applicantName == null ? null : applicantName,   // "null"
    "reason": reason,
    "creationDate": creationDate,
    "modificationDate": modificationDate,
  };

}