import 'dart:convert';
Role roleFromJson(String str) => Role.fromJson(json.decode(str));
String roleToJson(Role data) => json.encode(data.toJson());

class Role{
  String? id;
  String? name;
  String? creationDate;
  String? modificationDate;

  Role({
    this.id,
    this.name,
    this.creationDate,
    this.modificationDate
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"],
    name: json["name"],
    creationDate: json["creationDate"],
    modificationDate: json["modificationDate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "creationDate": creationDate,
    "modificationDate": modificationDate,
  };


}