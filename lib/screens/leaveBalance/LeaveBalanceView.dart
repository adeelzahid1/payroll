import 'package:flutter/material.dart';
import 'package:network/models/theme/ThemeProvider.dart';
import 'package:payroll/modals/enum/CallState.dart';
import 'package:payroll/modals/widgets/DropDownValue.dart';
import 'package:payroll/routes/PayRollAppPagesConstants.dart';
import 'package:payroll/screens/leaveBalance/LeaveBalanceViewDataNotifier.dart';
import 'package:payroll/screens/leaveBalance/grid/LeaveStatusGrid.dart';
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

int? leaveBalanceId = null;

class AddLeaveBalanceViewWidget extends StatelessWidget {
  const AddLeaveBalanceViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    leaveBalanceId = null;
    Object? leaveAppObject = ModalRoute.of(context)!.settings.arguments;
    // if (leaveAppObject != null) {
    //   leaveBalanceId = leaveAppObject as int?;
    // }
    return SafeArea(
      child: ChangeNotifierProvider<LeaveBalanceViewDataNotifier>(
        // create: (_) => LeaveBalanceViewDataNotifier(leaveBalanceId),
        create: (_) => LeaveBalanceViewDataNotifier(null),
        child: AddLeaveBalanceView(),
      ),
    );
  }
}

class AddLeaveBalanceView extends StatefulWidget {
  @override
  _AddLeaveBalanceViewState createState() => _AddLeaveBalanceViewState();
}

class _AddLeaveBalanceViewState extends State<AddLeaveBalanceView> {
  String? text = 'Desktop';

  @override
  void initState() {
    var s = Provider.of<LeaveBalanceViewDataNotifier>(context, listen: false);
    s.getUserNameIdList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LeaveBalanceViewDataNotifier leaveAppVM = context.watch<LeaveBalanceViewDataNotifier>();
    final themeProvider = Provider.of<ThemeProvider>(context);

    double width = MediaQuery.of(context).size.width * 20 / 100;
    double horizontalSize = 0.0;

    return Scaffold(
      appBar: AppBar(
        title: CustomTextSL(
          text: leaveBalanceId == null ? "Leave Balance" : "Update Leave Balance",
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
                  function: () {leaveAppVM.fetchData(leaveBalanceId);},
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

                                    Visibility(
                                      visible: leaveBalanceId == null ? false :true,
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
                                        ],
                                      ),
                                    ),


                                    Visibility(
                                      visible: leaveBalanceId != null ? false : true,
                                      child: Column(
                                        children: [
                                          // /========================= Dropdown List of UserName and ID ========================
                                          SizedBox(height: 20),
                                          CustomDropdownFormField(
                                            label: "Employee Name",
                                            DropDownValuesList: leaveAppVM.userNameDDList,
                                            onChanged: (DropDownVal? value) => leaveAppVM.onSaveUserNameId(value),
                                            selectedValue: leaveAppVM.leaveBalanceModal.employeeId,
                                            validate: leaveAppVM.validateUserNameIdDDL,
                                          ),

                                          // /========================= Dropdown List of UserName and ID ========================
                                          SizedBox(height: 20),
                                          CustomDropdownFormField(
                                            label: "Employee ID",
                                            DropDownValuesList: leaveAppVM.userIdDDList,
                                            onChanged: (DropDownVal? value) => leaveAppVM.onSaveUserNameId(value),
                                            // onChanged: (DropDownVal? value) => print("hello g"),
                                            selectedValue: leaveAppVM.leaveBalanceModal.employeeId,
                                            validate: leaveAppVM.validateUserNameIdDDL,
                                          ),
                                        ],
                                      ),
                                    ),

                                    //=====================================================
                                    //=====================================================
                                    //=====================================================
                                    //=====================================================
                                    //=====================================================
                                    //=====================================================





                                   // ======================================
                                    // ======================================
                                    // ======================================
                                    // ======================================
                                    // ======================================
                                    // ======================================
                                    // ======================================



                                    leavesData(themeProvider),
                                    SizedBox(height: 20),
                                    LeaveStatusGrid(),


                                    // /========================= Reason Multiline Field  ===========================
                                    // SizedBox(height: 20),
                                    // TextFormFieldWidget(
                                    //   label: 'Reason',
                                    //   hint: "Reason",
                                    //   maxLength: 300,
                                    //   initalVal: leaveAppVM.leaveBalanceModal.employeeName ?? "",
                                    //   textInputType: TextInputType.text,
                                    //   validate: leaveAppVM.validateReason,
                                    //   onSave: (String? str) {
                                    //     leaveAppVM.leaveBalanceModal.employeeName = str ?? "null"; //Todo :: check it after design implementation
                                    //   },
                                    // ),

                                    // /========================= Accept and Reject Button  ===========================
                                    // SizedBox(height: 20),
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.center,
                                    //   children: [
                                    //     clickAbleButton(
                                    //       color: themeProvider.themeMode().darkGreenColor,
                                    //       text: 'Accept',
                                    //       height: 45.0,
                                    //       width: 300,
                                    //       onTap: () {print("Accept button click");}
                                    //
                                    //     ),
                                    //     SizedBox(width: 20.0),
                                    //   ],
                                    // ),





                                    SizedBox(height: 30),
                                    //submitBtn(context, leaveAppVM, themeProvider),
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
Widget submitBtn(BuildContext context, LeaveBalanceViewDataNotifier leaveTypeVM, ThemeProvider themeProvider ) {
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

            if (leaveBalanceId == null) {
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
            }
          }
          else{
            leaveTypeVM.autoValidate = true;
            AppUtiles.showSnackBar(context, "Validation Error.");
          }
        },
        child: CustomTextSL(
          text: leaveBalanceId == null ? "Save" : "Update",
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
      text: "Leave Balance", size: 24.0,
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

Widget leavesData(ThemeProvider themeProvider){
  return Container(
    width: 500,
    margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
    padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 25),
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
        SizedBox(height: 10),
        Row(
          children: [
            CustomTextSL(text: "Designation : ", fontWeight: FontWeight.w700, letterSpacing: 1.2,),
            CustomTextSL(text: "Manager", letterSpacing: 1.2,),
          ],
        ),

        SizedBox(height: 10),
        Row(
          children: [
            CustomTextSL(text: "Total Leaves : ", fontWeight: FontWeight.w700, letterSpacing: 1.2,),
            CustomTextSL(text: "30", letterSpacing: 1.2,),
          ],
        ),

        SizedBox(height: 10),
        Row(
          children: [
            CustomTextSL(text: "Availed :        ", fontWeight: FontWeight.w700, letterSpacing: 1.2,),
            CustomTextSL(text: "10", letterSpacing: 1.2,),
          ],
        ),

        SizedBox(height: 10),
        Row(
          children: [
            CustomTextSL(text: "Remaining :   ", fontWeight: FontWeight.w700, letterSpacing: 1.2,),
            CustomTextSL(text: "20", letterSpacing: 1.2,),
          ],
        ),
      ],
    ),
  );
}
