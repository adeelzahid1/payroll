import 'package:flutter/material.dart';
import 'package:payroll/routes/PayRollAppPagesConstants.dart';
import 'GroupCategoryRightNotifier.dart';
import 'package:payroll/screens/groupType/widgets/GroupRightsSelectionWidget.dart';
import 'package:payroll/screens/groupType/widgets/GroupRightsWidget.dart';
import 'package:payroll/widgets/responsive/Responsive.dart';
import 'package:provider/provider.dart';

class GroupRightsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Group Rights"),
        actions: [
          IconButton(
              onPressed: (){Navigator.pushNamed(context, PayRollAppPagesConstants.groupRightsRoute);},
              icon: Icon(Icons.refresh),
          )
        ],
      ),

      body: SingleChildScrollView(
        child: ChangeNotifierProvider<GroupCategoryRightsNotifier>(
          create:  (_) => GroupCategoryRightsNotifier(null),
          child: Responsive(
            mobile: Column(
              children: [
                GroupRightsWidget(),
                GroupRightsSelectionWidget(),
              ],
            ),
            desktop: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Flexible(flex: 2, child: GroupRightsWidget()),
                Flexible(flex: 3, child: GroupRightsSelectionWidget()),
              ],
            ),
            tablet: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Flexible(flex: 2, child: GroupRightsWidget()),
                Flexible(flex: 3, child: GroupRightsSelectionWidget()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
