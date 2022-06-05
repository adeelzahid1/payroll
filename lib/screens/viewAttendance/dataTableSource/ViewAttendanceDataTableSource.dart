import 'package:flutter/material.dart';
import 'package:payroll/modals/ViewAttendanceGrid.dart';
import 'package:payroll/screens/viewAttendance/addViewAttendance/AddViewAttendanceDataNotifier.dart';
// import 'package:payroll/screens/viewAttendance/ViewAttendanceDataNotifier.dart';
import 'package:payroll/widgets/texts/CustomTextSL.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

typedef OnRowSelect = void Function(int index);
typedef onDelete = void Function(int index);

class ViewAttendanceGridDataTableSource extends DataTableSource {
  ViewAttendanceGridDataTableSource({
    required List<ViewAttendanceGrid> attendanceData,
    required this.onRowSelect,
    required this.onDelete,
  })   : _attendanceData = attendanceData,
        assert(attendanceData != null);

  final List<ViewAttendanceGrid> _attendanceData;
  final OnRowSelect onRowSelect;
  final OnRowSelect onDelete;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);

    // if (index >= _departmentData.length) {
    //   return DataRow;
    // }
    final _attendanceView = _attendanceData[index];

    return DataRow.byIndex(
      index: index, // DON'T MISS THIS
      cells: <DataCell>[
        DataCell( InkWell(
          // onTap: () => onRowSelect(index),
          onTap: () => print("$index : ${_attendanceView.employeeId}"),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.amber,
            ),
            child: CustomTextSL(text: "view", fontWeight: FontWeight.w600, ),
          ),
        ),),
        DataCell(Align(alignment: Alignment.center, child: Text('${index + 1}'))),
        DataCell(Text('${DateFormat("dd-MM-yyyy").format(DateTime.parse(_attendanceView.date ?? "2012-12-12"))}')),
        DataCell(Text('${_attendanceView.status ?? ""}')),
        DataCell(Text('${_attendanceView.workingHour ?? ""}')),
        DataCell(Text('${_attendanceView.dutyHour ?? ""}')),
        DataCell(Text('${_attendanceView.inTime ?? ""}')),
        DataCell(Text('${_attendanceView.outTime ?? ""}')),
        DataCell(Text('${_attendanceView.totalTime ?? ""}')),
        DataCell(Text('${_attendanceView.overTime ?? ""}')),


        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // IconButton(
              //   icon: Icon(Icons.edit, color: Colors.amber),
              //   onPressed: () => onRowSelect(index),
              // ),
              // SizedBox(width: 8),
              // IconButton(
              //   icon: Icon(Icons.delete, color: Colors.redAccent.shade400,),
              //   onPressed: () {
              //     onDelete(index);
              //   },
              // ),

              InkWell(
                onTap: ()=>print("Accept Click $index"),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.green,
                  ),
                  child: CustomTextSL(text: "=", fontWeight: FontWeight.w600, color: Colors.white,),
                ),
              ),SizedBox(width: 12),

              InkWell(
                onTap: (){
                  //onDelete(index);
                  print("Reject Click $index");
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.red,
                  ),
                  child: CustomTextSL(text: "=", fontWeight: FontWeight.w600, color: Colors.white, ),
                ),
              ),

              // RoundIconButton(
              //   icon: Icons.delete,
              //   width: 30, height: 30,
              //   iconColor: Colors.redAccent,
              //   onPress: () {  },
              // ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _attendanceData.length;

  @override
  int get selectedRowCount => 0;

  static List<DataColumn> colGen(
      ViewAttendanceGridDataTableSource _src,
      AddViewAttendanceDataNotifier _provider,
      ) =>
      <DataColumn>[
        DataColumn(
          label: Text("View"),
          tooltip: "View",
        ),
        DataColumn(
          label: Text("No."),
          numeric: true,
          tooltip: "No.",
          // onSort: (colIndex, asc) {
          //   _sort<num>((product) => product.id, colIndex, asc, _src, _provider);
          // },
        ),
        DataColumn(
          label: Text("Date"),
          tooltip: "Date",
          onSort: (colIndex, asc) {
            _sort<String>((leaveApplication) => leaveApplication.date!.toLowerCase(),
                colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text("Status"),
          tooltip: "Status",
          onSort: (colIndex, asc) {
            _sort<String>((leaveApplication) => leaveApplication.status!.toLowerCase(),
                colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text("Working Hour"),
          tooltip: "Working Hour",
          onSort: (colIndex, asc) {
            _sort<String>((leaveApplication) => leaveApplication.workingHour!.toString(),
                colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
        label: Text("Duty Hour"),
        tooltip: "Duty Hour",
        onSort: (colIndex, asc) {
          _sort<String>((leaveApplication) => leaveApplication.dutyHour!.toString(),
              colIndex, asc, _src, _provider);
        },
      ),
        DataColumn(
        label: Text("IN Time"),
        tooltip: "IN Time",
        onSort: (colIndex, asc) {
          _sort<String>((leaveApplication) => leaveApplication.inTime!.toString(),
              colIndex, asc, _src, _provider);
        },
      ),
        DataColumn(
        label: Text("Out Time"),
        tooltip: "Out Time",
        onSort: (colIndex, asc) {
          _sort<String>((leaveApplication) => leaveApplication.outTime!.toString(),
              colIndex, asc, _src, _provider);
        },
      ),
        DataColumn(
        label: Text("Total Time"),
        tooltip: "Total Time",
        onSort: (colIndex, asc) {
          _sort<String>((leaveApplication) => leaveApplication.totalTime!.toString(),
              colIndex, asc, _src, _provider);
        },
      ),
        DataColumn(
        label: Text("Over Time"),
        tooltip: "Over Time",
        onSort: (colIndex, asc) {
          _sort<String>((leaveApplication) => leaveApplication.overTime!.toString(),
              colIndex, asc, _src, _provider);
        },
      ),




        DataColumn(
          label: Text("Actions"),
          tooltip: "Actions",
        ),
      ];

  static void _sort<T>(
      Comparable<T> Function(ViewAttendanceGrid department) getField,
      int colIndex,
      bool asc,
      ViewAttendanceGridDataTableSource _src,
      AddViewAttendanceDataNotifier _provider,
      ) {
    _src.sort<T>(getField, asc);
    _provider.sortAscending = asc;
    _provider.sortColumnIndex = colIndex;
  }

  /*
   *
   * Sorts this list according to the order specified by the [compare] function.
    The [compare] function must act as a [Comparator].
   */
  void sort<T>(
      Comparable<T> Function(ViewAttendanceGrid d) getField, bool ascending) {
    _attendanceData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }
}

