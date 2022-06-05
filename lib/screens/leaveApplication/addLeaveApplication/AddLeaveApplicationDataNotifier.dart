import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:network/HttpService.dart';
import 'package:payroll/modals/AddLeaveType.dart';
import 'package:payroll/modals/AllUserNameIds.dart';
import 'package:payroll/modals/LeaveApplication.dart';
import 'package:payroll/modals/enum/CallState.dart';
import 'package:payroll/modals/widgets/DropDownValue.dart';
import 'package:payroll/repo/PayrollRepo.dart';
import 'package:intl/intl.dart';

class AddLeaveApplicationDataNotifier extends ChangeNotifier {

  LeaveApplication leaveAppModel = new LeaveApplication();
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


  AddLeaveApplicationDataNotifier(int? leaveTypeId) {
    if(leaveTypeId!=null) {
      fetchData(leaveTypeId);
    }
  }

  set filterData(LeaveApplication leave) {
    leaveAppModel = leave;
    notifyListeners();
  }


  Future<APIRespons>  update() async {
    return await repository.updateLeaveApplication(leaveAppModel).then((value) {
      return value;
    });
  }


  Future<APIRespons>  submit() async {
    leaveAppModel.applicantName = leaveAppModel.employeeName; // todo: change it after implement auth
    return await repository.addLeaveApplication(leaveAppModel).then((value) {
      return value;
    });
  }

  Future<void> fetchData(int?  leaveTypeId) async {
    callState = CallState.loading;
    repository.getLeaveApplicationById(leaveTypeId).then((value) {
      if(!value.error && value.data!=null){
        leaveAppModel = value.data;
        callState = CallState.data;

      }
      else{
        callState = CallState.failed;
      }
      notifyListeners();

    });
  }


  // Save Field Data
  onSaveLeaveTypeId(DropDownVal? value) {
    leaveAppModel.leaveTypeId = value!.value;
  }

  onSaveUserNameId(DropDownVal? value) {
    leaveAppModel.employeeId = value!.value;
    var onlyName = value.name!.split("   ");
    leaveAppModel.employeeName = onlyName[0];
  }

  onSaveReason(String value){
    leaveAppModel.reason = value;
    notifyListeners();
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

  String? validateLeaveTypeDDL(DropDownVal? value) {
    if (value == null) {
      return null;
    } else {
      if (value.value == -1) {
        return 'Please select an option';
      }
      else {
        return null;
      }
    }
  }

  String? validateUserNameIdDDL(DropDownVal? value) {
    if (value == null) {
      return null;
    } else {
      if (value.value == -1) {
        return 'Please select an option';
      }
      else {
        return null;
      }
    }
  }


//validate reason
  String? validateReason(String? value) {
    if (value == null) {
      return "please Enter Reason";
    } else {
      if (value.length < 10) {
        return 'Enter valid Reason';
      }
      else if (value.length >= 300) {
        return 'Character Max Length is 300';
      }
      else {
        return null;
      }
    }
  }

  //validate start date
  String? validateStartDate(String? str) {
    print(str);
    if(str!=null && str.length <5){
      return "Select a Date";
    }
      return null;
  }

  String? validateEndDate(String? str) {
    print("validation of End date");
    if(str!=null && str.length <5){
      return "Select a Date";
    }
    return null;
  }

  // /////////////// Get All Employee Name and Id ///////////////
  // void getCountries() async {
  //   var c = await repository.getAllCountries();
  //   if(c.data != null){
  //     List<Country> data = c.data;
  //     List<DropDownVal> countryDDList = [
  //       DropDownVal(name: 'Choose Country', value: -1)
  //     ];
  //     for (int i = 0; i < data.length; i++) {
  //       countryDDList.add(DropDownVal(name: data[i].name, value: data[i].id));
  //     }
  //     countriesDDList = countryDDList;
  //     notifyListeners();
  //   }
  // }


  /////////////// List Get All Leave Type ///////////////
  List<DropDownVal>? leaveTypeDDList;
  void getLeaveTypeList() async {
    var c = await repository.getAllLeaveTypes();
    if(c.data != null){
      List<LeaveType> data = c.data;
      List<DropDownVal> leaveDDList = [
        DropDownVal(name: 'choose Leave Type', value: -1)
      ];
      for (int i = 0; i < data.length; i++) {
        leaveDDList.add(DropDownVal(name: data[i].name, value: data[i].id));
      }
      leaveTypeDDList = leaveDDList;
      notifyListeners();
    }
  }


/////////////// List Get All Leave Type ///////////////
  List<DropDownVal>? userIdNameDDList;
  void getUserNameIdList() async {
    var c = await repository.getAllUserNameId();
    if(c.data != null){
      List<AllUserNameId> data = c.data;
      List<DropDownVal> leaveDDList = [
        DropDownVal(name: 'choose a User', value: -1)
      ];
      for (int i = 0; i < data.length; i++) {
        leaveDDList.add(DropDownVal(name: "${data[i].employeeName}    ${data[i].employeeId!}", value: data[i].employeeId));   // todo: maybe change it. (" + "    " + ")
        //leaveDDList.add(DropDownVal(name: "${data[i].userName}    ${data[i].userId!.substring(1,8)}", value: data[i].userId));   // todo: maybe change it. (" + "    " + ")
      }
      userIdNameDDList = leaveDDList;
      notifyListeners();
    }
  }






  void onSaveStartLeaveDate(value) {
     print("VAA $value");
     //var newDate = DateFormat('MMMM-dd-yyyy').format(value);
    // leaveAppModel.startDate = DateFormat('MMMM-dd-yyyy').format(value);

    leaveAppModel.startDate = value; //DateTime.tryParse(value);
    notifyListeners();
    //calculateDays();
  }

  void onSaveEndLeaveDate(value) {
    leaveAppModel.endDate = value;
    notifyListeners();
  }

  void onSavedEndLeaves(value) {
    leaveAppModel.endDate = value; //DateTime.tryParse(value);
    notifyListeners();
    //calculateDays();
  }












}




