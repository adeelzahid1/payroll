import 'dart:io';

import 'package:auth/auth/models/PlateFormEnum.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:payroll/modals/widgets/DropDownValue.dart';
import 'package:payroll/widgets/dialogbox/DialogBoxSingleActionBlurry.dart';


class AppUtiles {
  static bool isDesktop() {
    bool isDesktop = false;
    if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      isDesktop = true;
    }
    return isDesktop;
  }

  static bool isInRow(context) {
    bool isInRow = false;
    isInRow = MediaQuery.of(context).size.width > 600 ? true : false;
    return isInRow;
  }

  static getHeight(context) {
    return MediaQuery.of(context).size.height;
  }

  static getWidth(context) {
    return MediaQuery.of(context).size.width;
  }


  static showSnackBar(context, String? text) {
    var snackBar = SnackBar(content: Text('$text'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static String getCurrentDate() {
    final now = new DateTime.now();
    return DateFormat('yMd').format(now);
  }
  static DateTime getCurrentDateDate() {
    return new DateTime.now();
  }

  static String dateToString(DateTime dateTime) {
    return DateFormat('yMd').format(dateTime);
  }

  static String getFulldateFromString(String date){
    return DateFormat('dd MMMM yyyy').format(DateTime.parse(date));
  }

  static void hideKeyBoard(context) {
    // if (isMobilePlateForm())
    FocusScope.of(context).unfocus();
  }

  static bool isMobilePlateForm() {
    bool isMobilePlateForm = false;
    if (Platform.isAndroid) {
      isMobilePlateForm = true;
      // Android-specific code
    } else if (Platform.isIOS) {
      isMobilePlateForm = true;
      // iOS-specific code
    }
    return isMobilePlateForm;
  }

  static void printLog(String message) {
    print(message);
  }

  static PlatFormEnum getPlateForm(context) {
    PlatFormEnum platFormEnum;

    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 800) {
      platFormEnum = PlatFormEnum.mobile;
    } else if (screenWidth >= 800 && screenWidth < 1200) {
      platFormEnum = PlatFormEnum.tab;
    } else {
      platFormEnum = PlatFormEnum.window;
    }
    return platFormEnum;
  }


  static double getButtonHMarginPlatForm(context) {
    double margin;

    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 800) {
      margin = screenWidth/40;
    } else if (screenWidth >= 800 && screenWidth < 1200) {
      margin = screenWidth/35;
    } else {
      margin = screenWidth/6;
    }
    return margin;
  }

  static double getButtonHMarginPlatFormHalfScreen(context) {
    double margin;

    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 800) {
      margin = screenWidth/40;
    } else if (screenWidth >= 800 && screenWidth < 1200) {
      margin = screenWidth/35;
    } else {
      margin = screenWidth/22;
    }
    return margin;
  }

  static double getButtonHPadding(context) {
    double margin;

    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 800) {
      margin = 30;
    } else if (screenWidth >= 800 && screenWidth < 1200) {
      margin = 50;
    } else {
      margin = 70;
    }
    return margin;
  }


  static String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);

    if (value == null) {
      return null;
    } else {
      if (value.length == 0) {
        return 'Please Enter email address';
      } else if (!regExp.hasMatch(value)) {
        return 'Invalid email';
      } else {
        return null;
      }
    }
  }

  static String? validateName(String? value) {
    if (value == null) {
      return null;
    } else {
      if (value.length < 1) {
        return 'Please enter valid name';
      } else {
        return null;
      }
    }
  }



static String? validateMobile(String? value) {
  String pattern = r'(^(?:[+0]9)?[0-9]{11}$)';
  RegExp regExp = new RegExp(pattern);
  if(value == null){
    return null;
  }
  else {
    if (value.length == 0) {
      return 'Please enter mobile number';
    }
    else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }
// Phone numbers must contain 11 digits.
// In case country code us used, it can be 14 digits. (example country codes: +92, 0092)
// No space or no characters allowed between digits
// In simple terms, here is are the only "valid" phone numbers
// 3006233475, +92416233475, 923001234567, 00923001122334
// String pattern = r'(^(?:[+0]9)?[0-9]{11,14}$)';
}




  static showDialogBoxSingleAction({required BuildContext context , Function? function , String? title , String? content , String? btnText}){

    DialogBoxSingleActionBlurry alert =   DialogBoxSingleActionBlurry( title: title??"" , content: content! , btnText: btnText ?? "", continueCallBack: () {
      function!();
    },);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }




// static showDialogBoxSingleAction({required BuildContext context , Function? function , String title = "" , String content = "" , String btnText = ""}){
  //
  //   DialogBoxSingleActionBlurry alert =   DialogBoxSingleActionBlurry( title: title , content: content , btnText: btnText, continueCallBack: () {
  //     function!();
  //   },);
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }



  ///// show multi dialog
  // List<String> alertTitles = <String>["Delete"];
  // DialogBoxMultiAction(cancelTitle: "Cancel", alertTitle: "Confirmation",
  // alertDetailMessage: "Are you sure you want to delete",
  // alertActionTitles:alertTitles, onAlertAction:
  // (int selectedActionIndex){
  // print("${alertTitles[selectedActionIndex]} action performed");
  // }
  // ).show(context);


  // static List<DropdownMenuItem<DropDownVal>> buildDropDownValDropdown(
  //     List DropDownValList) {
  //   List<DropdownMenuItem<DropDownVal>> items = List();
  //   for (DropDownVal dropDownVal in DropDownValList) {
  //     items.add(DropdownMenuItem(
  //       value: dropDownVal,
  //       child: Text(dropDownVal.name),
  //     ));
  //   }
  //   return items;
  //}

  static List<DropdownMenuItem<DropDownVal>> buildDropDownValDropdown(
      List DropDownValList) {
    List<DropdownMenuItem<DropDownVal>> items = [];
    for (DropDownVal dropDownVal in DropDownValList) {
      items.add(DropdownMenuItem(
        value: dropDownVal,
        child: Text(dropDownVal.name!),
      ));
    }
    return items;
  }

}
