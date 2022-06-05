import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:payroll/utils/AppUtiles.dart';
import 'package:payroll/values/AppColors.dart';

class CustomDatePicker extends StatefulWidget {
  DateTime? minDate;
  DateTime? initialDate;
  DateTime maxDate;
  Function onDone;
  bool isEnable;

  CustomDatePicker(
      {maxTime,
        required this.onDone,
        this.isEnable = true,
        this.minDate,
        this.initialDate,
      }) : maxDate = maxTime ?? DateTime.now().add(Duration(days: 3690));

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  String endDate = AppUtiles.getCurrentDate();
  DateTime selectedDate = DateTime.now();

  onConfirmDate(date) {
    {
      setState(() {
        endDate = DateFormat('MMMM-dd-yyyy').format(date); // AppUtiles.dateToString(date);
      });
      widget.onDone(date);
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.initialDate ??  selectedDate,
      firstDate: widget.minDate ?? DateTime.now(),
      lastDate: widget.maxDate,
    );
    if (picked != null && picked != selectedDate) {
      onConfirmDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        primary: Colors.black,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        side: BorderSide(color: AppColors.borderColor, width: 1),
      ),
      onPressed: widget.isEnable
          ? () {
              _selectDate(context);

              // if(AppUtiles.isDesktop()){
              //   _selectDate(context);
              // }else {
              //   DatePicker.showDatePicker(context,
              //       showTitleActions: true,
              //       minTime: widget.minTime,
              //       maxTime: widget.maxTime,
              //       theme: DatePickerTheme(
              //
              //         headerColor: Theme
              //             .of(context)
              //
              //             .primaryColor,
              //         backgroundColor: Colors.white,
              //         itemStyle: TextStyle(
              //             color: Colors.black,
              //             fontWeight: FontWeight.bold,
              //             fontSize: 16),
              //         doneStyle: TextStyle(color: Colors.white, fontSize: 16),
              //         cancelStyle: TextStyle(color: Colors.white, fontSize: 16),
              //       ),
              //
              //       onChanged: (date) {
              //         print('change $date in time zone ' +
              //             date.timeZoneOffset.inHours.toString());
              //       },
              //       onConfirm: (date) {
              //         onConfirmDate(date);
              //       },
              //       currentTime: selectedDate,
              //       locale: LocaleType.en);
              // }
            }
          : null,
      child: Container(
        // margin: const EdgeInsets.all(15.0),
        height: 33.0,
        padding: const EdgeInsets.all(6.0),
        child: Align(alignment: Alignment.centerLeft, child: Text(endDate)),
      ),
    );
  }
}

// showTimePicker(
// context: context,
// initialTime: TimeOfDay(hour: 10, minute: 47),
// builder: (context, child) {
// return Theme(
// data: ThemeData.light().copyWith(
// colorScheme: ColorScheme.light(
// // change the border color
// primary: Colors.red,
// // change the text color
// onSurface: Colors.purple,
// ),
// // button colors
// buttonTheme: ButtonThemeData(
// colorScheme: ColorScheme.light(
// primary: Colors.green,
// ),
// ),
// ),
// child: child,
// );
// },
// );


// var re = RegExp(
//   r'^'
//   r'(?<day>[0-9]{1,2})'
//   r'/'
//   r'(?<month>[0-9]{1,2})'
//   r'/'
//   r'(?<year>[0-9]{4,})'
//   r'$',
// );