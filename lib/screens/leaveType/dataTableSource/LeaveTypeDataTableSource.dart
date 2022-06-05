import 'package:flutter/material.dart';
import 'package:network/models/theme/ThemeProvider.dart';
import 'package:payroll/modals/AddLeaveType.dart';
import 'package:payroll/screens/leaveType/LeaveTypeDataNotifier.dart';
import 'package:provider/provider.dart';

typedef OnRowSelect = void Function(int index);
typedef onDelete = void Function(int index);

class LeaveTypeDataTableSource extends DataTableSource {
  LeaveTypeDataTableSource({
    required List<LeaveType> departmentData,
    required this.onRowSelect,
    required this.onDelete,
  })   : _allowanceData = departmentData,
        assert(departmentData != null);

  final List<LeaveType> _allowanceData;
  final OnRowSelect onRowSelect;
  final OnRowSelect onDelete;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);

    // if (index >= _departmentData.length) {
    //   return DataRow;
    // }
    final _leaveType = _allowanceData[index];

    return DataRow.byIndex(
      index: index, // DON'T MISS THIS
      cells: <DataCell>[
        DataCell(
            Align(alignment: Alignment.center, child: Text('${index + 1}'))),
        DataCell(Text('${_leaveType.name}')),
        DataCell(Text('${_leaveType.numberOfLeaves}')),

        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: Colors.yellow),
                onPressed: () => onRowSelect(index),
              ),
              SizedBox(width: 8),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.redAccent.shade400,),
                onPressed: () {
                  onDelete(index);
                },
              ),
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
      LeaveTypeDataTableSource _src,
      LeaveTypeDataNotifier _provider,
      ) =>
      <DataColumn>[
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
          tooltip: "Allowance Type Name",
          onSort: (colIndex, asc) {
            _sort<String>((leaveType) => leaveType.name!.toLowerCase(),
                colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text("Leaves"),
          tooltip: "Number of Leaves",
          onSort: (colIndex, asc) {
            _sort<String>((leaveType) => leaveType.numberOfLeaves!.toString().toLowerCase(),
                colIndex, asc, _src, _provider);
          },
        ),



        DataColumn(
          label: Text("Edit"),
          tooltip: "Edit",
        ),
      ];

  static void _sort<T>(
      Comparable<T> Function(LeaveType department) getField,
      int colIndex,
      bool asc,
      LeaveTypeDataTableSource _src,
      LeaveTypeDataNotifier _provider,
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
      Comparable<T> Function(LeaveType d) getField, bool ascending) {
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

