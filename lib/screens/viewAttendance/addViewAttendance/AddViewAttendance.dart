import 'package:flutter/material.dart';
import 'package:network/SharedPrefManager.dart';
import 'package:network/models/theme/ThemeProvider.dart';
import 'package:network/models/user.dart';
import 'package:payroll/modals/enum/CallState.dart';
import 'package:payroll/modals/widgets/DropDownValue.dart';
import 'package:payroll/routes/PayRollAppPagesConstants.dart';
import 'package:payroll/screens/viewAttendance/ViewAttendanceList.dart';
import 'AddViewAttendanceDataNotifier.dart';
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

int? viewAttendanceId = null;

class AddViewAttendanceWidget extends StatelessWidget {
  User? user = User();
  AddViewAttendanceWidget({Key? key}) : super(key: key);
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
    viewAttendanceId = 1;
    Object? leaveAppObject = ModalRoute.of(context)!.settings.arguments;

    // if (leaveAppObject != null) {
    //   viewAttendanceId = leaveAppObject as int?;
    // }

    return SafeArea(
      child: ChangeNotifierProvider<AddViewAttendanceDataNotifier>(
         // create: (_) => AddViewAttendanceDataNotifier(viewAttendanceId), //todo: change it as per requirement
         create: (_) => AddViewAttendanceDataNotifier(),
        child: AddViewAttendance(),
      ),
    );
  }
}

class AddViewAttendance extends StatefulWidget {
  @override
  _AddViewAttendanceState createState() => _AddViewAttendanceState();
}

