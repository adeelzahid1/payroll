import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:network/HttpService.dart';
import 'package:payroll/modals/AllUserNameIds.dart';
import 'package:payroll/modals/ViewAttendance.dart';
import 'package:payroll/modals/ViewAttendanceGrid.dart';
import 'package:payroll/modals/enum/CallState.dart';
import 'package:payroll/modals/widgets/DropDownValue.dart';
import 'package:payroll/repo/AttendanceRepo.dart';
import 'package:payroll/repo/PayrollRepo.dart';
import 'package:intl/intl.dart';

class AddViewAttendanceDataNotifier extends ChangeNotifier {

  ViewAttendance viewAttendanceModel = new ViewAttendance();
  AttendanceRepo get repository => GetIt.I<AttendanceRepo>();
  PayRollRepo get repositoryPayroll => GetIt.I<PayRollRepo>();

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


  AddViewAttendanceDataNotifier() {}

  set filterData(ViewAttendance attendance) {
    viewAttendanceModel = attendance;
    notifyListeners();
  }


  Future<APIRespons>  update() async {
    return await repository.updateViewAttendance(viewAttendanceModel).then((value) {
      return value;
    });
  }



  // void submit() async {
  //   viewGridNotifier.fetchData(viewAttendanceModel);
  // }

  // List<ViewAttendanceGrid> attendaceList = [];
  // Future<void>  submit() async {
  //   return await viewGridNotifier.fetchData(viewAttendanceModel).then((value) {
  //     viewGridNotifier.filterData = value;
  //      attendaceList = value;
  //      //print(attendaceList);
  //     return value;
  //   });
  // }



  // Future<APIRespons>  submit() async {
  //   return await repository.addViewAttendance(viewAttendanceModel).then((value) {
  //     return value;
  //   });
  // }



  Future<void> fetchData(int?  viewTypeId) async {
    callState = CallState.loading;
    repository.getViewAttendanceById(viewTypeId).then((value) {
      if(!value.error && value.data!=null){
        viewAttendanceModel = value.data;
        callState = CallState.data;
      }
      else{
        callState = CallState.failed;
      }
      notifyListeners();

    });
  }



  void onSavedEmpId(String? value) {
    viewAttendanceModel.employeeId = value;
    notifyListeners();
  }

  void onSavedEmpName(String? value) {
    viewAttendanceModel.employeeName = value;
    notifyListeners();
  }

  void onSaveViewStartDate(value) {
    print("VAA $value");
    notifyListeners();
    //var newDate = DateFormat('MMMM-dd-yyyy').format(value);
    // leaveAppModel.startDate = DateFormat('MMMM-dd-yyyy').format(value);
    // "startDate": "2021-10-22 00:00:00.0000000",
    // "endDate": "2021-10-30 12:00:00.0000000"
    viewAttendanceModel.startDate = value; //DateTime.tryParse(value);
    //calculateDays();
  }

  void onChangeStartDate(date) {
    {print("On Change Start Date $date");}
    viewAttendanceModel.startDate = date+"000"; //DateTime.tryParse(value);
    notifyListeners();
    // String newDate = DateFormat('dd MMMM yyyy').format(date).toString();
    String newDate = DateFormat('dd MMMM yyyy').format(DateTime.parse(date));
    print(newDate);

    //calculateDays();
  }

  void onChangeEndDate(date) {
    viewAttendanceModel.endDate = date+"000"; //DateTime.tryParse(value);
    {print("On Change END Date ${viewAttendanceModel.endDate}");}
    notifyListeners();
    //calculateDays();
  }

  void onSaveViewEndDate(value) {
    viewAttendanceModel.endDate = value;
    notifyListeners();
  }

  onSaveUserNameId(DropDownVal? value) {
    if(value!.value != -1){
      viewAttendanceModel.employeeId = value.value.toString();
      var onlyName = value.name!.split("   ");
      viewAttendanceModel.employeeName = onlyName[0];
      // viewAttendanceModel.employeeId = onlyName[1];
      viewAttendanceModel.employeeId = value.value;
      print("${onlyName[0]} :  ${onlyName[1]}");
    }
  }





// validate Employee Name
  String? validateEmployeeName(String? value) {
    if (value != null) {
      if (value.length < 3) {
        return 'please enter valid name';
      }
      else {
        return null;
      }
    }
  }

//validate Employee Id
  String? validateEmployeeId(String? value) {
    if (value == null || value.length < 1) {
      return "employee id is required";
    }
    else {
      return null;
    }
  }

  //validate start date
  String? validateStartDate(String? str) {
    print("validation of Start date");
    print(str);
    if(str!=null && str.length <5){
      return "Select a Date";
    }
    return null;
  }

  // validate End Date
  String? validateEndDate(String? str) {
    print("validation of End date");
    if(str!=null && str.length <5){
      return "Select a Date";
    }
    return null;
  }

  // validate Dropdown list of employees.
  String? validateUserNameIdDDL(DropDownVal? value) {
    if (value != null) {
      if (value.value == -1) {
        return 'Please select an option';
      }
      else {
        return null;
      }
    }
  }


  // /////////////// Get All Employee Name and Id ///////////////
  List<DropDownVal>? userIdNameDDList;
  void getUserNameIdList() async {
    var c = await repositoryPayroll.getAllUserNameId();
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
    }
  }

















//Grid Notifer All DAta
//Grid Notifer All DAta
//Grid Notifer All DAta
//Grid Notifer All DAta
//Grid Notifer All DAta

  List<ViewAttendanceGrid> get filterGridData => _filterGridData;
  set filterGridData(List<ViewAttendanceGrid> attendanceGridType) {
    _filterGridData = attendanceGridType;
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



  var _filterGridData = <ViewAttendanceGrid>[];
  var _viewAttendanceGridModel = <ViewAttendanceGrid>[];
  int _sortColumnIndex =0;
  bool _sortAscending = true;
  int _rowsPerPage =  PaginatedDataTable.defaultRowsPerPage;

  Future<void> submit() async {  //submit(viewAttendanceModel)
    repository.checkViewAttendances(viewAttendanceModel).then((value) {
      if(!value.error && value.data !=null){
        _viewAttendanceGridModel.clear();
        _filterGridData.clear();
        _viewAttendanceGridModel = value.data;
        _filterGridData = value.data;
        callState= CallState.data;
        notifyListeners();
      }
      else{
        callState= CallState.failed;
      }
    });
    notifyListeners();
  }

  //Search Text Field
  onSearchTextChanged(String text) async {
    _filterGridData.clear();
    if (text.isEmpty) {
      _filterGridData.addAll(_viewAttendanceGridModel);
    } else {
      _viewAttendanceGridModel.forEach((viewDetail) {
        print("309 VIWE Detail: $viewDetail");
        if(viewDetail.status!=null && viewDetail.status!.isNotEmpty){
          if (viewDetail.status!.toLowerCase().contains(text.toLowerCase())) {
            _filterGridData.add(viewDetail);
          }
        }
      });
    }
    notifyListeners();
  }





}




