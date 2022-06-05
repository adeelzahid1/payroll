import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:network/HttpService.dart';
import 'package:payroll/modals/AllUserNameIds.dart';
import 'package:payroll/modals/LeaveBalanceView.dart';
import 'package:payroll/modals/enum/CallState.dart';
import 'package:payroll/modals/widgets/DropDownValue.dart';
import 'package:payroll/repo/AttendanceRepo.dart';
import 'package:payroll/repo/PayrollRepo.dart';
import 'package:intl/intl.dart';
import 'package:payroll/screens/leaveBalance/grid/LeaveStatus.dart';

class LeaveBalanceViewDataNotifier extends ChangeNotifier {

  LeaveBalanceViewDataNotifier(int? leaveTypeId) {
    if(leaveTypeId!=null) {
      fetchData(leaveTypeId);
    }
  }

  LeaveBalanceView leaveBalanceModal = new LeaveBalanceView();
  PayRollRepo get repository => GetIt.I<PayRollRepo>();
  AttendanceRepo get balanceRepository => GetIt.I<AttendanceRepo>();


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

  set filterData(LeaveBalanceView leave) {
    leaveBalanceModal = leave;
    notifyListeners();
  }


  // Future<APIRespons>  update() async {
  //   return await repository.updateLeaveBalanceView(leaveAppModel).then((value) {
  //     return value;
  //   });
  // }


  Future<APIRespons>  submit() async {
    // return await balanceRepository.addLeaveBalanceView(leaveBalanceModal).then((value) {
    return await balanceRepository.getLeaveBalanceViewById(leaveBalanceModal.id).then((value) {  //todo: need to be change it.
      return value;
    });
  }

  Future<void> fetchData(int?  leaveStatus) async {
    callState = CallState.loading;
    balanceRepository.getLeaveBalanceViewById(leaveStatus).then((value) {
      if(!value.error && value.data!=null){
        leaveBalanceModal = value.data;
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
    leaveBalanceModal.employeeId = value!.value;
  }

  onSaveUserNameId(DropDownVal? value) {
    print("On Change Name");
    leaveBalanceModal.employeeId = value!.value.toString();
    var onlyName = value.name!.split("   ");
    leaveBalanceModal.employeeName = onlyName[0];
    leaveBalanceModal.employeeName = value.name;
    leaveBalanceModal.employeeId = value.value;
    notifyListeners();
    print(leaveBalanceModal.employeeName);
    print(leaveBalanceModal.employeeId);
  }


  String? validateName(String? value) {
    print("Validate Name");
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
      return null;
    } else {
      if (value.length < 20) {
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
  // List<DropDownVal>? leaveTypeDDList;
  // void getLeaveTypeList() async {
  //   var c = await repository.getAllLeaveTypes();
  //   if(c.data != null){
  //     List<LeaveType> data = c.data;
  //     List<DropDownVal> leaveDDList = [
  //       DropDownVal(name: 'choose Leave Type', value: -1)
  //     ];
  //     for (int i = 0; i < data.length; i++) {
  //       leaveDDList.add(DropDownVal(name: data[i].name, value: data[i].id));
  //     }
  //     leaveTypeDDList = leaveDDList;
  //     notifyListeners();
  //   }
  // }


/////////////// List Get All Employee Name and List ///////////////
  List<DropDownVal>? userIdDDList;
  List<DropDownVal>? userNameDDList;

  void getUserNameIdList() async {
    var c = await repository.getAllUserNameId();
    if(c.data != null){
      List<AllUserNameId> data = c.data;
      List<DropDownVal> leaveDDList = [DropDownVal(name: 'choose a User', value: -1)];
      List<DropDownVal> leaveIdDDList = [DropDownVal(name: 'choose a User', value: -1)];
      for (int i = 0; i < data.length; i++) {
        leaveDDList.add(DropDownVal(name: "${data[i].employeeName}",  value: "${data[i].employeeId}"));   // todo: maybe change it. (" + "    " + ")
        leaveIdDDList.add(DropDownVal(name: "${data[i].employeeId}",  value: "${data[i].employeeId}"));   // todo: maybe change it. (" + "    " + ")
        //leaveDDList.add(DropDownVal(name: "${data[i].userName}    ${data[i].userId!.substring(1,8)}", value: data[i].userId));   // todo: maybe change it. (" + "    " + ")
      }
      userNameDDList = leaveDDList;
      userIdDDList = leaveIdDDList;
      notifyListeners();
    }
  }






  void onSaveStartLeaveDate(value) {
    print("VAA $value");
    //var newDate = DateFormat('MMMM-dd-yyyy').format(value);
    // leaveAppModel.startDate = DateFormat('MMMM-dd-yyyy').format(value);

    //leaveBalanceModal.startDate = value; //DateTime.tryParse(value);
  //  notifyListeners();
    //calculateDays();
  }

  void onSaveEndLeaveDate(value) {
    //leaveBalanceModal.endDate = value;
   // notifyListeners();
  }

  void onSavedEndLeaves(value) {
   // leaveBalanceModal.endDate = value; //DateTime.tryParse(value);
   // notifyListeners();
    //calculateDays();
  }








  var _filterData = <LeaveStatus>[];
  var _GroupModel = <LeaveStatus>[];

  Future<List<LeaveStatus>> getLeaveData() async{
    callState = CallState.loading;
    _GroupModel = [
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

    _filterData.clear();
    _filterData.addAll(_GroupModel);
    callState= CallState.data;
    notifyListeners();
    return _GroupModel;
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





}




