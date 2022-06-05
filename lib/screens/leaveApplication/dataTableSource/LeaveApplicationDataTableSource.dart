import 'package:flutter/material.dart';
import 'package:payroll/modals/LeaveApplication.dart';
import 'package:payroll/screens/leaveApplication/LeaveApplicationDataNotifier.dart';
import 'package:payroll/widgets/roundIconButton/roundIconButton.dart';
import 'package:payroll/widgets/texts/CustomTextSL.dart';
import 'package:intl/intl.dart';


import 'package:provider/provider.dart';

typedef OnRowSelect = void Function(int index);
typedef onDelete = void Function(int index);
typedef onAccept = void Function(int index);

class LeaveApplicationDataTableSource extends DataTableSource {
  LeaveApplicationDataTableSource({
    required List<LeaveApplication> departmentData,
    required this.onRowSelect,
    //required this.onDelete,
    required this.onAccept,
    this.onReject,
  })   : _allowanceData = departmentData,
        assert(departmentData != null);

  final List<LeaveApplication> _allowanceData;
  final OnRowSelect onRowSelect;
  //final OnRowSelect onDelete;
  final OnRowSelect onAccept;
  final Function(int index, bool isReject)? onReject;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);

    // if (index >= _departmentData.length) {
    //   return DataRow;
    // }
    final _leaveApplication = _allowanceData[index];

    return DataRow.byIndex(
      index: index, // DON'T MISS THIS
      cells: <DataCell>[
        DataCell( InkWell(
          onTap: () => onRowSelect(index),
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
        DataCell(Text('${_leaveApplication.employeeName}')),
        DataCell(Text('${_leaveApplication.employeeId!.substring(1,8)}')),
        DataCell(Text('${_leaveApplication.leaveTypeId!}')),
        DataCell(Text('${_leaveApplication.applicantName!}')),
        DataCell(Text(DateTime.parse("${_leaveApplication.startDate}").toString().substring(0,10),),),
        DataCell(Text(DateTime.parse("${_leaveApplication.endDate}").toString().substring(0,10),),),
        // DataCell(Text('${_leaveApplication.endDate!}')),
        // var differnceOfDays = DateFormat("yyyy-MM-dd").parse(dt).difference(DateFormat("yyyy-MM-dd").parse(dt2)).inDays+1;
        // print(differnceOfDays);

        DataCell(Container(width: 200, child: Text('${_leaveApplication.reason}',overflow: TextOverflow.ellipsis))),

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
                // onTap: ()=>print("Accept Click $index"),
                onTap: (){onAccept(index);},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.green,
                  ),
                  child: CustomTextSL(text: "Accept", fontWeight: FontWeight.w600, color: Colors.white,),
                ),
              ),SizedBox(width: 12),

              InkWell(
                onTap: (){
                  onReject!(index, true);
                  //onDelete(index);
                  print("Reject Click $index");
                  },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.red,
                  ),
                  child: CustomTextSL(text: "Reject", fontWeight: FontWeight.w600, color: Colors.white, ),
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
  int get rowCount => _allowanceData.length;

  @override
  int get selectedRowCount => 0;

  static List<DataColumn> colGen(
      LeaveApplicationDataTableSource _src,
      LeaveApplicationDataNotifier _provider,
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
          label: Text("Name"),
          tooltip: "User Name",
          onSort: (colIndex, asc) {
            _sort<String>((leaveApplication) => leaveApplication.employeeName!.toLowerCase(),
                colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text("User Id"),
          tooltip: "User ID",
          onSort: (colIndex, asc) {
            _sort<String>((leaveApplication) => leaveApplication.employeeId!.toLowerCase(),
                colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text("Leave Type"),
          tooltip: "Leave Type ID",
          onSort: (colIndex, asc) {
            _sort<String>((leaveApplication) => leaveApplication.leaveTypeId!.toString(),
                colIndex, asc, _src, _provider);
          },
        ), DataColumn(
          label: Text("Applicant Name"),
          tooltip: "Applicant Name",
          onSort: (colIndex, asc) {
            _sort<String>((leaveApplication) => leaveApplication.applicantName!.toString(),
                colIndex, asc, _src, _provider);
          },
        ), DataColumn(
          label: Text("Start Date"),
          tooltip: "Start Date",
          onSort: (colIndex, asc) {
            _sort<String>((leaveApplication) => leaveApplication.startDate!.toString(),
                colIndex, asc, _src, _provider);
          },
        ), DataColumn(
          label: Text("End Date"),
          tooltip: "End Date",
          onSort: (colIndex, asc) {
            _sort<String>((leaveApplication) => leaveApplication.endDate!.toString(),
                colIndex, asc, _src, _provider);
          },
        ), DataColumn(
          label: Text("Reason"),
          tooltip: "Reason",
          onSort: (colIndex, asc) {
            _sort<String>((leaveApplication) => leaveApplication.reason!.toString(),
                colIndex, asc, _src, _provider);
          },
        ),




        DataColumn(
          label: Text("Actions"),
          tooltip: "Actions",
        ),
      ];

  static void _sort<T>(
      Comparable<T> Function(LeaveApplication department) getField,
      int colIndex,
      bool asc,
      LeaveApplicationDataTableSource _src,
      LeaveApplicationDataNotifier _provider,
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
      Comparable<T> Function(LeaveApplication d) getField, bool ascending) {
    _allowanceData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }
}

