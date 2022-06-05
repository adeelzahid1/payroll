import 'dart:async';
import 'package:auth/auth/screens/OTP/otpScreen.dart';
import 'package:flutter/material.dart';
import 'package:network/SharedPrefManager.dart';
import 'package:network/models/theme/ThemeProvider.dart';
import 'package:network/models/user.dart';
import 'package:payroll/modals/enum/CallState.dart';
import 'package:payroll/routes/PayRollAppPagesConstants.dart';
import 'package:payroll/screens/addAttendanceInOut/AddAttendanceInOutDataNotifier.dart';
import 'package:payroll/utils/AppUtiles.dart';
import 'package:payroll/widgets/TextField/TextFormFieldWidget.dart';
import 'package:payroll/widgets/buttons/CustomRaisedButton.dart';
import 'package:payroll/widgets/datePicker/CustomDatePickerInputField.dart';
import 'package:payroll/widgets/datePicker/DatePickerWidget.dart';
import 'package:payroll/widgets/progressbarAndError/ErrorText.dart';
import 'package:payroll/widgets/progressbarAndError/ProgressBar.dart';
import 'package:payroll/widgets/texts/CustomTextSL.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

  int? attendanceId;
  String? inOutId;
  String? userName;
class AddAttendanceInOutWidget extends StatelessWidget {
  User? user = User();
  AddAttendanceInOutWidget({Key? key}) : super(key: key);
  void getUser(){
    SharedPrefManagerUser.getInstance().then((value){
      if(value!=null){
        inOutId = null; userName = null; attendanceId = null;
        user = value.getUser();
        inOutId = user?.id;
        userName = user?.userName;
        // attendanceId = 1;
        print("USER IS: ${user?.id}");
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    getUser();
     //attendanceId = null;
    // Object? leaveTypeObject = ModalRoute.of(context)!.settings.arguments;
    // if (leaveTypeObject != null) {
    //   attendanceId = leaveTypeObject as int?;
    inOutId == null ? attendanceId = null :attendanceId = 1;
    // if(user!.id != null && user!.id!.isNotEmpty){
    //     attendanceId = 1;
    // }
    // }
    return SafeArea(
      child: ChangeNotifierProvider<AddAttendanceInOutDataNotifier>(
        //create: (_) => AddAttendanceInOutDataNotifier(attendanceId),
        create: (_) => AddAttendanceInOutDataNotifier(user?.id),
        child: AddAttendanceInOut(user: user),
      ),
    );
  }
}

class AddAttendanceInOut extends StatefulWidget {
  User? user;
  AddAttendanceInOut({this.user});

  @override
  _AddAttendanceInOutState createState() => _AddAttendanceInOutState();
}

class _AddAttendanceInOutState extends State<AddAttendanceInOut> {
  String? text = 'Desktop';

  @override
  Widget build(BuildContext context) {
    AddAttendanceInOutDataNotifier attendanceVM = context.watch<AddAttendanceInOutDataNotifier>();
    final themeProvider = Provider.of<ThemeProvider>(context);

    double width = MediaQuery.of(context).size.width * 20 / 100;
    double horizontalSize = 0.0;
    return Scaffold(
      appBar: AppBar(
        title: Text(attendanceId == null ? "IN Attendance" : "OUT Attendance"),
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

            switch (attendanceVM.callState) {
              case CallState.loading:
                widget = ProgressBar();
                break;
              case CallState.failed:
                widget = ErrorText(
                  function: () {
                    // attendanceVM.fetchData(attendanceId);
                    attendanceVM.fetchData(null);
                  },
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

                            InkWell(
                              onTap: (){
                                print("CLICK");
                                attendanceId!= null
                                    ? setState(() {attendanceId= null;})
                                    :setState(() {attendanceId= 1;});
                                print(attendanceId);
                              },
                                child: headerBar(themeProvider)),
                            SizedBox(height: 10.0),


                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
                              child: Form(
                                key: attendanceVM.formKey,
                                autovalidate: attendanceVM.autoValidate,
                                child: Column(
                                  children: [
                                    // /========================= AttendanceInOut Name ===========================
                                    SizedBox(height: 20),
                                    TextFormFieldWidget(
                                      label: 'Employee Id',
                                      // initalVal: attendanceVM.attendanceModel.employeeId ?? "",
                                      initalVal: inOutId ?? "",
                                      validate: attendanceVM.validateEmployeeId,
                                      onSave: (String? str) {
                                        attendanceVM.attendanceModel.employeeId = str;
                                      },
                                      isDense: false,
                                    ),

                                    // /========================= No Of Leaves ===========================
                                    SizedBox(height: 20),
                                    TextFormFieldWidget(
                                      label: 'Employee Name',
                                      // initalVal: attendanceVM.attendanceModel.employeeName?.toString() ?? "",
                                      initalVal: userName ?? "",
                                      textInputType: TextInputType.number,
                                      validate: attendanceVM.validateEmployeeName,
                                      onSave: (String? str) {
                                        attendanceVM.attendanceModel.employeeName = str;
                                      },
                                      isDense: false,
                                    ),
                                    SizedBox(height: 20,),

                                    Container(
                                      width: 400.0,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomTextSL(text: "Time:", size: 16.0, fontWeight: FontWeight.w600, color: Colors.black54,),
                                          //color: themeProvider.themeData().bottomAppBarColor,
                                          // currentTime(context),
                                          CurrentTime(),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 30),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        // Visibility(
                                        //   visible: attendanceId == null ? true : false,
                                        //   child: clickAbleButton(
                                        //     attendanceVM: attendanceVM,
                                        //     themeProvider: themeProvider,
                                        //     text: "IN",
                                        //     color: Colors.green,
                                        //     //onTap: (){print(attendanceVM.attendanceModel.inTime);},
                                        //     width: 150.0,
                                        //     height: 40.0,
                                        //   ),
                                        // ),SizedBox(width: 30.0),
                                        //
                                        // Visibility(
                                        //   visible: attendanceId == null ? false : true,
                                        //   child: clickAbleButton(
                                        //     attendanceVM: attendanceVM,
                                        //     themeProvider: themeProvider,
                                        //     text: "OUT",
                                        //     color: Colors.red,
                                        //     //onTap: (){print('${attendanceVM.attendanceModel.outTime} ${attendanceVM.attendanceModel.employeeName}');},
                                        //     width: 150.0,
                                        //     height: 40.0,
                                        //   ),
                                        // ),

                                        clickAbleButton(
                                          attendanceVM: attendanceVM,
                                          themeProvider: themeProvider,
                                          color: Colors.red,
                                          //onTap: (){print('${attendanceVM.attendanceModel.outTime} ${attendanceVM.attendanceModel.employeeName}');},
                                          width: 150.0,
                                          height: 40.0,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 30),



                                   // submitBtn(context, leaveTypeVM, themeProvider),
                                    //  SizedBox(height: 30),
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

  @override
  void dispose() {
    super.dispose();
  }

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
      text: "ATTENDANCE", size: 24.0,
      color: themeProvider.themeMode().textColorOnPrimary,
      letterSpacing: 1.2,)),
  );
}

// /========= ClickAble Button ============
class clickAbleButton extends StatelessWidget {
      Color? color;
      String? text;
      double? height;
      double? padding;
      double? margin;
      //VoidCallback? onTap;
      double? width;
      AddAttendanceInOutDataNotifier attendanceVM;
      ThemeProvider themeProvider;

  clickAbleButton({Key? key,
    this.color,
    this.text,
    this.height,
    this.padding,
    this.margin,
    //this.onTap,
    this.width,
    required this.attendanceVM,
    required this.themeProvider,
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
                color: attendanceId==null ? Colors.green : Colors.red,
                 //color: color,
                borderRadius: BorderRadius.circular(10.0),
              ),

              alignment: Alignment.center,
              //margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: CustomTextSL(
                text: attendanceId==null ? "IN" : "OUT",
                // text: text,
                color: Colors.white,
                size: 20.0,
                letterSpacing: 2.0,
              )),

          // onTap: onTap,
          onTap: () {
            if (attendanceVM.formKey.currentState!.validate()) {
              attendanceVM.formKey.currentState!.save();
              /// Add Attendance
              print(attendanceVM.attendanceModel.employeeName);
              print(attendanceVM.attendanceModel.employeeId);
              print("IN TIME : ${attendanceVM.attendanceModel.inTime}");
              print("OUT TIME : ${attendanceVM.attendanceModel.outTime}");

              if (attendanceId == null) {
                attendanceVM.submit().then((value) {
                  if (!value.error) {
                    AppUtiles.showSnackBar(context, "Attendance IN");
                    Navigator.pop(context, value.data);
                  } else {
                    AppUtiles.showSnackBar(context, "Error.");
                  }
                });
              }
              else {
                attendanceVM.update().then((value) {
                  if (!value.error) {
                    AppUtiles.showSnackBar(context, "Attendance OUT.");
                    Navigator.pop(context);
                    // Navigator.pop(context, attendanceVM.attendanceModel);
                  } else {
                    AppUtiles.showSnackBar(context, "Error.");
                  }
                });
              }
            }
            else{
              attendanceVM.autoValidate = true;
              AppUtiles.showSnackBar(context, "Validation Error.");
            }
          },

        ),
      ),
    );
  }
}


// ============ CURRENT TIME WIDGET
class CurrentTime extends StatefulWidget {
  @override
  _CurrentTimeState createState() => _CurrentTimeState();
}

class _CurrentTimeState extends State<CurrentTime> {

Duration duration = Duration();
Timer? timer;
String timeNow="";

@override
  void initState() {
    super.initState();
    startTimer();
  }

  void addTime(){
   // final addSecond =1 ;
    if(this.mounted){
      setState(() {
        DateFormat dateFormat = DateFormat("HH:mm:ss a");
        String string = dateFormat.format(DateTime.now());

        // final seconds = duration.inSeconds + addSecond;
        // duration = Duration(seconds: seconds);
        // timeNow = duration.inSeconds.toString();
        timeNow = string;
      });
    };

  }

  void startTimer(){
    timer = Timer.periodic(Duration(seconds: 1), (timer) { addTime();});
  }

  @override
  Widget build(BuildContext context) {
  AddAttendanceInOutDataNotifier leaveTypeVM = context.watch<AddAttendanceInOutDataNotifier>();
  var time= DateFormat("HH:mm:ss").format(DateTime.now());
     if(attendanceId == null){
       leaveTypeVM.attendanceModel.inTime = time;
       //leaveTypeVM.attendanceModel.inTime = timeNow;
       leaveTypeVM.attendanceModel.outTime = null;
     }
     else{
       leaveTypeVM.attendanceModel.inTime = null;
       leaveTypeVM.attendanceModel.outTime = time;
       // leaveTypeVM.attendanceModel.outTime = timeNow;
     }

    return Container(
      width: 130.0,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(width: 1.0),
          boxShadow: [BoxShadow(blurRadius: 1.0,color: Colors.black26,offset: Offset(1,1))]
      ),
      child: CustomTextSL(text: "${timeNow}", size: 16.0, fontWeight: FontWeight.w600, color: Colors.black54,),
    );
  }

@override
void dispose() {
  super.dispose();
  startTimer();
}
}

// String time = " ";
// String getText(text){
//   Timer.periodic(Duration(seconds:1), (timer) {
//     setState(() {
//       text = TimeOfDay.now().format(context);
//     });
//   });
//   return text;
// }


// /========= Submit Button ============
// Widget submitBtn(BuildContext context, AddAttendanceInOutDataNotifier leaveTypeVM, ThemeProvider themeProvider ) {
//   return Center(
//     child: Container(
//       width: MediaQuery.of(context).size.width * 25 / 100,
//       decoration: BoxDecoration(
//         // color: Theme.of(context).primaryColor,
//       ),
//       child: CustomRaisedButton(
//         color: themeProvider.themeMode().primaryColor,
//         onPress: () {
//           if (leaveTypeVM.formKey.currentState!.validate()) {
//             leaveTypeVM.formKey.currentState!.save();
//
//             /// Add EmployeeDepartment
//             if (attendanceId == null) {
//               leaveTypeVM.submit().then((value) {
//                 if (!value.error) {
//                   AppUtiles.showSnackBar(
//                       context, "AttendanceInOut Added Successfully.");
//                   Navigator.pop(context, value.data);
//                 } else {
//                   AppUtiles.showSnackBar(context, "Error.");
//                 }
//               });
//             } else {
//               // Update EmployeeDepartment
//               leaveTypeVM.update().then((value) {
//                 if (!value.error) {
//                   AppUtiles.showSnackBar(
//                       context, "AttendanceInOut Updated Successfully.");
//                   Navigator.pop(context, leaveTypeVM.attendanceModel);
//                 } else {
//                   AppUtiles.showSnackBar(context, "Error.");
//                 }
//               });
//             }
//           }
//           else{
//             leaveTypeVM.autoValidate = true;
//             AppUtiles.showSnackBar(context, "Validation Error.");
//           }
//         },
//         child: CustomTextSL(
//           text: attendanceId == null ? "Save" : "Update",
//           letterSpacing: 1.5,
//           color: Colors.white,
//         ),
//       ),
//     ),
//   );
// }



// onTap: onTap,
// onTap: () {
// if (attendanceVM.formKey.currentState!.validate()) {
// attendanceVM.formKey.currentState!.save();
// /// Add Attendance
// if (attendanceId == null) {
// attendanceVM.submit().then((value) {
// if (!value.error) {
// AppUtiles.showSnackBar(
// context, "Attendance IN Submitted");
// Navigator.pop(context, value.data);
// } else {
// AppUtiles.showSnackBar(context, "Error.");
// }
// });
// } else {
// // Update EmployeeDepartment
// // attendanceVM.update().then((value) {
// attendanceVM.submit().then((value) {
// if (!value.error) {
// AppUtiles.showSnackBar(
// // context, "Attendance InOut Updated Successfully.");
// context, "Attendance OUT Submitted.");
// Navigator.pop(context, attendanceVM.attendanceModel);
// } else {
// AppUtiles.showSnackBar(context, "Error.");
// }
// });
// }
// }
// else{
// attendanceVM.autoValidate = true;
// AppUtiles.showSnackBar(context, "Validation Error.");
// }
// },




// attendanceVM.submit().then((value) {
// if (!value.error) {
// AppUtiles.showSnackBar(
// context, attendanceId == null ? "Attendance IN Submitted" : "Attendance OUT Submitted");
// // Navigator.pop(context, value.data);
// Navigator.pop(context);
// } else {
// // AppUtiles.showSnackBar(context, "Error.");
// AppUtiles.showSnackBar(context, "${value.errorMessage}");
// }
// });
