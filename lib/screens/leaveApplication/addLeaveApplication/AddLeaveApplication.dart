import 'package:flutter/material.dart';
import 'package:network/models/theme/ThemeProvider.dart';
import 'package:payroll/modals/enum/CallState.dart';
import 'package:payroll/modals/widgets/DropDownValue.dart';
import 'package:payroll/routes/PayRollAppPagesConstants.dart';
import 'package:payroll/screens/leaveApplication/addLeaveApplication/AddLeaveApplicationDataNotifier.dart';
import 'package:payroll/screens/leaveType/addLeaveType/AddLeaveTypeDataNotifier.dart';
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

int? leaveApplicationId = null;

class AddLeaveApplicationWidget extends StatelessWidget {
  const AddLeaveApplicationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    leaveApplicationId = null;
    Object? leaveAppObject = ModalRoute.of(context)!.settings.arguments;
    if (leaveAppObject != null) {
      leaveApplicationId = leaveAppObject as int?;
    }
    return SafeArea(
      child: ChangeNotifierProvider<AddLeaveApplicationDataNotifier>(
        create: (_) => AddLeaveApplicationDataNotifier(leaveApplicationId),
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

    var s = Provider.of<AddLeaveApplicationDataNotifier>(context, listen: false);
    s.getLeaveTypeList();
    s.getUserNameIdList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AddLeaveApplicationDataNotifier leaveAppVM = context.watch<AddLeaveApplicationDataNotifier>();
    controllerStartDate.text = leaveAppVM.leaveAppModel.startDate ?? "";
    controllerEndDate.text = leaveAppVM.leaveAppModel.endDate ?? "";
    final themeProvider = Provider.of<ThemeProvider>(context);

    double width = MediaQuery.of(context).size.width * 20 / 100;
    double horizontalSize = 0.0;

    return Scaffold(
      appBar: AppBar(
        title: CustomTextSL(
          text: leaveApplicationId == null ? "Add Leave Application" : "Update Leave Application",
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

            switch (leaveAppVM.callState) {
              case CallState.loading:
                widget = ProgressBar();
                break;
              case CallState.failed:
                widget = ErrorText(
                  function: () {leaveAppVM.fetchData(leaveApplicationId);},
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

                            headerBar(themeProvider),
                            SizedBox(height: 10.0),
                            circleImage(themeProvider),


                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
                              child: Form(
                                key: leaveAppVM.formKey,
                                autovalidate: leaveAppVM.autoValidate,
                                child: Column(
                                  children: [

                                    Row(
                                      children: [
                                        Text("NAME : "),
                                        Column(
                                          children: [
                                            Text("Adeel Zahid", overflow: TextOverflow.ellipsis,),
                                            Container(
                                              margin: new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                                              height: 1.0,
                                              width: 100,
                                              color: themeProvider.themeData().dividerColor,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 50),
                                    Row(
                                      children: [
                                        Text("User ID : "),
                                        Column(
                                          children: [
                                            Text("112233", overflow: TextOverflow.ellipsis),
                                            Container(
                                              margin: new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                                              height: 1.0,
                                              width: 100,
                                              color: themeProvider.themeData().dividerColor,
                                              child:  Text("112233", overflow: TextOverflow.ellipsis),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),


                                    // /========================= Start and End Date  ===========================
                                    SizedBox(height: 20),
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.center,
                                    //   children: [
                                    //     Flexible(
                                    //       child: Container(
                                    //         height: 45.0,
                                    //         width: double.infinity,
                                    //         child: CustomDatePicker(
                                    //           isEnable: true,
                                    //           onDone: (date) => leaveAppVM.onSaveStartLeaveDate(date!),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //     SizedBox(width: 20.0),
                                    //     Flexible(
                                    //       child: Container(
                                    //         height: 45.0,
                                    //         width: double.infinity,
                                    //         child: CustomDatePicker(
                                    //           isEnable: true,
                                    //           onDone: (date) => leaveAppVM.onSavedEndLeaves(date!),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: CustomDatePickerInputField(
                                            hint: "Start Date",
                                            label: "Start Date",
                                            onSave: (date) => leaveAppVM.onSaveStartLeaveDate(date!),
                                            onChange: (date) => {print("On Change Start Date $date"),},
                                            dateController: controllerStartDate,
                                            validate: leaveAppVM.validateStartDate,
                                            isDense: false,
                                          ),
                                        ),
                                        SizedBox(width: 10.0),
                                        Flexible(
                                          child: CustomDatePickerInputField(
                                            hint: "End Date",
                                            label: "End Date",
                                            onSave: (date) => leaveAppVM.onSaveEndLeaveDate(date!),
                                            onChange: (date) => {print("On Change End Date $date"),},
                                            dateController: controllerEndDate,
                                            validate: leaveAppVM.validateEndDate,
                                            isDense: false,
                                          ),
                                        ),
                                      ],
                                    ),


                                    // /========================= Dropdown List of Leave TYPE  ===========================
                                    SizedBox(height: 10),
                                    CustomDropdownFormField(
                                      label: "Leave Type",
                                      DropDownValuesList: leaveAppVM.leaveTypeDDList,
                                      onChanged: (DropDownVal? value) => leaveAppVM.onSaveLeaveTypeId(value),
                                      selectedValue: leaveAppVM.leaveAppModel.leaveTypeId,
                                      validate: leaveAppVM.validateLeaveTypeDDL,
                                    ),

                                    // /========================= Dropdown List of UserName and ID ========================
                                    SizedBox(height: 20),
                                    CustomDropdownFormField(
                                      label: "Employee Name",
                                      DropDownValuesList: leaveAppVM.userIdNameDDList,
                                      onChanged: (DropDownVal? value) => leaveAppVM.onSaveUserNameId(value),
                                      selectedValue: leaveAppVM.leaveAppModel.employeeId,
                                      validate: leaveAppVM.validateUserNameIdDDL,

                                    ),


                                    // /========================= Reason Multiline Field  ===========================
                                    SizedBox(height: 20),
                                    TextFormFieldWidget(
                                      label: 'Reason',
                                      hint: "Reason",
                                      minLine: 3,
                                      maxLines: 5,
                                      maxLength: 300,
                                      initalVal: leaveAppVM.leaveAppModel.reason ?? "",
                                      textInputType: TextInputType.text,
                                      validate: leaveAppVM.validateReason,
                                      onSave: (String? value) => leaveAppVM.onSaveReason(value!),
                                    ),

                                  // /========================= Accept and Reject Button  ===========================
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        clickAbleButton(
                                          color: themeProvider.themeMode().btnPositiveColor,
                                          text: 'Accept',
                                          height: 45.0,
                                          width: 300,
                                          onTap: () {
                                            AppUtiles.showDialogBoxSingleAction(
                                              context: context,
                                              title: "Confirmation",
                                              content: "Are you sure you want to Accept this request.",
                                              btnText: "Accept",
                                              function: () {
                                                // _provider.deleteItemName(_model[index]).then((value) => {
                                                //   if (!value.error)
                                                //   // { AppUtiles.showSnackBar(context, "${value.data}"), }
                                                //     { AppUtiles.showSnackBar(context, "Request Accepted and Removed"), }
                                                //   else
                                                //     {AppUtiles.showSnackBar(context, "Error.")}
                                                // });
                                              },
                                            );



                                          },
                                        ),
                                        SizedBox(width: 20.0),







                                        clickAbleButton(
                                          color: themeProvider.themeMode().btnDeleteBackgroundColor,
                                          text: 'Reject',
                                          height: 45.0,
                                          width: 300,
                                          onTap: () {
                                            print("Reject Button Click");
                                            showDialog(context: context, builder: (context){ return   AlertDialog(
                                              title: Text("Reason"),
                                              content: TextFormFieldWidget(
                                                label: "Rejected Reason",
                                                hint: "Rejected Reason",
                                                minLine: 3,
                                                maxLines: 5,
                                              ),
                                              actions: [
                                                //clickAbleButton(text: 'Reject', onTap: (){}, color: Colors.red,),
                                                CustomRaisedButton(
                                                    child: CustomTextSL(text: "Reject", color: Colors.white, textAlign: TextAlign.center),
                                                    color: themeProvider.themeMode().btnDeleteBackgroundColor,
                                                    onPress: (){print("dialog reject button click");
                                                    Navigator.of(context).pop();
                                                    }),
                                              ],
                                            );});
                                          },
                                        ),
                                      ],
                                    ),





                                    SizedBox(height: 30),
                                    submitBtn(context, leaveAppVM, themeProvider),
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
Widget submitBtn(BuildContext context, AddLeaveApplicationDataNotifier leaveTypeVM, ThemeProvider themeProvider ) {
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
          if (leaveTypeVM.formKey.currentState!.validate()) {
            leaveTypeVM.formKey.currentState!.save();

            /// Add EmployeeDepartment
            if (leaveApplicationId == null) {
              leaveTypeVM.submit().then((value) {
                if (!value.error) {
                  AppUtiles.showSnackBar(
                      context, "Leave Type Added Successfully.");
                  Navigator.pop(context, value.data);
                }
                else {
                  AppUtiles.showSnackBar(context, "Error.");
                }
              });
            } else {
              // Update EmployeeDepartment
              leaveTypeVM.update().then((value) {
                if (!value.error) {
                  AppUtiles.showSnackBar(
                      context, "Leave Type Updated Successfully.");
                  Navigator.pop(context, leaveTypeVM.leaveAppModel);
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
          text: leaveApplicationId == null ? "Save" : "Update",
          letterSpacing: 1.5,
          color: Colors.white,
          size: 18.0,
        ),
      ),
    ),
  );
}

// /========= Header Top Bar ============
Widget headerBar(ThemeProvider themeProvider){
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
    child: Center(child: CustomTextSL(
      text: "Leave Application", size: 24.0,
      color: themeProvider.themeMode().textColorOnPrimary,
      letterSpacing: 1.2,)),
  );
}

// /========= Circle Image ============
Widget circleImage(ThemeProvider themeProvider){
  return                             Container(
    width: 80.0,
    height: 80.0,
    decoration: BoxDecoration(
      color: themeProvider.themeData().accentColor,
      borderRadius: BorderRadius.circular(50.0),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(50.0),
      child: Image.network(
          'https://i.pinimg.com/originals/6b/aa/98/6baa98cc1c3f4d76e989701746e322dd.png'),
    ),
  );
}

// /========= ClickAble Button ============
class clickAbleButton extends StatelessWidget {
  Color? color;
  String text;
  double? height;
  double? padding;
  double? margin;
  VoidCallback? onTap;
  double? width;


  clickAbleButton({Key? key,
    this.color,
    required this.text,
    this.height,
    this.padding,
    this.margin,
    this.onTap,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Flexible(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: InkWell(
          child: Container(
              width: width ?? double.infinity,
              height: height,
              // color: Theme.of(context).primaryColor,
              padding: EdgeInsets.symmetric(horizontal: padding ?? 0.0),
              //margin: EdgeInsets.symmetric(horizontal: 60.0),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10.0),
              ),

              alignment: Alignment.center,
              //margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: CustomTextSL(
                text: text,
                color: Colors.white,
                size: 20.0,
                letterSpacing: 2.0,
              )),

          onTap: onTap,
        ),
      ),
    );
  }
}
