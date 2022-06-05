import 'package:flutter/material.dart';
import '../TypeOfFunctions.dart';

class CustomTimePickerInputField extends StatefulWidget {
  bool isPassword;
  String hint;
  String label;
  OnSaveFunctionType onSave;
  OnChangeFunctionType? onChange;
  OnValidateFunctionType? validate;
  TextInputType textInputType;
  TextCapitalization textCapitalization;
  OnTapFunctionType? onTap;
  int minLine;
  int maxLines;
  bool isExpend;

  TextEditingController? timeController;

  CustomTimePickerInputField(
      {this.isPassword = false,
      this.hint = "",
      this.label = "",
      required this.onSave,
      this.validate,
      this.onChange,
      this.onTap,
      this.textInputType = TextInputType.text,
      this.textCapitalization = TextCapitalization.none,
      this.minLine = 1,
      this.maxLines = 1,
      this.isExpend = false,
      required this.timeController});

  @override
  _CustomTimePickerInputFieldState createState() =>
      _CustomTimePickerInputFieldState();
}

class _CustomTimePickerInputFieldState extends State<CustomTimePickerInputField> {
  TimeOfDay? choosenTime;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await showTimePicker(
          context: context,
          initialTime:  choosenTime ?? TimeOfDay(hour: 00, minute: 00),
        ).then((selectedTime) {
          if (selectedTime != null) {
            String hours = selectedTime.hour.toString().padLeft(2, '0');
            String minutes = selectedTime.minute.toString().padLeft(2, '0');
            String dayPeriod = selectedTime.period == DayPeriod.am ? 'AM' : 'PM';
            if (dayPeriod == "PM" && int.tryParse(hours)! > 12) {
              var a = int.tryParse(hours)! - 12;
              hours = a.toString().padLeft(2, '0');
            }
            setState(() {
            widget.timeController?.text = '$hours:$minutes $dayPeriod';
            widget.onChange!(('$hours:$minutes $dayPeriod'));
            choosenTime = selectedTime;
            });

          } else {
            widget.timeController?.text = "00:00";
          }
        });
      },
      child: AbsorbPointer(
        child: TextFormField(
          controller: widget.timeController,
          expands: widget.isExpend,
          textCapitalization: widget.textCapitalization,
          keyboardType: widget.textInputType,
          onChanged: widget.onChange,
          validator: widget.validate,
          onSaved: widget.onSave,
          maxLines: widget.maxLines,
          minLines: widget.minLine,
          onTap: widget.onTap,
          readOnly: false,

          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.fromLTRB(16, 20, 10, 0),
            helperText: ' ',
            hintText: widget.hint,
            labelText: widget.label,
            focusColor: Theme.of(context).primaryColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
        ),
      ),
    );
  }
}

// String dayperiod = "AM";
// selectedDate.period == DayPeriod.am ? dayperiod = dayperiod : dayperiod = "PM";
// String dayperiod = selectedDate.period == DayPeriod.am ? 'AM' : 'PM';
// shiftTimeModel.newTime = newHour! + ":" + newMint! + " " + dayperiod;
//_dateController.text =  ('$hours:$minutes').toString(); // selectedDate.toString(); //DateFormat('MM-dd-yyyy').format(selectedDate);
// widget.timeController?.text = selectedDate.format(context).toString();
// widget.timeController?.text = selectedDate.toString() ;
//return '$hours:$minutes';
