import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payroll/values/AppColors.dart';

class CustomTimePicker extends StatefulWidget {
  Function onDone;
  bool isEnable;
  //TimeOfDay initialTime;
  String initialTime;

  var hour = 00;
  var mint = 00;

  CustomTimePicker({required this.onDone, this.isEnable = true, required this.initialTime});

  @override
  _CustomTimePickerState createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
   TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  onConfirmTime(TimeOfDay time) {
    {
      setState(() {
        selectedTime = time;
        final hours = time.hour.toString().padLeft(2, '0');
        final minutes = time.minute.toString().padLeft(2, '0');
        widget.hour = int.tryParse(hours)!;
        widget.mint = int.tryParse(minutes)!;

        print("Widget Selected Time $hours:$minutes");

        //widget.initialTime = time; //('$hours:$minutes').toString();
        widget.initialTime = ('$hours:$minutes').toString();

      });
      widget.onDone(time);
    }
  }

  _selectTime(BuildContext context) async {
    // final TimeOfDay? picked = await showTimePicker(
    final String? picked = await showTimePicker(
      context: context,
      // initialTime: widget.initialTime,
      initialTime: TimeOfDay(hour: widget.hour, minute: widget.mint),
      // builder: (context,child){
      //   return MediaQuery(
      //     data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
      //     child: Text(""),
      //   );
      // }
    ).then((TimeOfDay? picked) {
      if (picked != null && picked != selectedTime) {
        onConfirmTime(picked);
        // final hours = picked.hour.toString().padLeft(2, '0');
        // final minutes = picked.minute.toString().padLeft(2, '0');
         // return '$hours:$minutes';
        //onConfirmTime('$hours:$minutes');
      }
      else{
        // onConfirmTime("00:00");
        onConfirmTime(TimeOfDay(hour:  widget.hour, minute: widget.mint));
      }
    });


    // if (picked != null && picked != selectedTime) {
    //   onConfirmDate(picked);
    // }
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
          ? () { _selectTime(context);}
          : null,
      child: Container(
        // margin: const EdgeInsets.all(15.0),
        height: 33.0,
        padding: const EdgeInsets.all(6.0),

        // child: Align(alignment: Alignment.centerLeft, child: Text("$myTime")),
         child: Align(alignment: Alignment.centerLeft, child: Text("${widget.initialTime}")),

      ),
    );
  }
}


