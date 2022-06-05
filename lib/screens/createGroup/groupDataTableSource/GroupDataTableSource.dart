import 'package:flutter/material.dart';
import 'package:payroll/modals/Group.dart';
import '../GroupDataNotifier.dart';

typedef OnRowSelect = void Function(int index);
typedef OnDelete = void Function(int index);

class GroupDataTableSource extends DataTableSource {
  GroupDataTableSource({
    required List<Group> groupData,
    required this.onRowSelect,
    required this.onDelete,
   }): _groupData = groupData;
   //       assert(groupData != null);

  final List<Group> _groupData;
  final OnRowSelect onRowSelect;
  final OnRowSelect onDelete;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);

    if (index >= _groupData.length) {
      return null;
    }
    final _group = _groupData[index];

    return DataRow.byIndex(
      index: index, // DONT MISS THIS
      cells: <DataCell>[
        DataCell(
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => onRowSelect(index),
              ),
              SizedBox(width: 8),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  onDelete(index);
                },
              ),
            ],
          ),
        ),
        DataCell(
            Align(alignment: Alignment.center, child: Text('${index + 1}'))),
        DataCell(Text('${_group.name}')),
        DataCell(Text('${_group.groupType!.name}')),
        DataCell(Text('${_group.comment}')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _groupData.length;

  @override
  int get selectedRowCount => 0;

  static List<DataColumn> colGen(
    GroupDataTableSource _src,
    GroupDataNotifier _provider,
  ) =>
      <DataColumn>[
        DataColumn(
          label: Text("Edit"),
          tooltip: "Edit",
        ),
        DataColumn(
          label: Text("No."),
          numeric: true,
          tooltip: "No.",
          // onSort: (colIndex, asc) {
          //   _sort<num>((group) => group.id, colIndex, asc, _src, _provider);
          // },
        ),
        DataColumn(
          label: Text("Group Name"),
          tooltip: "Name",
          onSort: (colIndex, asc) {
            _sort<String>((group) => group.name!.toLowerCase(), colIndex, asc,
                _src, _provider);
          },
        ),
        DataColumn(
          label: Text("Group Type"),
          tooltip: "Group Type",
          onSort: (colIndex, asc) {
            _sort<String>((group) => group.groupType!.name.toLowerCase(),
                colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text("Comments"),
          tooltip: "Comments",
        ),
      ];

  static void _sort<T>(
    Comparable<T> Function(Group group) getField,
    int colIndex,
    bool asc,
    GroupDataTableSource _src,
    GroupDataNotifier _provider,
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
  void sort<T>(Comparable<T> Function(Group d) getField, bool ascending) {
    _groupData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }
}
