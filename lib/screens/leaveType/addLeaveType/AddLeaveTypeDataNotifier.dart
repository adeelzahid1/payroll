import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:network/HttpService.dart';
import 'package:payroll/modals/AddLeaveType.dart';
import 'package:payroll/modals/enum/CallState.dart';
import 'package:payroll/repo/PayrollRepo.dart';

class AddLeaveTypeDataNotifier extends ChangeNotifier {

  LeaveType leaveTypeModel = new LeaveType();
  PayRollRepo get repository => GetIt.I<PayRollRepo>();

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



  CallState callState = CallState.data;


  AddLeaveTypeDataNotifier(int? leaveTypeId) {
    if(leaveTypeId!=null) {
      fetchData(leaveTypeId);
    }
  }

  set filterData(LeaveType leave) {
    leaveTypeModel = leave;
    notifyListeners();
  }


  Future<APIRespons>  update() async {
    return await repository.updateLeaveType(leaveTypeModel).then((value) {
      return value;
    });
  }


  Future<APIRespons>  submit() async {
    return await repository.addLeaveType(leaveTypeModel).then((value) {
      return value;
    });
  }


  Future<void> fetchData(int?  leaveTypeId) async {
    callState = CallState.loading;
    repository.getLeaveTypeById(leaveTypeId).then((value) {
      if(!value.error && value.data!=null){
        leaveTypeModel = value.data;
        callState = CallState.data;

      }
      else{
        callState = CallState.failed;
      }
      notifyListeners();

    });
  }




  // String? validateNumberLeaves(String? value) {
  //   if (value != null && value.isNotEmpty) {
  //     if (value.length < 1) {
  //       return 'please enter Leaves';
  //     }
  //     else{
  //       int val = int.tryParse(value)!;
  //       if (val < 1) {
  //         return 'please enter Leaves';
  //       }
  //       else if (val > 10) {
  //         return 'Max Leaves are 10';
  //       }
  //       else {
  //         return null;
  //       }
  //     }
  //
  //   } else {
  //     return null;
  //   }
  // }

  String? validateNumberLeaves(String? value) {
    String pattern = r'(^(?:[1-9]|[12][0-9]|3[00])$)';  //only 1 to 30
    RegExp regExp = RegExp(pattern);
    if (value == null) {
      return null;
    }
    else{
      if (!regExp.hasMatch(value)) {
        return 'Please enter Leave between 1 to 30';
      }
    }
    //String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';  //([1-9]|10)
    //String pattern = r'(^(?:[1-9]|10)$)';  //([1-9]|10) only 1 to 10
  }




  String? validateName(String? value) {
    if (value == null) {
      return null;
    } else {
      if (value.length < 3) {
        return 'please enter valid name';
      }
      else if (value.length > 50) {
        return 'Character Max Length is 50';
      }
      else {
        return null;
      }
    }
  }


}




