import 'package:flutter/material.dart';
import 'package:payroll/modals/GroupCategoryRights.dart';
import 'GroupCategoryRightNotifier.dart';
import 'package:payroll/widgets/DataTable/CustomPaginatedTable.dart';
import 'package:provider/provider.dart';

import 'dataTableSource/GroupReportDataTableSource.dart';

class GroupReportScreen extends StatelessWidget {
  List<GroupCategoryRights>  data;
  GroupReportScreen(this.data);


  Map<String, String> columnNames =new Map();
  List<GroupCategoryRights>  values = [];

  void getColumnNames(){

    for(int i=0; i<data.length; i++) {
      if (data[i].children != null) {
        for (int j = 0; j < data[i].children.length; j++){
          List<GroupCategoryRights> listData = data[i].children[j].children;
          values.add(data[i].children[j]);
          if(listData!=null) {
            for (int z = 0; z < listData.length; z++) {
              columnNames[listData[z].title!] = listData[z].title!;
            }
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    getColumnNames();
    return Scaffold(
      body: ChangeNotifierProvider<GroupCategoryRightsNotifier>(
          create:  (_) => GroupCategoryRightsNotifier(values),
          child: ReportInnerWidget(columnNames)),

    );
  }
}



late GroupCategoryRightsNotifier _provider ;   // late initializer
class ReportInnerWidget extends StatelessWidget {

  late List<GroupCategoryRights>  data;

  Map<String, String> columnNames =new Map();
  ReportInnerWidget(this.columnNames);

  @override
  Widget build(BuildContext context) {
    _provider = context.watch<GroupCategoryRightsNotifier>();
    data = _provider.filterData;
    final _dtSource = GroupReportDataTableSource(
      groupData: data,
      columnData: columnNames, onDelete: (int index) {  }, onRowSelect: (int index) {  },
    );


    return Scaffold(
      appBar: AppBar(
        title: Text("Group Report"),
      ),
      body: SingleChildScrollView(
        child: Container(

          child: CustomPaginatedTable(
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
            dataColumns: GroupReportDataTableSource.colGen(columnNames),
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

          ),

        ),
      ),
    );
  }


}
