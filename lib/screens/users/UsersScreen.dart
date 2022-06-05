import 'package:flutter/material.dart';
import 'package:payroll/modals/User.dart';
import 'UserDataNotifier.dart';
import 'package:payroll/utils/AppLevelConstants.dart';
import 'package:payroll/utils/AppUtiles.dart';
import 'package:payroll/widgets/DataTable/CustomPaginatedTable.dart';
import 'package:payroll/widgets/boxDecoration/BoxDecorationShadowCircle.dart';
import 'package:provider/provider.dart';
import 'dataTableSource/UserDataTableSource.dart';

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
      body: ChangeNotifierProvider<UserDataNotifier>(
        create: (_) => UserDataNotifier(),
        child: _InternalWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add User",
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          dynamic result = await Navigator.pushNamed(
              context, AppLevelConstants.createUserRoute);

          if (result != null) {
            User updatedUser = result as User;
            _provider.addUpdteUser(updatedUser, false);
          }
        },
      ),
    );
  }
}

late UserDataNotifier _provider;

class _InternalWidget extends StatefulWidget {
  @override
  __InternalWidgetState createState() => __InternalWidgetState();
}

class __InternalWidgetState extends State<_InternalWidget> {
  @override
  Widget build(BuildContext context) {
    _provider = context.watch<UserDataNotifier>();
    List<User> _model = _provider.filterData;

    final _dtSource = UserDataTableSource(
      userData: _model,
      onRowSelect: (index) async {
        dynamic result = await Navigator.pushNamed(
            context, AppLevelConstants.createUserRoute,
            arguments: _model[index]);
        if (result != null) {
          User updatedUser = result as User;
          _provider.addUpdteUser(updatedUser, true);
        }
      },
      onDelete: (int index) {
        AppUtiles.showDialogBoxSingleAction(
          context: context,
          title: "Confirmation",
          content: "Are you sure you want to delete",
          btnText: "Delete",
          function: () {
            _provider.deleteUser(_model[index]);
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
          dataColumns: UserDataTableSource.colGen(_dtSource, _provider),
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
      ),
    );
  }
}
