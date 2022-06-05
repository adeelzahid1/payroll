import 'dart:convert';

LeaveStatus leaveStatusFromJson(String str) => LeaveStatus.fromJson(json.decode(str));
String leaveStatusToJson(LeaveStatus data) => json.encode(data.toJson());

class LeaveStatus {
  String? name, leaves, availed, balance;

  LeaveStatus({this.name, this.leaves, this.availed, this.balance});

  factory LeaveStatus.fromJson(Map<String, dynamic> json) => LeaveStatus(
    name: json["name"],
    leaves: json["leaves"],
    availed: json["availed"],
    balance: json["balance"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "leaves": leaves,
    "availed": availed,
    "balance": balance,
  };
}

List<LeaveStatus> demoLeaveStatus = [
  LeaveStatus(
    name: "Annual",
    leaves: "10",
    availed: "5",
    balance: "5"
  ),
  LeaveStatus(
      name: "medical",
      leaves: "10",
      availed: "3",
      balance: "7"
  ),
  LeaveStatus(
      name: "Urgent",
      leaves: "5",
      availed: "1",
      balance: "4"
  ),
  LeaveStatus(
      name: "Casual ",
      leaves: "8",
      availed: "5",
      balance: "3"
  ),
  LeaveStatus(
      name: "TOTAL ",
      leaves: "33",
      availed: "14",
      balance: "19"
  ),
];

//import 'package:flutter/material.dart';
// const primaryColor = Color(0xFF2697FF);
// const secondaryColor = Color(0xFF2A2D3E);
// const bgColor = Color(0xFF212332);
// const defaultPadding = 16.0;

