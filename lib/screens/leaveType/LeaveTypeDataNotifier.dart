import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:network/HttpService.dart';
import 'package:payroll/modals/AddLeaveType.dart';
import 'package:payroll/modals/enum/CallState.dart';
import 'package:payroll/repo/PayrollRepo.dart';


class LeaveTypeDataNotifier extends ChangeNotifier {
  PayRollRepo get repository => GetIt.I<PayRollRepo>();
  CallState callState = CallState.loading;

  LeaveTypeDataNotifier() {
    fetchData();
  }

  List<LeaveType> get filterData => _filterData;

  set filterData(List<LeaveType> leaveType) {
    _filterData = leaveType;
    notifyListeners();
  }

  int get sortColumnIndex => _sortColumnIndex;

  set sortColumnIndex(int sortColumnIndex) {
    _sortColumnIndex = sortColumnIndex;
    notifyListeners();
  }

  // SORT ASCENDING....

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
      _filterData.addAll(_leaveTypeModel);
    } else {
      _leaveTypeModel.forEach((leaveDetail) {
        if (leaveDetail.name!.toLowerCase().contains(text.toLowerCase())) {
          _filterData.add(leaveDetail);
        }
      });
    }
    notifyListeners();
  }


  void addUpdateLeaveType(LeaveType leaveType, bool isUpdate) {
    if(isUpdate){
      int index = _filterData.indexWhere((element) => element.id == leaveType.id);
      _filterData[index] = leaveType;

      int indexMain = _leaveTypeModel.indexWhere((element) => element.id == leaveType.id);
      _leaveTypeModel[indexMain] = leaveType;
    }
    else{
      //_leaveTypeModel.add(leaveType);  //todo :: commet it
      _filterData.add(leaveType);
    }
    notifyListeners();
  }

  void deleteLeaveType(LeaveType leaveType) {
    _filterData.remove(leaveType);
    _leaveTypeModel.remove(leaveType);
    notifyListeners();
  }


  Future<APIRespons>  deleteItemName(LeaveType leaveType) async {
    return await repository.deleteLeaveType(leaveType.id).then((value) {
      if(!value.error) {
        _filterData.remove(leaveType);
        _leaveTypeModel.remove(leaveType);
        notifyListeners();
      }
      return value;
    });
  }




  //////////////// internal ///////////
  var _filterData = <LeaveType>[];
  var _leaveTypeModel = <LeaveType>[];
  int _sortColumnIndex =0;
  bool _sortAscending = true;
  int _rowsPerPage =  PaginatedDataTable.defaultRowsPerPage;




  Future<void> fetchData() async {
    repository.getAllLeaveTypes().then((value) {
      if(!value.error && value.data !=null){
        _leaveTypeModel.clear();
        _filterData.clear();
        _leaveTypeModel = value.data;
        _filterData = value.data;
        callState= CallState.data;
        notifyListeners();
      }
      else{
        callState= CallState.failed;
      }
    });
  }






  // Future<void> fetchData() async {
  //   _leaveTypeModel = [
  //     new LeaveType(
  //       id: 1,
  //       name: "Abid",
  //     ),
  //     new LeaveType(
  //       id: 2,
  //       name: "Umar",
  //     ),
  //   ];
  //   _filterData.clear();
  //   _filterData.addAll(_leaveTypeModel);
  // }



}
