import 'dart:convert';

LeaveType addLeaveTypeFromJson(String str) => LeaveType.fromJson(json.decode(str));
String addLeaveTypeToJson(LeaveType data) => json.encode(data.toJson());

class LeaveType {
  LeaveType({
    this.id,
    this.name,
    this.numberOfLeaves,
    this.creationDate,
    this.modificationDate,
  });

  int? id;
  String? name;
  int? numberOfLeaves;
  String? creationDate;
  String? modificationDate;

  factory LeaveType.fromJson(Map<String, dynamic> json) => LeaveType(
    id: json["id"],
    name: json["name"],
    numberOfLeaves: json["numberOfLeaves"],
    creationDate: json["creationDate"],
    modificationDate: json["modificationDate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "numberOfLeaves": numberOfLeaves,
    "creationDate": creationDate,
    "modificationDate": modificationDate,
  };
}