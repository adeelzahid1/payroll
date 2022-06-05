import 'package:flutter/material.dart';
import 'package:network/SharedPrefManager.dart';
import 'package:network/models/theme/ThemeProvider.dart';
import 'package:network/models/user.dart';
import 'package:payroll/screens/leaveBalance/LeaveBalanceViewDataNotifier.dart';
import 'package:payroll/screens/leaveBalance/grid/LeaveStatus.dart';
import 'package:payroll/utils/AppUtiles.dart';
import 'package:payroll/widgets/texts/CustomTextSL.dart';
import 'package:provider/provider.dart';

Color primaryColor = Color(0xFF2697FF);
Color secondaryColor = Color(0xFF2A2D3E);
Color bgColor = Color(0xFF212332);
double defaultPadding = 16.0;

class LeaveStatusGrid extends StatelessWidget {
  User? user = User();
  LeaveStatusGrid({Key? key}) : super(key: key);
  void getUser(){
    SharedPrefManagerUser.getInstance().then((value){
      if(value!=null){
        user = value.getUser();
        print("USER IS: ${user?.id}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    getUser();
  return SafeArea(
      child: ChangeNotifierProvider<LeaveBalanceViewDataNotifier>(
        create: (_) => LeaveBalanceViewDataNotifier(null),
        child: _internalWidget(),
      ),
  );
  }
}

class _internalWidget extends StatefulWidget {
  @override
  __internalWidgetState createState() => __internalWidgetState();
}

class __internalWidgetState extends State<_internalWidget> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    LeaveBalanceViewDataNotifier _provider = context.watch<LeaveBalanceViewDataNotifier>();

    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
          color: themeProvider.themeMode().textColorOnPrimary,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: themeProvider.themeMode().textColor,
              blurRadius: 6.0,
              offset: Offset(0.0, 2.0),
            )
          ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Leave Balance Status",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Container(
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: AppUtiles.getWidth(context) <400 ? Axis.horizontal : Axis.vertical,
              child: DataTable(
                horizontalMargin: 0,
                columnSpacing: defaultPadding,
                columns: [
                  DataColumn(
                    label: CustomTextSL(text: "Category", fontWeight: FontWeight.w700,),
                  ),
                  DataColumn(
                    label: CustomTextSL(text: "Total", fontWeight: FontWeight.w700,),
                  ),
                  DataColumn(
                    label: CustomTextSL(text: "Availed", fontWeight: FontWeight.w700,),
                  ),
                  DataColumn(
                    label: CustomTextSL(text: "Balance", fontWeight: FontWeight.w700,),
                  ),
                ],
                rows: List.generate(
                  _provider.demoLeaveStatus.length,
                      (index) => recentFileDataRow(_provider.demoLeaveStatus[index]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


DataRow recentFileDataRow(LeaveStatus leaveStatus) {
  return DataRow(
    //onSelectChanged: (_) => print("${leaveStatus.name!}"),
    cells: [
      DataCell(Text(leaveStatus.name!),),
      DataCell(Text(leaveStatus.leaves!)),
      DataCell(Text(leaveStatus.availed!)),
      DataCell(Text(leaveStatus.balance!)),
    ],
  );
}
