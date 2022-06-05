
import 'package:flutter/material.dart';
import 'package:payroll/modals/Group.dart';
import 'GroupDataNotifier.dart';
import 'package:payroll/screens/createGroup/widgets/CreatGroupWidget.dart';
import 'package:payroll/screens/createGroup/widgets/GroupsListingWidget.dart';
import 'package:provider/provider.dart';


class CreateGroupScreen extends StatefulWidget {
  @override
  _CreateGroupScreenState createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  Group group = new Group();
  GlobalKey<GroupsListingWidgetState> _keyGroupsListingWidget = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // group.id = 200;
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Group"),
      ),
      body: ChangeNotifierProvider<GroupDataNotifier>(
        create: (_) => GroupDataNotifier(),
        child: SingleChildScrollView(
          child: Container(
              child: Column(
            children: [
              CreateGroupWidget(group, (bool isUpdate) {
                group.printGroup();
                _keyGroupsListingWidget.currentState!.updateGroup(group, isUpdate);
                setState(() {
                  group = new Group();
                });

              } ),
              GroupsListingWidget( onItemSelected : (Group mGroup){
                setState(() {
                  group = mGroup;
                });
              } , key: _keyGroupsListingWidget ),
            ],
          )),
        ),
      ),
    );
  }
}
