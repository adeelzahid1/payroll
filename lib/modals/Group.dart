import 'package:payroll/utils/AppUtiles.dart';

import 'GroupType.dart';

class Group {
  int? id;
  String? name;
  String? comment;
  GroupType? groupType;

  Group({this.id=-1, this.name= "", this.groupType , this.comment = ""});

  void printGroup()
  {
    AppUtiles.printLog("id: ${this.id}  name: ${this.name}   comment: ${this.comment}   groupType: ${this.groupType!.name}");
  }
}