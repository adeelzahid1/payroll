import 'package:flutter/material.dart';
import 'package:payroll/widgets/expansionTile/AppExpansionTile.dart';

class GroupCategoryRights {
  String? title;
  int? value;
  bool? isSelected = false;

  final GlobalKey<AppExpansionTileState> expansionTile = new GlobalKey();
  List<GroupCategoryRights> children; // Since this is an expansion list ...children can be another list of entries


  GroupCategoryRights({this.title, this.value, childrenVal = const <GroupCategoryRights>[]})
      : children = childrenVal,
        assert(childrenVal != null);
}
