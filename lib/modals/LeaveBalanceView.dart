import 'dart:convert';
LeaveBalanceView leaveApplicationFromJson(String str) => LeaveBalanceView.fromJson(json.decode(str));
String leaveApplicationToJson(LeaveBalanceView data) => json.encode(data.toJson());

class LeaveBalanceView{
  int? id;
  String? employeeName;
  String? employeeId;
  String? designation;
  String? totalLeaves;
  String? availableLeaves;
  String? leaveBalance;
  String? leaveType;
  String? leaveTypeTotal;
  String? leaveTypeAvailable;
  String? leaveTypeBalance;
  String? creationDate;
  String? modificationDate;

  LeaveBalanceView({
    this.id,
    this.employeeName,
    this.employeeId,
    this.designation,
    this.totalLeaves,
    this.availableLeaves,
    this.leaveBalance,
    this.leaveType,
    this.leaveTypeTotal,
    this.leaveTypeAvailable,
    this.leaveTypeBalance,
    this.creationDate,
    this.modificationDate});

  factory LeaveBalanceView.fromJson(Map<String, dynamic> json) => LeaveBalanceView(
    id: json["id"],
    employeeName: json["employeeName"],
    employeeId: json["employeeId"],
    designation: json["designation"],
    totalLeaves: json["totalLeaves"],
    availableLeaves: json["availableLeaves"],
    leaveBalance: json["leaveBalance"],
    leaveType: json["leaveType"],
    leaveTypeTotal: json["leaveTypeTotal"],
    leaveTypeAvailable: json["leaveTypeAvailable"],
    leaveTypeBalance: json["leaveTypeBalance"],
    creationDate: json["creationDate"],
    modificationDate: json["modificationDate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "employeeName": employeeName,
    "employeeId": employeeId,
    "designation": designation,
    "totalLeaves": totalLeaves,
    "availableLeaves": availableLeaves,
    "leaveBalance": leaveBalance,
    "leaveType": leaveType,
    "leaveTypeTotal": leaveTypeTotal,
    "leaveTypeAvailable": leaveTypeAvailable,
    "leaveTypeBalance": leaveTypeBalance,
    "creationDate": creationDate,
    "modificationDate": modificationDate,
  };


}