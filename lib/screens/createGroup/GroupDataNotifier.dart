import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:payroll/modals/Group.dart';
import 'package:payroll/modals/GroupType.dart';

class GroupDataNotifier extends ChangeNotifier {
  GroupDataNotifier() {
    fetchData();
  }

  List<Group> get filterData => _filterData;

  set filterData(List<Group> Groups) {
    _filterData = Groups;
    notifyListeners();
  }

  int get sortColumnIndex => _sortColumnIndex;

  set sortColumnIndex(int sortColumnIndex) {
    _sortColumnIndex = sortColumnIndex;
    notifyListeners();
  }

  bool get sortAscending => _sortAscending;

  set sortAscending(bool sortAscending) {
    _sortAscending = sortAscending;
    notifyListeners();
  }

  int get rowsPerPage => _rowsPerPage;
  set rowsPerPage(int rowsPerPage) {
    _rowsPerPage = rowsPerPage;
    notifyListeners();
  }

  onSearchTextChanged(String text) async {
    _filterData.clear();
    if (text.isEmpty) {
      _filterData.addAll(_GroupModel);
    } else {
      _GroupModel.forEach((GroupDetail) {
        if (GroupDetail.name!.toLowerCase().contains(text.toLowerCase())) {
          _filterData.add(GroupDetail);
        }
      });
    }
    notifyListeners();
  }

  //////////////// internal ///////////
  var _filterData = <Group>[];
  var _GroupModel = <Group>[];
  int _sortColumnIndex = 0;   //todo: int _sortcolIndex set to 0
  // late int _sortColumnIndex; //late
  bool _sortAscending = true;
  int _rowsPerPage =  PaginatedDataTable.defaultRowsPerPage;

  Future<void> fetchData() async {
    _GroupModel = [
      new Group(
          id: 1,
          name: "Admin",
          comment: "this is comment",
          groupType: new GroupType(id: 1, name: "Admin")),
      new Group(
          id: 2,
          name: "Shop keeper",
          comment: "this is comment",
          groupType: new GroupType(id: 2, name: "Shop keeper")),
      new Group(
          id: 3,
          name: "Sale man",
          comment: "this is comment",
          groupType: new GroupType(id: 3, name: "Sale man")),
      new Group(
          id: 4,
          name: "Cashire",
          comment: "this is comment",
          groupType: new GroupType(id: 4, name: "Cashire")),
    ];
    _filterData.clear();
    _filterData.addAll(_GroupModel);
    notifyListeners();
  }

  void addUpdteGroup(Group group, bool isUpdate) {
    if(isUpdate){
      int index = _filterData.indexWhere((element) => element.id == group.id);
      _filterData[index] = group;

       int indexMain = _GroupModel.indexWhere((element) => element.id == group.id);
      _GroupModel[indexMain] = group;
    }
    else{
      _GroupModel.add(group);
      _filterData.add(group);
    }
    notifyListeners();
  }

  void deleteGroup(Group model) {
      _filterData.remove(model);
      _GroupModel.remove(model);
      notifyListeners();
  }
}
