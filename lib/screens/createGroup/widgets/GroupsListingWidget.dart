import 'package:flutter/material.dart';
import 'package:payroll/modals/Group.dart';
import '../GroupDataNotifier.dart';
import 'package:payroll/screens/createGroup/groupDataTableSource/GroupDataTableSource.dart';
import 'package:payroll/utils/AppUtiles.dart';
import 'package:payroll/utils/Colors.dart';
import 'package:payroll/widgets/DataTable/CustomPaginatedTable.dart';
import 'package:payroll/widgets/boxDecoration/BoxDecorationShadowCircle.dart';
import 'package:provider/provider.dart';

class GroupsListingWidget extends StatefulWidget {

  Function onItemSelected;
  Key key;
  GroupsListingWidget({required this.onItemSelected, required this.key}) : super(key: key);

  @override
  GroupsListingWidgetState createState() => GroupsListingWidgetState();
}

List<Group>  _model = [];
class GroupsListingWidgetState extends State<GroupsListingWidget> {

  late GroupDataNotifier _provider ;
  void updateGroup(Group group, bool isUpdate){
    _provider.addUpdteGroup(group, isUpdate);
  }

  @override
  Widget build(BuildContext context) {
    _provider = context.watch<GroupDataNotifier>();
    _model = _provider.filterData;
    final _dtSource = GroupDataTableSource(
      onRowSelect: (index) async {
        widget.onItemSelected(_model[index]);
      },
      groupData: _model,
      onDelete: (int index) {
        AppUtiles.showDialogBoxSingleAction(
          context: context,
          title: "Confirmation",
          content: "Are you sure you want to delete",
          btnText: "Delete",
          function: () {
            _provider.deleteGroup(_model[index]);
          },
        );
      },
    );

    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecorationShadowRectangle(),
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        child: Column(

          children: [
            Text("Groups" , style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),),
            SizedBox(height: 16),
            CustomPaginatedTable(
              actions: <IconButton>[
                IconButton(
                  splashColor: Colors.transparent,
                  icon: const Icon(Icons.save),
                  tooltip: "Save File",
                  onPressed: () {
                    //_provider.fetchData();
                    // _showSBar(context, DataTableConstants.refresh);
                  },
                ),
                IconButton(
                  splashColor: Colors.transparent,
                  tooltip: "Print",
                  icon: const Icon(Icons.print),
                  onPressed: () {
                    //_provider.fetchData();
                    // _showSBar(context, DataTableConstants.refresh);
                  },
                ),
              ],
              dataColumns: GroupDataTableSource.colGen(_dtSource, _provider),
              header: TextField(
                onChanged: (value) {
                  _provider.onSearchTextChanged(value);
                },
                decoration:
                InputDecoration(hintText: "Search Name", labelText: "Search"),
              ),
              onRowChanged: (index) => _provider.rowsPerPage = index!,
              rowsPerPage: _provider.rowsPerPage,
              showActions: true,
              source: _dtSource,
              sortColumnIndex: _provider.sortColumnIndex,
              sortColumnAsc: _provider.sortAscending,
            ),
          ],
        ),
      ),
    );
  }
}

