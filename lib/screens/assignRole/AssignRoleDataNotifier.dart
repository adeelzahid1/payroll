import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:network/HttpService.dart';
import 'package:payroll/modals/AddLeaveType.dart';
import 'package:payroll/modals/AllUserNameIds.dart';
import 'package:payroll/modals/Role.dart';
import 'package:payroll/modals/enum/CallState.dart';
import 'package:payroll/modals/widgets/DropDownValue.dart';
import 'package:intl/intl.dart';
import 'package:payroll/repo/RolesClaimsRepo.dart';

class AssignRoleDataNotifier extends ChangeNotifier {

  Role roleModel = new Role();
  RolesClaimsRepo get repository => GetIt.I<RolesClaimsRepo>();

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


  AssignRoleDataNotifier(String? leaveTypeId) {
    if(leaveTypeId!=null) {
      fetchData(leaveTypeId);
    }
  }

  set filterData(Role leave) {
    roleModel = leave;
    notifyListeners();
  }


  // Future<APIRespons>  update() async {
  //   return await repository.updateRole(roleModel).then((value) {
  //     return value;
  //   });
  // }


  Future<APIRespons>  submit() async {
    return await repository.addRole(roleModel).then((value) {
      return value;
    });
  }

  Future<void> fetchData(String?  leaveTypeId) async {
    callState = CallState.loading;
    repository.getRoleById(leaveTypeId).then((value) {
      if(!value.error && value.data!=null){
        roleModel = value.data;
        callState = CallState.data;
      }
      else{
        callState = CallState.failed;
      }
      notifyListeners();
    });
  }


  // Save Field Data
  onSaveRoleId(DropDownVal? value) {
    roleModel.id = value!.value;
  }


   String? validateRoleDDL(DropDownVal? value) {
    if (value == null || value.value == -1) {
      return 'Please select an option';
    }
      else {
        return null;
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
  

  /////////////// List Get All Leave Type ///////////////
  List<DropDownVal>? rolesDDList = [
    DropDownVal(name: 'Choose Role', value: -1),
    DropDownVal(name: 'ADMIN', value: "ADM101445"),
    DropDownVal(name: 'USER', value: "USR125445"),
    DropDownVal(name: 'CASHIER', value: "CAS125655"),
  ];

 void getAllRolesList() async {}

  // void getAllRolesList() async {
  //   var c = await repository.getAllRoles();
  //   if(c.data != null){
  //     List<LeaveType> data = c.data;
  //     List<DropDownVal> _list = [
  //       DropDownVal(name: 'Choose Role', value: -1)
  //     ];
  //     for (int i = 0; i < data.length; i++) {
  //       _list.add(DropDownVal(name: data[i].name, value: data[i].id));
  //     }
  //     rolesDDList = _list;
  //     notifyListeners();
  //   }
  // }



}