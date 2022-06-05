import 'package:flutter/material.dart';
import 'package:network/SharedPrefManager.dart';
import 'package:network/models/theme/ThemeProvider.dart';
import 'package:network/models/user.dart';
import 'package:payroll/modals/enum/CallState.dart';
import 'package:payroll/routes/PayRollAppPagesConstants.dart';
import 'package:payroll/screens/leaveType/LeaveTypeList.dart';
import 'package:payroll/screens/leaveType/addLeaveType/AddLeaveTypeDataNotifier.dart';
import 'package:payroll/utils/AppUtiles.dart';
import 'package:payroll/widgets/TextField/TextFormFieldWidget.dart';
import 'package:payroll/widgets/buttons/CustomRaisedButton.dart';
import 'package:payroll/widgets/progressbarAndError/ErrorText.dart';
import 'package:payroll/widgets/progressbarAndError/ProgressBar.dart';
import 'package:payroll/widgets/texts/CustomTextSL.dart';
import 'package:provider/provider.dart';

int? leaveTypeId = null;

class AddLeaveTypeWidget extends StatelessWidget {
  User? user = User();
  AddLeaveTypeWidget({Key? key}) : super(key: key);
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
    leaveTypeId = null;
    getUser();
    Object? leaveTypeObject = ModalRoute.of(context)!.settings.arguments;
    if (leaveTypeObject != null) {
      leaveTypeId = leaveTypeObject as int?;
    }
    return SafeArea(
      child: ChangeNotifierProvider<AddLeaveTypeDataNotifier>(
        create: (_) => AddLeaveTypeDataNotifier(leaveTypeId),
        child: AddLeaveType(),
      ),
    );
  }
}

class AddLeaveType extends StatefulWidget {
  @override
  _AddLeaveTypeState createState() => _AddLeaveTypeState();
}

class _AddLeaveTypeState extends State<AddLeaveType> {
  String? text = 'Desktop';

  @override
  Widget build(BuildContext context) {
    AddLeaveTypeDataNotifier leaveTypeVM = context.watch<AddLeaveTypeDataNotifier>();
    final themeProvider = Provider.of<ThemeProvider>(context);

    double width = MediaQuery.of(context).size.width * 20 / 100;

    return Scaffold(
      appBar: AppBar(
        title: Text(leaveTypeId == null ? "Add Leave Quota" : "Update Leave Quota"),
        leading: InkWell(
            child: Icon(Icons.arrow_back),
            onTap: () {
              Navigator.pushReplacementNamed(context,
                  PayRollAppPagesConstants.mainScreenPayRoll);
            }),
      ),
      body: SingleChildScrollView(
        child: Builder(
          builder: (BuildContext context) {
            Widget widget;

            switch (leaveTypeVM.callState) {
              case CallState.loading:
                widget = ProgressBar();
                break;
              case CallState.failed:
                widget = ErrorText(
                  function: () {
                    leaveTypeVM.fetchData(leaveTypeId);
                  },
                );
                break;
              case CallState.data:
                widget = GestureDetector(
                  onTap: (){FocusScope.of(context).unfocus();},
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: width),
                    padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 25),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6.0,
                            offset: Offset(0.0, 2.0),
                          )
                        ]),
                    child: Form(
                      key: leaveTypeVM.formKey,
                      autovalidate: leaveTypeVM.autoValidate,
                      child: Column(
                        children: [
                          // /========================= Leave Type Name ===========================
                          SizedBox(height: 20),
                          TextFormFieldWidget(
                            label: 'Leave Type Name',
                            initalVal: leaveTypeVM.leaveTypeModel.name ?? "",
                            validate: leaveTypeVM.validateName,
                            onSave: (String? str) {
                              leaveTypeVM.leaveTypeModel.name = str;
                            },
                          ),

                          // /========================= No Of Leaves ===========================
                          SizedBox(height: 20),
                          TextFormFieldWidget(
                            label: 'No of Leaves',
                            initalVal: leaveTypeVM.leaveTypeModel.numberOfLeaves?.toString() ?? "",
                            textInputType: TextInputType.number,
                            validate: leaveTypeVM.validateNumberLeaves,
                            onSave: (String? str) {
                              leaveTypeVM.leaveTypeModel.numberOfLeaves = int.tryParse(str!);
                            },
                          ),
                          SizedBox(height: 20,),




                          SizedBox(height: 30),
                          submitBtn(context, leaveTypeVM, themeProvider),
                         //  SizedBox(height: 30),
                         // Container(height: 800, child:  LeaveTypeScreen(),),
                        ],
                      ),
                    ),
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
Widget submitBtn(BuildContext context, AddLeaveTypeDataNotifier leaveTypeVM, ThemeProvider themeProvider ) {
  return Center(
    child: Container(
      width: MediaQuery.of(context).size.width * 25 / 100,
      decoration: BoxDecoration(
        // color: Theme.of(context).primaryColor,
      ),
      child: CustomRaisedButton(
        color: themeProvider.themeMode().primaryColor,
        onPress: () {
          if (leaveTypeVM.formKey.currentState!.validate()) {
            leaveTypeVM.formKey.currentState!.save();

            /// Add EmployeeDepartment
            if (leaveTypeId == null) {
              leaveTypeVM.submit().then((value) {
                if (!value.error) {
                  AppUtiles.showSnackBar(
                      context, "Leave Type Added Successfully.");
                  Navigator.pop(context, value.data);
                } else {
                  AppUtiles.showSnackBar(context, "Error.");
                }
              });
            } else {
              // Update EmployeeDepartment
              leaveTypeVM.update().then((value) {
                if (!value.error) {
                  AppUtiles.showSnackBar(
                      context, "Leave Type Updated Successfully.");
                  Navigator.pop(context, leaveTypeVM.leaveTypeModel);
                } else {
                  AppUtiles.showSnackBar(context, "Error.");
                }
              });
            }
          }
          else{
            leaveTypeVM.autoValidate = true;
            AppUtiles.showSnackBar(context, "Validation Error.");
          }
        },
        child: CustomTextSL(
          text: leaveTypeId == null ? "Save" : "Update",
          letterSpacing: 1.5,
          color: Colors.white,
        ),
      ),
    ),
  );
}