class _AddViewAttendanceState extends State<AddViewAttendance> {
  String? text = 'Desktop';
  TextEditingController controllerStartDate = new TextEditingController(text: " ");
  TextEditingController controllerEndDate = new TextEditingController(text: " ");
  @override
  void initState() {
    if(viewAttendanceId != null){
      var s = Provider.of<AddViewAttendanceDataNotifier>(context, listen: false);
      //s.userIdNameDDList = [];
      s.getUserNameIdList();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AddViewAttendanceDataNotifier viewAttendanceVM = context.watch<AddViewAttendanceDataNotifier>();
    controllerStartDate.text = viewAttendanceVM.viewAttendanceModel.startDate ?? "";
    controllerEndDate.text = viewAttendanceVM.viewAttendanceModel.endDate ?? "";
    final themeProvider = Provider.of<ThemeProvider>(context);
    print("This is from :  ${viewAttendanceVM.filterGridData}");

    double width = MediaQuery.of(context).size.width * 20 / 100;
    double horizontalSize = 0.0;

    return Scaffold(
      appBar: AppBar(
        title: CustomTextSL(
          text: viewAttendanceId == null ? "View Attendance" : "View Attendance (admin)",
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

            switch (viewAttendanceVM.callState) {
              case CallState.loading:
                widget = ProgressBar();
                break;
              case CallState.failed:
                widget = ErrorText(
                  function: () {viewAttendanceVM.fetchData(viewAttendanceId);},
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


                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
                              child: Form(
                                key: viewAttendanceVM.formKey,
                                autovalidate: viewAttendanceVM.autoValidate,
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
                                        Text("User ID : "), //todo: change it
                                        Column(
                                          children: [
                                            Text("112233", overflow: TextOverflow.ellipsis), //todo: change it
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




                                    // /========================= Leave Type Name ===========================
                                    SizedBox(height: 20),
                                    Visibility(
                                      visible: viewAttendanceId != null ? false : true,
                                      child: TextFormFieldWidget(
                                        label: 'Employee Name',
                                        initalVal: viewAttendanceVM.viewAttendanceModel.employeeName ?? "adeeel",
                                        validate: viewAttendanceVM.validateEmployeeName,
                                        onSave: (String? str) => viewAttendanceVM.onSavedEmpName(str),
                                        isDense: false,
                                        readOnly: true,
                                      ),
                                    ),

                                    // /========================= No Of Leaves ===========================
                                    Visibility(
                                        visible: viewAttendanceId != null ? false : true,
                                        child: SizedBox(height: 20)),
                                    Visibility(
                                      visible: viewAttendanceId != null ? false : true,
                                      child: TextFormFieldWidget(
                                        label: 'Employee ID',
                                        initalVal: viewAttendanceVM.viewAttendanceModel.employeeId ?? "",
                                        textInputType: TextInputType.number,
                                        validate: viewAttendanceVM.validateEmployeeId,
                                        onSave: (String? str) => viewAttendanceVM.onSavedEmpId(str),
                                        isDense: false,
                                      ),
                                    ),

                                    // /========================= Dropdown List of UserName and ID ========================
                                    // /========================= Only show in case of check others ========================
                                    SizedBox(height: 20),
                                    Visibility(
                                      visible: viewAttendanceId!= null ? true : false,
                                      child: CustomDropdownFormField(
                                        label: "Employee Name - Id",
                                        DropDownValuesList: viewAttendanceVM.userIdNameDDList,
                                        onChanged: (DropDownVal? value) => viewAttendanceVM.onSaveUserNameId(value),
                                        selectedValue: viewAttendanceVM.viewAttendanceModel.employeeId,
                                        validate: viewAttendanceVM.validateUserNameIdDDL,
                                        //onSave: (value) => viewAttendanceVM.onSaveUserNameId(value),
                                      ),
                                    ),


                                    // /========================= Button For Today Checking  ===========================
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        clickAbleButton(
                                          color: themeProvider.themeMode().btnPositiveColor,
                                          text: 'Today',
                                          height: 45.0,
                                          width: 300,
                                          onTap: () {
                                            print("Today Attendance Button Click");
                                          },
                                        ),
                                      ],
                                    ),


                                    // /========================= Simple Text  ===========================
                                    SizedBox(height: 30, child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 50.0)   ,
                                          child: CustomTextSL(text: "OR -- Check Record Last 180 days", color: Colors.black45,),
                                        )
                                      ],
                                    )),

                                    // /========================= Start and End Date  ===========================
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: CustomDatePickerInputField(
                                            minDate: DateTime.now().subtract(Duration(days: 180)),
                                            maxDate: DateTime.now(),
                                            hint: "Start Date",
                                            label: "Start Date",
                                            onSave: (date) => viewAttendanceVM.onSaveViewStartDate(date!),
                                            onChange: (date) => viewAttendanceVM.onChangeStartDate(date),
                                            dateController: controllerStartDate,
                                            validate: viewAttendanceVM.validateStartDate,
                                            isDense: false,
                                          ),
                                        ),
                                        SizedBox(width: 10.0),
                                        Flexible(
                                          child: CustomDatePickerInputField(
                                            minDate: DateTime.now().subtract(Duration(days: 180)),
                                            maxDate: DateTime.now(),
                                            hint: "End Date",
                                            label: "End Date",
                                            onSave: (date) => viewAttendanceVM.onSaveViewEndDate(date!),
                                            onChange: (date) => viewAttendanceVM.onChangeEndDate(date),
                                            dateController: controllerEndDate,
                                            validate: viewAttendanceVM.validateEndDate,
                                            isDense: false,
                                          ),
                                        ),
                                      ],
                                    ),





                                    SizedBox(width: 20.0),

                                    submitBtn(context, viewAttendanceVM, themeProvider),
                                    SizedBox(height: 20),
                                     // SizedBox(height: 30),
                                   // Container(height: 800, child:  ViewAttendanceGridScreen(),),
                                  ],
                                ),
                              ),
                            ),
                            // viewAttendanceVM.filterGridData.isNotEmpty ?
                            // Container(height: 800, child:  ViewAttendanceGridScreen(provider: viewAttendanceVM),) : Text(""),
                             Container(height: 800, child:  ViewAttendanceGridScreen(provider: viewAttendanceVM),),
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
Widget submitBtn(BuildContext context, AddViewAttendanceDataNotifier leaveTypeVM, ThemeProvider themeProvider ) {
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
            leaveTypeVM.submit();

            /// Add EmployeeDepartment
            // if (viewAttendanceId == null) {
            //   leaveTypeVM.submit().then((value) {
            //     if (!value.error) {
            //       AppUtiles.showSnackBar(
            //           context, "Leave Type Added Successfully.");
            //       Navigator.pop(context, value.data);
            //     }
            //     else {
            //       AppUtiles.showSnackBar(context, "Error.");
            //     }
            //   });
            // } else {
            //   // Update EmployeeDepartment
            //   leaveTypeVM.update().then((value) {
            //     if (!value.error) {
            //       AppUtiles.showSnackBar(
            //           context, "Leave Type Updated Successfully.");
            //       Navigator.pop(context, leaveTypeVM.viewAttendanceModel);
            //     } else {
            //       AppUtiles.showSnackBar(context, "Error.");
            //     }
            //   });
            // }
          }
          else{
            leaveTypeVM.autoValidate = true;
            AppUtiles.showSnackBar(context, "Validation Error.");
          }
        },
        child: CustomTextSL(
          text: viewAttendanceId == null ? "View" : "View",
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
      text: "View Attendance", size: 24.0,
      color: themeProvider.themeMode().textColorOnPrimary,
      letterSpacing: 1.2,)),
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
