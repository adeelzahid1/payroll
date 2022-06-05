import 'package:flutter/material.dart';
import 'package:network/models/theme/ThemeProvider.dart';
import 'package:payroll/modals/ViewAttendanceGrid.dart';
import 'package:payroll/routes/PayRollAppPagesConstants.dart';
import 'package:payroll/screens/viewAttendance/addViewAttendance/AddViewAttendanceDataNotifier.dart';
import 'package:payroll/screens/viewAttendance/dataTableSource/ViewAttendanceDataTableSource.dart';
import 'package:payroll/utils/AppUtiles.dart';
import 'package:payroll/widgets/DataTable/CustomPaginatedTable.dart';
import 'package:payroll/widgets/boxDecoration/BoxDecorationShadowCircle.dart';
import 'package:provider/provider.dart';

class ViewAttendanceGridScreen extends StatefulWidget {
  AddViewAttendanceDataNotifier? provider;

  ViewAttendanceGridScreen({Key? key, this.provider}) : super(key: key);

  @override
  _ViewAttendanceGridScreenState createState() => _ViewAttendanceGridScreenState();
}

class _ViewAttendanceGridScreenState extends State<ViewAttendanceGridScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Attendance List Widget Created");
    final themeProvider = Provider.of<ThemeProvider>(context);
    final _dtSource = ViewAttendanceGridDataTableSource(
      attendanceData: widget.provider!.filterGridData,
      onRowSelect: (index) async {
        dynamic result = await Navigator.pushNamed(
            context, PayRollAppPagesConstants.viewAttendanceGridScreen, arguments: widget.provider!.filterGridData[index].employeeId);

        if (result != null) {
          ViewAttendanceGrid updatedViewAttendanceGrid = result as ViewAttendanceGrid;
          // _provider.addUpdateViewAttendanceGrid(updatedViewAttendanceGrid, false);
        }
      },
      onDelete: (int index) {
        AppUtiles.showDialogBoxSingleAction(
          context: context,
          title: "Confirmation",
          content: "Are you sure you want to Reject this request.",
          btnText: "Reject",
          function: () {
            print("reject click");
          },
        );
      },
    );

    return Scaffold(

      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecorationShadowRectangle(),
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
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
            dataColumns: ViewAttendanceGridDataTableSource.colGen(_dtSource, widget.provider!),
            header: TextField(
              onChanged: (value) {
                widget.provider!.onSearchTextChanged(value);
              },
              decoration:
              InputDecoration(hintText: "Search Name", labelText: "Search"),
            ),
            onRowChanged: (index) => widget.provider!.rowsPerPage = index!,
            rowsPerPage: widget.provider!.rowsPerPage,
            //rowsPerPage: 20,
             showActions: true,
            source: _dtSource,
            sortColumnIndex: widget.provider!.sortColumnIndex,
            sortColumnAsc: widget.provider!.sortAscending,
          ),
        ),
      ),

    );
  }
}
