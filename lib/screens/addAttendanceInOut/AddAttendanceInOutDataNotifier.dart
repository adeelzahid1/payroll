import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:network/HttpService.dart';
import 'package:payroll/modals/AttendanceInOut.dart';

import 'package:payroll/modals/enum/CallState.dart';
import 'package:payroll/repo/PayrollRepo.dart';

class AddAttendanceInOutDataNotifier extends ChangeNotifier {

  AttendanceInOut attendanceModel = new AttendanceInOut();
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


  // AddAttendanceInOutDataNotifier(int? leaveTypeId) {
  AddAttendanceInOutDataNotifier(String? leaveTypeId) {
    if(leaveTypeId!=null) {
      // fetchData(leaveTypeId);
      submit();
    }
  }

  set filterData(AttendanceInOut leave) {
    attendanceModel = leave;
    notifyListeners();
  }


  Future<APIRespons>  update() async {
    return await repository.updateAttendanceInOut(attendanceModel).then((value) {
      return value;
    });
  }


  Future<APIRespons>  submit() async {
    return await repository.addAttendanceInOut(attendanceModel).then((value) {
      return value;
    });
  }


  Future<void> fetchData(int?  leaveTypeId) async {
    callState = CallState.loading;
    repository.getAttendanceInOutById(leaveTypeId).then((value) {
      if(!value.error && value.data!=null){
        attendanceModel = value.data;
        callState = CallState.data;

      }
      else{
        callState = CallState.failed;
      }
      notifyListeners();

    });
  }





  String? validateEmployeeName(String? value) {
    if (value != null) {
      if (value.length < 3) {
        return 'please enter valid name';
      }
      else if (value.length > 50) {
        return 'Character Max Length is 50';
      }
    }
    else {
      return null;
    }
  }




  String? validateEmployeeId(String? value) {
    if (value == null) {
      return null;
    } else {
      if (value.length < 1) {
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




