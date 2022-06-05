// import 'package:flutter/material.dart';
// import 'package:network/models/theme/ThemeProvider.dart';
// import 'package:payroll/routes/PayRollAppPagesConstants.dart';
// import 'package:payroll/utils/AppLevelConstants.dart';
// import 'package:provider/provider.dart';
//
// class MainScreenPayroll extends StatelessWidget {
//   const MainScreenPayroll({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: ()async {
//           dynamic result = await Navigator.pushNamed(context,
//            //   PayRollAppPagesConstants.groupRightsRoute  //valid
//              // PayRollAppPagesConstants.usersRoute   //valid
//               PayRollAppPagesConstants.createGroupRoute //valid
//           );
//           print("Click Floating Action button");
//         },
//
//         child: const Icon(Icons.assistant_navigation),
//       ),
//
//       body: SafeArea(
//           child: Container(
//               padding: EdgeInsets.all(30),
//               child: Column(
//                 children: [
//                   Text("Pay Roll page main Screen", style: TextStyle(color: themeProvider.themeMode().textColor),),
//                   Text("Pay Roll page main Screen", style: TextStyle(color: themeProvider.themeMode().textHeadingColor),),
//                 ],
//               ))),
//     );
//   }
// }

//==========================================================
//==========================================================
//==========================================================
//==========================================================
//==========================================================
//==========================================================
//==========================================================

import 'package:flutter/material.dart';
import 'package:network/SharedPrefManager.dart';
import 'package:payroll/modals/widgets/DropDownValue.dart';
import 'package:payroll/routes/PayRollAppPagesConstants.dart';
import 'package:payroll/values/AppColors.dart';
import 'package:payroll/widgets/DropDown/CustomDropDownFormField.dart';

void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: MainScreenPayroll(),
  ));
}

class MainScreenPayroll extends StatelessWidget {

  String? _selectedLeaveItem;
  String? _selectedLeaveItem3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
            ),
            onPressed: () {
              SharedPrefManagerUser.getInstance().then((value){
                value?.saveUser(null);
                Navigator.pushReplacementNamed(context, PayRollAppPagesConstants.splashPayRollPageRoute);
              });
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Text("Logout"),
        onPressed: () {
          print("logout");
          SharedPrefManagerUser.getInstance().then((value){
            value?.saveUser(null);
            Navigator.pushReplacementNamed(context, PayRollAppPagesConstants.splashPayRollPageRoute);
          });
        },

      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        //width: MediaQuery.of(context).size.width / 1.2,
        color: Colors.greenAccent,
        child: Column(


          children: <Widget>[
            DropdownButton(
              value: _selectedLeaveItem,
              items: _dropDownItem(),
              onChanged: (String? value) {
                _selectedLeaveItem = value!;
                switch (value) {
                  case "Create_Group" :
                    Navigator.pushNamed(
                        context, PayRollAppPagesConstants.createGroupRoute);
                    break;

                  case "Group_Rights" :
                    Navigator.pushNamed(
                        context, PayRollAppPagesConstants.groupRightsRoute);
                    break;

                  case "Users" :
                    Navigator.pushNamed(
                        context, PayRollAppPagesConstants.usersRoute);
                    break;

                  case "AddLeave" :
                    Navigator.pushNamed(
                        context, PayRollAppPagesConstants.leaveTypeScreen);
                    break;
                }
              },
              hint: Text('Select an Option'),
            ),
            SizedBox(height: 30.0),

            // ========= Leave Dropdown
             CustomDropdownFormField(
               selectedValue:  _selectedLeaveItem,
              DropDownValuesList: leaveDDList(),
              onChanged: (value) {
                _selectedLeaveItem = value!.value;
                switch (_selectedLeaveItem) {
                  case "AddLeave" :
                    Navigator.pushNamed(
                        context, PayRollAppPagesConstants.leaveTypeScreen);
                    break;

                  case "LeaveApplication":
                    Navigator.pushNamed(
                        context, PayRollAppPagesConstants.addLeaveApplicationWidget);
                    break;

                  case "LeaveGridView":
                    Navigator.pushNamed(
                        context, PayRollAppPagesConstants.leaveApplicationScreen);
                    break;

                    case "leaveBalance":
                    Navigator.pushNamed(
                        context, PayRollAppPagesConstants.leaveBalanceViewWidget);
                    break;



                }
              },
            ),

            // ======== Attendance DROPDOWN 2
            CustomDropdownFormField(
              selectedValue:  _selectedLeaveItem3,
              DropDownValuesList: leaveDDList2(),
              onChanged: (value) {
                _selectedLeaveItem3 = value!.value;
                switch (_selectedLeaveItem3) {
                  case "InAttendance" :
                    Navigator.pushNamed(
                        context, PayRollAppPagesConstants.addAttendanceInOutWidget);
                    break;

                  case "viewAttendance":
                    Navigator.pushNamed(
                        context, PayRollAppPagesConstants.addViewAttendanceWidget);
                    break;
                }
              },
            ),

            // ======== Attendance DROPDOWN 3 (Roles and Roles Modify)
            CustomDropdownFormField(
              selectedValue:  _selectedLeaveItem3,
              DropDownValuesList: roleClaimsDDL(),
              onChanged: (value) {
                _selectedLeaveItem3 = value!.value;
                switch (_selectedLeaveItem3) {
                  case "assignRole" :
                    Navigator.pushNamed(
                        context, PayRollAppPagesConstants.assignRoleWidget);
                    break;

                  case "rolesModify":
                    Navigator.pushNamed(
                        context, PayRollAppPagesConstants.addViewAttendanceWidget);
                    break;
                }
              },
            ),



          ],
        ),
      ),
    );
  }


  List<DropdownMenuItem<String>> _dropDownItem() {
    List<String> ddl = ["Create_Group", "Group_Rights", "Users"];
    return ddl.map(
            (value) => DropdownMenuItem(value: value, child: Text(value),))
        .toList();
  }



  List<DropDownVal> leaveDDList(){
    List<DropDownVal> leaveDDList = [
      DropDownVal(name: "Leave Dropdown", value: "-1"),
      DropDownVal(name: "AddLeave", value: "AddLeave"),
      DropDownVal(name: "LeaveApplication", value: "LeaveApplication"),
      DropDownVal(name: "LeaveGridView", value: "LeaveGridView"),
      DropDownVal(name: "Leave Balance", value: "leaveBalance"),
    ];
    return leaveDDList.map((e) => DropDownVal(name: e.name, value: e.value)  ).toList();
  }

  List<DropDownVal> leaveDDList2(){
    List<DropDownVal> leaveDDList2 = [
      DropDownVal(name: "ATTENDANCE ", value: "-1"),
      DropDownVal(name: "InAttendance", value: "InAttendance"),
      DropDownVal(name: "View Attendance", value: "viewAttendance"),
    ];
    return leaveDDList2.map((e) => DropDownVal(name: e.name, value: e.value)  ).toList();
  }

  List<DropDownVal> roleClaimsDDL(){
    List<DropDownVal> leaveDDList3 = [
      DropDownVal(name: "Roles&Claim ", value: "-1"),
      DropDownVal(name: "Assign Role", value: "assignRole"),
      DropDownVal(name: "Roles Modify", value: "rolesModify"),
    ];
    return leaveDDList3.map((e) => DropDownVal(name: e.name, value: e.value)  ).toList();
  }

}


//  ==========================================================
//  ==========================================================
//  ==========================================================
//  ==========================================================
//  ==========================================================
//  ==========================================================
//  ==========================================================
//  ==========================================================
//  ==========================================================


