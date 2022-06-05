import 'package:flutter/material.dart';
import 'package:network/models/theme/ThemeProvider.dart';
import 'package:payroll/modals/enum/CallState.dart';
import 'package:payroll/modals/widgets/DropDownValue.dart';
import 'package:payroll/routes/PayRollAppPagesConstants.dart';
import 'package:payroll/screens/assignRole/AssignRoleDataNotifier.dart';
import 'package:payroll/utils/AppUtiles.dart';
import 'package:payroll/widgets/DropDown/CustomDropDownFormField.dart';
import 'package:payroll/widgets/TextField/TextFormFieldWidget.dart';
import 'package:payroll/widgets/buttons/CustomRaisedButton.dart';
import 'package:payroll/widgets/datePicker/CustomDatePicker.dart';
import 'package:payroll/widgets/datePicker/CustomDatePickerInputField.dart';
import 'package:payroll/widgets/progressbarAndError/ErrorText.dart';
import 'package:payroll/widgets/progressbarAndError/ProgressBar.dart';
import 'package:payroll/widgets/texts/CustomTextSL.dart';
import 'package:provider/provider.dart';

String? roleId = null;

class AssignRoleWidget extends StatelessWidget {
  const AssignRoleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    roleId = null;
    Object? roleObject = ModalRoute.of(context)!.settings.arguments;
    if (roleObject != null) {
      roleId = roleObject as String?;
    }
    return SafeArea(
      child: ChangeNotifierProvider<AssignRoleDataNotifier>(
        create: (_) => AssignRoleDataNotifier(roleId),
        child: AddLeaveApplication(),
      ),
    );
  }
}

class AddLeaveApplication extends StatefulWidget {
  @override
  _AddLeaveApplicationState createState() => _AddLeaveApplicationState();
}

class _AddLeaveApplicationState extends State<AddLeaveApplication> {
  String? text = 'Desktop';
  TextEditingController controllerStartDate = new TextEditingController(text: " ");
  TextEditingController controllerEndDate = new TextEditingController(text: " ");
  @override
  void initState() {
    var s = Provider.of<AssignRoleDataNotifier>(context, listen: false);
    s.getAllRolesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AssignRoleDataNotifier assignRoleVM = context.watch<AssignRoleDataNotifier>();

    final themeProvider = Provider.of<ThemeProvider>(context);

    double width = MediaQuery.of(context).size.width * 20 / 100;
    double horizontalSize = 0.0;

    return Scaffold(
      appBar: AppBar(
        title: CustomTextSL(
          text: roleId == null ? "Assign Role" : "Update Assign Role",
          color: themeProvider.themeMode().textColorOnPrimary, size: 20.0,
        ),
        leading: InkWell(
            child: Icon(Icons.arrow_back),
            onTap: () {
              Navigator.pushReplacementNamed(context, PayRollAppPagesConstants.mainScreenPayRoll);
            }),
      ),
      body: SingleChildScrollView(
        child: Builder(
          builder: (BuildContext context) {
            Widget widget;

            switch (assignRoleVM.callState) {
              case CallState.loading:
                widget = ProgressBar();
                break;
              case CallState.failed:
                widget = ErrorText(
                  function: () {assignRoleVM.fetchData(roleId);},
                );
                break;
              case CallState.data:
                widget = GestureDetector(
                  onTap: (){FocusScope.of(context).unfocus();},

                  child: LayoutBuilder(
                    builder: (context, constraints){
                      MediaQuery.of(context).size.width >= 821 ? horizontalSize = 170 : horizontalSize = 10;
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: horizontalSize),
                        //padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 25),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                color: themeProvider.themeMode().textColor,
                                blurRadius: 6.0,
                                offset: Offset(0.0, 2.0),
                              )
                            ]
                        ),
                        child: Column(
                          children: [

                            headerBar(themeProvider, context),
                            SizedBox(height: 10.0),


                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
                              child: Form(
                                key: assignRoleVM.formKey,
                                autovalidate: assignRoleVM.autoValidate,
                                child: Column(
                                  children: [
                                    // /========================= Dropdown List of User Roles  ===========================
                                    SizedBox(height: 10),
                                    CustomDropdownFormField(
                                      label: "Choose Role ",
                                      DropDownValuesList: assignRoleVM.rolesDDList,
                                      onChanged: (DropDownVal? value) => assignRoleVM.onSaveRoleId(value),
                                      selectedValue: assignRoleVM.roleModel.id,
                                      validate: assignRoleVM.validateRoleDDL,
                                    ),
                                    SizedBox(height: 15.0),

                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () {
                                          print("goto Advance/modify claims page");
                                        },
                                        child: CustomTextSL(
                                          text: 'Advance  / Modify',
                                          color: Colors.blue,
                                          size: 17.0,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1.0,
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 30),
                                    submitBtn(context, assignRoleVM, themeProvider),
                                    SizedBox(height: 20),
                                    //  SizedBox(height: 30),
                                    // Container(height: 800, child:  LeaveTypeScreen(),),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
                break;
            }

            return widget;
          },
        ),
      ),
    );
  }
}

// /========= Submit Button ============
Widget submitBtn(BuildContext context, AssignRoleDataNotifier rolevm, ThemeProvider themeProvider ) {
  return Center(
    child: Container(
      width: MediaQuery.of(context).size.width * 50 / 100,
      decoration: BoxDecoration(
        //color: themeProvider.themeMode().primaryColor,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: CustomRaisedButton(
        color: themeProvider.themeMode().primaryColor,
        onPress: () {
          print("BUTTON CLICK");
          if (rolevm.formKey.currentState!.validate()) {
            rolevm.formKey.currentState!.save();

            /// Add UserRole
            if (roleId == null) {
              rolevm.submit().then((value) {
                if (!value.error) {
                  AppUtiles.showSnackBar(
                      context, "Roles Added Successfully.");
                  Navigator.pop(context, value.data);
                }
                else {
                  AppUtiles.showSnackBar(context, "Error.");
                }
              });
            } else {
              // Update EmployeeDepartment
              // rolevm.update().then((value) {
              //   if (!value.error) {
              //     AppUtiles.showSnackBar(
              //         context, "Roles Updated Successfully.");
              //     Navigator.pop(context, rolevm.roleModel);
              //   } else {
              //     AppUtiles.showSnackBar(context, "Error.");
              //   }
              // });
            }
          }
          else{
            rolevm.autoValidate = true;
            AppUtiles.showSnackBar(context, "Validation Error.");
          }
        },
        child: CustomTextSL(
          text: roleId == null ? "Save" : "Update",
          letterSpacing: 1.5,
          color: Colors.white,
          size: 18.0,
        ),
      ),
    ),
  );
}

// /========= Header Top Bar ============
Widget headerBar(ThemeProvider themeProvider, BuildContext context){
  return Container(
    height: 50.0,
    width: double.infinity,
    decoration: BoxDecoration(
      //color: themeProvider.themeData().primaryColor,
        color: themeProvider.themeMode().primaryColor,

        borderRadius: BorderRadius.only( topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0), ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6.0,
            offset: Offset(0.0, 2.0),
          )
        ]),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: InkWell(
              child: Icon(Icons.arrow_back,
                color: themeProvider.themeMode().textColorOnPrimary,),
              onTap: ()=>Navigator.pop(context),
          ),
        ),
        CustomTextSL(
          text: "Assign Role", size: 22.0,
          color: themeProvider.themeMode().textColorOnPrimary,
          letterSpacing: 1.2,
        ),
        Text(""),
      ],
    ),
  );
}
