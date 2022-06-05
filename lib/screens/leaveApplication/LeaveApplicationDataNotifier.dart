import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:network/HttpService.dart';
import 'package:payroll/modals/LeaveApplication.dart';

import 'package:payroll/modals/enum/CallState.dart';
import 'package:payroll/repo/PayrollRepo.dart';


class LeaveApplicationDataNotifier extends ChangeNotifier {
  PayRollRepo get repository => GetIt.I<PayRollRepo>();
  CallState callState = CallState.loading;

  LeaveApplicationDataNotifier() {
    fetchData();
  }

  List<LeaveApplication> get filterData => _filterData;

  set filterData(List<LeaveApplication> leaveType) {
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
        if (leaveDetail.employeeName!.toLowerCase().contains(text.toLowerCase())) {
          _filterData.add(leaveDetail);
        }
      });
    }
    notifyListeners();
  }


  void addUpdateLeaveApplication(LeaveApplication leaveType, bool isUpdate) {
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

  void deleteLeaveApplication(LeaveApplication leaveType) {
    _filterData.remove(leaveType);
    _leaveTypeModel.remove(leaveType);
    notifyListeners();
  }


  Future<APIRespons>  acceptItemName(LeaveApplication leaveType) async {
    return await repository.deleteLeaveApplication(leaveType).then((value) {
      if(!value.error) {
        _filterData.remove(leaveType);
        _leaveTypeModel.remove(leaveType);
        notifyListeners();
      }
      return value;
    });
  }

  // Future<APIRespons>  rejectItemName(LeaveApplication leaveType) async {
 Future<APIRespons> rejectItemName(int index) async {
    LeaveApplication leaveType = filterData[index];
     leaveType.reason = reasonText.text;
    print("${leaveType.employeeName} ${leaveType.employeeId} ${leaveType.reason}");

    return await repository.rejectLeaveApplication(leaveType).then((value) {
      if(!value.error) {
        _filterData.remove(leaveType);
        _leaveTypeModel.remove(leaveType);
        notifyListeners();
      }
      return value;
    });
  }




  //////////////// internal ///////////
  var _filterData = <LeaveApplication>[];
  var _leaveTypeModel = <LeaveApplication>[];
  int _sortColumnIndex =0;
  bool _sortAscending = true;
  int _rowsPerPage =  PaginatedDataTable.defaultRowsPerPage;




  Future<void> fetchData() async {
    repository.getAllLeaveApplications().then((value) {
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


  // =====================
  // =====================
  // =====================
  TextEditingController reasonText = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _isVisible = false;

  bool get autoValidate => _autoValidate;
  bool get isVisible => _isVisible;

  void set autoValidate(bool value) {
    _autoValidate = value;
    notifyListeners();
  }
  void set isVisible(bool value) {
    _isVisible = value;
    notifyListeners();
  }

  //validate reason
  // validate: (String? value){
  //   if(value!=null){
  //     if(value.length > 10 && value.length < 300){return null;}
  //     else{
  //       return "Reason must have 10 to 300 character";
  //     }
  //   }
  //   else{
  //     return "Reason is Required";
  //   }
  // },
  String? validateReason(String? value) {
    if (value == null || value == "") {
      return "please Enter Reason";
    } else {
      if (value.length < 10) {
        return 'Reason has at least 10 characters long';
      }
      else if (value.length >= 300) {
        return 'Character Max Length is 300';
      }
      else {
        return null;
      }
    }
  }
  void onSaveReason(String? value){
    if(value!=null){
      reasonText.text = value;
    }
  }

// void checkdata(int index){
//   print("Inside of notifier : ${filterData[index].employeeName}");
//   //print("Print Reason Text : ${reasonText.text}");
//   filterData[index].reason = reasonText.text;
//   print("Inside of notifier Reason: ${filterData[index].reason}");
//
// }
// =====================
// =====================
// =====================

}
