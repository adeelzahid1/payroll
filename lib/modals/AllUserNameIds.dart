import 'dart:convert';

AllUserNameId allUserNameIdFromJson(String str) => AllUserNameId.fromJson(json.decode(str));
String allUserNameIdToJson(AllUserNameId data) => json.encode(data.toJson());

class AllUserNameId {
  AllUserNameId({
    this.employeeId,
    this.employeeName,
  });

  String? employeeId;
  String? employeeName;

  factory AllUserNameId.fromJson(Map<String, dynamic> json) => AllUserNameId(
    employeeId: json["id"],
    employeeName: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": employeeId,
    "name": employeeName,
  };
}
