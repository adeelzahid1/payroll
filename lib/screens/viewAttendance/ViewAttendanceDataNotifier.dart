// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';
// import 'package:network/HttpService.dart';
// import 'package:payroll/modals/ViewAttendanceGrid.dart';
//
// import 'package:payroll/modals/enum/CallState.dart';
// import 'package:payroll/repo/AttendanceRepo.dart';
//
//
//
// class ViewAttendanceGridDataNotifier extends ChangeNotifier {
//   AttendanceRepo get repository => GetIt.I<AttendanceRepo>();
//   CallState callState = CallState.loading;
//
//   ViewAttendanceGridDataNotifier() {
//    // fetchData();
//   }
//
//   List<ViewAttendanceGrid> get filterData => _filterData;
//
//   set filterData(List<ViewAttendanceGrid> attendanceGridType) {
//     _filterData = attendanceGridType;
//     notifyListeners();
//   }
//
//   int get sortColumnIndex => _sortColumnIndex;
//
//   set sortColumnIndex(int sortColumnIndex) {
//     _sortColumnIndex = sortColumnIndex;
//     notifyListeners();
//   }
//
//   // SORT ASCENDING....
//
//   bool get sortAscending => _sortAscending;
//   set sortAscending(bool sortAscending) {
//     _sortAscending = sortAscending;
//     notifyListeners();
//   }
//
//   int get rowsPerPage => _rowsPerPage;
//   set rowsPerPage(int rowsPerPage) {
//     _rowsPerPage = rowsPerPage;
//     notifyListeners();
//   }
//
//   onSearchTextChanged(String text) async {
//     _filterData.clear();
//     if (text.isEmpty) {
//       _filterData.addAll(_viewAttendanceGridModel);
//     } else {
//       _viewAttendanceGridModel.forEach((viewDetail) {
//           if (viewDetail.status!.toLowerCase().contains(text.toLowerCase())) {
//           _filterData.add(viewDetail);
//         }
//       });
//     }
//     notifyListeners();
//   }
//
//
//   void addUpdateViewAttendanceGrid(ViewAttendanceGrid attendanceType, bool isUpdate) {
//     if(isUpdate){
//       int index = _filterData.indexWhere((element) => element.employeeId == attendanceType.employeeId);
//       _filterData[index] = attendanceType;
//
//       int indexMain = _viewAttendanceGridModel.indexWhere((element) => element.employeeId == attendanceType.employeeId);
//       _viewAttendanceGridModel[indexMain] = attendanceType;
//     }
//     else{
//       //_leaveTypeModel.add(leaveType);  //todo :: commet it
//       _filterData.add(attendanceType);
//     }
//     notifyListeners();
//   }
//
//   void deleteViewAttendanceGrid(ViewAttendanceGrid leaveType) {
//     _filterData.remove(leaveType);
//     _viewAttendanceGridModel.remove(leaveType);
//     notifyListeners();
//   }
//
//
//   Future<APIRespons>  deleteItemName(ViewAttendanceGrid leaveType) async {
//     return await repository.deleteViewAttendance(int.tryParse(leaveType.employeeId!)).then((value) {
//       if(!value.error) {
//         _filterData.remove(leaveType);
//         _viewAttendanceGridModel.remove(leaveType);
//         notifyListeners();
//       }
//       return value;
//     });
//   }
//
//
//
//
//   //////////////// internal ///////////
//   var _filterData = <ViewAttendanceGrid>[];
//   var _viewAttendanceGridModel = <ViewAttendanceGrid>[];
//   int _sortColumnIndex =0;
//   bool _sortAscending = true;
//   int _rowsPerPage =  PaginatedDataTable.defaultRowsPerPage;
//
//
//
//
//   Future<List<ViewAttendanceGrid>> fetchData(viewAttendanceModel) async {
//     repository.checkViewAttendances(viewAttendanceModel).then((value) {
//       if(!value.error && value.data !=null){
//         _viewAttendanceGridModel.clear();
//         _filterData.clear();
//         _viewAttendanceGridModel = value.data;
//         _filterData = value.data;
//         callState= CallState.data;
//         notifyListeners();
//       }
//       else{
//         callState= CallState.failed;
//       }
//     });
//     return _viewAttendanceGridModel;
//   }
//
//   // Future<List<ViewAttendanceGrid>> fetchData(viewAttendanceModel) async {
//   //   repository.getAllViewAttendances(viewAttendanceModel).then((value) {
//   //     if(!value.error && value.data !=null){
//   //       _viewAttendanceGridModel.clear();
//   //       _filterData.clear();
//   //       _viewAttendanceGridModel = value.data;
//   //       _filterData = value.data;
//   //       callState= CallState.data;
//   //       notifyListeners();
//   //     }
//   //     else{
//   //       callState= CallState.failed;
//   //     }
//   //   });
//   //   return _viewAttendanceGridModel;
//   // }
//
//
// }
