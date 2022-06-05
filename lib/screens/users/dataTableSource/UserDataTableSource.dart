
import 'package:flutter/material.dart';
import 'package:payroll/modals/User.dart';
import '../UserDataNotifier.dart';
import 'package:payroll/widgets/checkBox/CustomCheckBox.dart';

typedef OnRowSelect = void Function(int index);
typedef onDelete = void Function(int index);

class UserDataTableSource extends DataTableSource {
  UserDataTableSource({
    required List<User> userData,
    required this.onRowSelect,
    required this.onDelete,
  })  : _userData = userData,
        assert(userData != null);

  final List<User> _userData;
  final OnRowSelect onRowSelect;
  final OnRowSelect onDelete;

// Only User Data Display .. Headings not Included
  @override
  DataRow? getRow(int index) {
    print("index is : $index");
    assert(index >= 0);

    if (index >= _userData.length) {
      return null;
    }
    final _user = _userData[index];
    print(_user);

    return DataRow.byIndex(
      index: index, // DONT MISS THIS
      cells: <DataCell>[
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    print(_user.id);
                    onRowSelect(index);
                  }),
              SizedBox(width: 8),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  print(_user);
                  onDelete(index);
                },
              ),
            ],
          ),
        ),
        DataCell(Align(alignment: Alignment.center, child: Text('$index'))),
        DataCell(Text('${_user.name}')),
        DataCell(Text('${_user.loginId}')),
        DataCell(Text('${_user.email}')),
        DataCell(Text('${_user.comment}')),
        DataCell(Text(_user.shop != null ? '${_user.shop!.shopName}' : "")),
        DataCell(Text(_user.endDate != null ? '${_user.endDate}' : "")),
        DataCell(
          CustomCheckBox(_user.showSecondaryCost, (bool? value) {}),
        ),
        DataCell(
          CustomCheckBox(_user.applyAdjustment, (bool? value) {}),
        ),
        DataCell(
          CustomCheckBox(_user.applyOpenAdjustment, (bool? value) {}),
        ),
        DataCell(
          CustomCheckBox(_user.hideStockInHelp, (bool? value) {}),
        ),
        DataCell(
          CustomCheckBox(_user.allowReleaseDownload, (bool? value) {}),
        ),
        DataCell(
          CustomCheckBox(_user.allowPOSDiscount, (bool? value) {}),
        ),
        DataCell(
          CustomCheckBox(_user.allowPOSPriceEditing, (bool? value) {}),
        ),
        DataCell(
          CustomCheckBox(_user.showSecondaryCost, (bool? value) {}),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _userData.length;

  @override
  int get selectedRowCount => 0;

  static List<DataColumn> colGen(
    UserDataTableSource _src,
    UserDataNotifier _provider,
  ) =>
      <DataColumn>[
        DataColumn(
          label: Text("Actions"),
          tooltip: "Actions",
        ),
        DataColumn(
          label: Text("No."),
          numeric: true,
          tooltip: "No.",
          onSort: (colIndex, asc) {
            _sort<num>((user) => user.id!, colIndex, asc, _src, _provider);
          },
        ),
        DataColumn(
          label: Text("User Name"),
          tooltip: "Name",
          onSort: (colIndex, asc) {
            _sort<String>((user) => user.name!.toLowerCase(), colIndex, asc,
                _src, _provider);
          },
        ),
        DataColumn(
          label: Text("User Log ID"),
          tooltip: "User Log ID",
        ),
        DataColumn(
          label: Text("User Email"),
          tooltip: "Email",
          onSort: (colIndex, asc) {
            _sort<String>((user) => user.email!.toLowerCase(), colIndex, asc,
                _src, _provider);
          },
        ),
        DataColumn(
          label: Text("User Comments"),
          tooltip: "Comments",
        ),
        DataColumn(
          label: Text("Shop"),
          tooltip: "Shop",
        ),
        DataColumn(
          label: Text("End Date"),
          tooltip: "End Date",
        ),
        DataColumn(
          label: Text("Cost Price"),
          tooltip: "Cost Price",
        ),
        DataColumn(
          label: Text("Apply Adjustment"),
          tooltip: "Apply Adjustment",
        ),
        DataColumn(
          label: Text("Opne Adjustment"),
          tooltip: "Apply Opne Adjustment",
        ),
        DataColumn(
          label: Text("Hide Stock"),
          tooltip: "Hide Stock in Help",
        ),
        DataColumn(
          label: Text("Release Download"),
          tooltip: "Allow Release Download",
        ),
        DataColumn(
          label: Text("POS Discount Editing"),
          tooltip: "Allow POS Discount Editing",
        ),
        DataColumn(
          label: Text("POS Price Editing"),
          tooltip: "Allow POS Price Editing",
        ),
        DataColumn(
          label: Text("Secondary Cost"),
          tooltip: "Show Secondary Cost",
        ),
      ];

  static void _sort<T>(
    Comparable<T> Function(User user) getField,
    int colIndex,
    bool asc,
    UserDataTableSource _src,
    UserDataNotifier _provider,
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
  void sort<T>(Comparable<T> Function(User d) getField, bool ascending) {
    _userData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    notifyListeners();
  }
}
