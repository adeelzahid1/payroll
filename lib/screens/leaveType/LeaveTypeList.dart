import 'package:flutter/material.dart';
import 'package:network/models/theme/ThemeProvider.dart';
import 'package:payroll/modals/AddLeaveType.dart';
import 'package:payroll/routes/PayRollAppPagesConstants.dart';
import 'package:payroll/screens/leaveType/LeaveTypeDataNotifier.dart';
import 'package:payroll/screens/leaveType/dataTableSource/LeaveTypeDataTableSource.dart';
import 'package:payroll/utils/AppUtiles.dart';
import 'package:payroll/widgets/DataTable/CustomPaginatedTable.dart';
import 'package:payroll/widgets/boxDecoration/BoxDecorationShadowCircle.dart';
import 'package:provider/provider.dart';


class LeaveTypeScreen extends StatefulWidget {
  @override
  _LeaveTypeScreenState createState() => _LeaveTypeScreenState();
}

class _LeaveTypeScreenState extends State<LeaveTypeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Leave Types List"),
        // actions: [
        //   RoundIconButton(icon: Icons.add, onPress: (){}, fillColor: Colors.lightBlue),
        // ],
      ),
      body: ChangeNotifierProvider<LeaveTypeDataNotifier>(
        create: (_) => LeaveTypeDataNotifier(),
        child: _InternalWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: themeProvider.themeData().primaryColor,
        tooltip: "Add Leave Type",
        child: Icon(Icons.add, color: themeProvider.themeMode().textColorOnPrimary),
        onPressed: () async {
          dynamic result = await Navigator.pushNamed(
              context, PayRollAppPagesConstants.addLeaveTypeWidget, arguments: null);
          if (result != null) {
            LeaveType updatedLeaveType = result as LeaveType;
            _provider.addUpdateLeaveType(updatedLeaveType, false);
          }
        },
      ),
    );
  }
}

late LeaveTypeDataNotifier _provider;

class _InternalWidget extends StatefulWidget {
  @override
  __InternalWidgetState createState() => __InternalWidgetState();
}

class __InternalWidgetState extends State<_InternalWidget> {
  @override
  Widget build(BuildContext context) {
    _provider = context.watch<LeaveTypeDataNotifier>();
    List<LeaveType> _model = _provider.filterData;

    final _dtSource = LeaveTypeDataTableSource(
      departmentData: _model,
      onRowSelect: (index) async {
        dynamic result = await Navigator.pushNamed(
            context, PayRollAppPagesConstants.addLeaveTypeWidget, arguments: _model[index].id);

        if (result != null) {
          LeaveType updatedLeaveType = result as LeaveType;
          _provider.addUpdateLeaveType(updatedLeaveType, true);
        }
      },
      onDelete: (int index) {
        AppUtiles.showDialogBoxSingleAction(
          context: context,
          title: "Confirmation",
          content: "Are you sure you want to delete",
          btnText: "Delete",
          function: () {
            _provider.deleteItemName(_model[index]).then((value) => {
              if (!value.error)
                { AppUtiles.showSnackBar(context, "${value.data}"), }
              else
                {AppUtiles.showSnackBar(context, "Error.")}
            });
          },
        );
      },
    );

    return SingleChildScrollView(
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
          dataColumns: LeaveTypeDataTableSource.colGen(_dtSource, _provider),
          header: TextField(
            onChanged: (value) {
              _provider.onSearchTextChanged(value);
            },
            decoration:
            InputDecoration(hintText: "Search Name", labelText: "Search"),
          ),
          onRowChanged: (index) => _provider.rowsPerPage = index!,
           rowsPerPage: _provider.rowsPerPage,
          //rowsPerPage: 20,
          showActions: true,
          source: _dtSource,
          sortColumnIndex: _provider.sortColumnIndex,
          sortColumnAsc: _provider.sortAscending,
        ),
      ),
    );
  }
}
