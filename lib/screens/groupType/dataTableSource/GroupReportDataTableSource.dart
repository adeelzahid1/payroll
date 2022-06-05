import 'package:flutter/material.dart';
import 'package:payroll/modals/GroupCategoryRights.dart';
import 'package:payroll/utils/Colors.dart';

typedef OnRowSelect = void Function(int index);
typedef onDelete = void Function(int index);

class GroupReportDataTableSource extends DataTableSource {
  GroupReportDataTableSource({
    required List<GroupCategoryRights> groupData,
    required Map<String, String> columnData,
    required this.onRowSelect,
    required this.onDelete,
  })  : _groupData = groupData,
        assert(groupData != null),
        _columnData = columnData,
        assert(columnData != null);

  final List<GroupCategoryRights> _groupData;
  final Map<String, String> _columnData;
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
        DataCell(Text(_group.title!)),
        ..._columnData.entries.map((e) {
          List<GroupCategoryRights> itemList = _group.children;

          bool isFound = false;
          late GroupCategoryRights selectItem; // late

          for (int i = 0; i < itemList.length; i++) {
            if (itemList[i].title == e.key) {
              isFound = true;
              selectItem = itemList[i];
              break;
            }
          }

          if (isFound) {
            return DataCell(
              Center(
                child: Checkbox(
                  onChanged: (bo) {
                    print('$bo');
                  },
                  value: selectItem.isSelected ?? false,
                ),
              ),
            );
          } else {
            return DataCell(Center(
                child: Icon(
              Icons.domain_disabled,
              color: iconColor,
            )));
          }
        }).toList()
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
    Map<String, String> columnData,
  ) =>
      <DataColumn>[
        DataColumn(label: Text('Form Label')),
        ...columnData.entries.map((value) {
          print('''I'm $value''');
          return DataColumn(label: Text('${value.value}'));
        }).toList()

        // ... columnData.map((e, val) {
        //   return  DataColumn(
        //       label: Text('${e}')
        //   );
        // }).toList()
      ];

  // static void _sort<T>(
  //   Comparable<T> Function(GroupCategoryRight group) getField,
  //   int colIndex,
  //   bool asc,
  //   GroupReportDataTableSource _src,
  //   GroupCategoryRightDataNotifier _provider,
  // ) {
  //   _src.sort<T>(getField, asc);
  //   _provider.sortAscending = asc;
  //   _provider.sortColumnIndex = colIndex;
  // }

  /*
   *
   * Sorts this list according to the order specified by the [compare] function.
    The [compare] function must act as a [Comparator].
   */
  void sort<T>(
      Comparable<T> Function(GroupCategoryRights d) getField, bool ascending) {
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
