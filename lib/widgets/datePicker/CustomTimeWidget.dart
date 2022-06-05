import 'package:flutter/material.dart';
import '../TypeOfFunctions.dart';

class CustomTimeWidget extends StatefulWidget {
  //String? initalVal;
  String hint;
  String label;
  OnSaveFunctionType? onSave; // void Function(String? str);
  OnChangeFunctionType? onChange; // void Function(String? str)
  OnValidateFunctionType? validate; // String? Function(String? str)
  VoidCallback? onTap;
  TextInputType textInputType;
  bool isExpend;
  bool isEnable;
  TextEditingController? controller;
  Color? errorColor;
  bool? isDense;
  TextEditingController? timeController;

  CustomTimeWidget({
    //this.initalVal,
    this.hint = "",
    this.label = "",
    required this.onSave,
    this.onChange,
    this.validate,
    this.onTap,
    this.textInputType = TextInputType.text,
    this.isExpend = false,
    this.isEnable = false,
    this.controller,
    this.errorColor,
    this.isDense = true,
    required this.timeController,
  });

  @override
  _CustomTimeWidgetState createState() => _CustomTimeWidgetState();
}

class _CustomTimeWidgetState extends State<CustomTimeWidget> {
//  TextEditingController timeCtl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        readOnly: true,
        controller: widget.timeController,
        decoration: InputDecoration(
          isDense: widget.isDense,
          labelText: 'Time',
          contentPadding: EdgeInsets.fromLTRB(14, 20, 10, 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
        onTap: () async {
          await showTimePicker(
            context: context,
            initialTime: TimeOfDay(hour: 00, minute: 00),
          ).then((selectedDate) {
            if (selectedDate != null) {
              final hours = selectedDate.hour.toString().padLeft(2, '0');
              final minutes = selectedDate.minute.toString().padLeft(2, '0');
              //_dateController.text =  ('$hours:$minutes').toString(); // selectedDate.toString(); //DateFormat('MM-dd-yyyy').format(selectedDate);
              widget.timeController?.text = selectedDate.format(context).toString();
               //return '$hours:$minutes';
            }
          });
        },
        validator: widget.validate,
        onChanged: widget.onChange,
        onSaved: widget.onSave,
        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return 'Please enter date.';
        //   }
        //   return null;
        // },
      ),
    );
    //SizedBox(height:sizeBoxHeight),
  }
}

// class _CustomTimeWidgetState extends State<CustomTimeWidget> {
// //  TextEditingController timeCtl = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     // return Text(widget.initalVal==null ? "Hello" : widget.initalVal!);
//     return TextFormField(
//       // controller: timeCtl,  // add this line.
//       initialValue: widget.initalVal == "" ? TimeOfDay.now().toString() : widget.initalVal,
//       decoration: InputDecoration(
//         labelText: 'time*',
//       ),
//       onTap: () async {
//         TimeOfDay time = TimeOfDay.now();
//         FocusScope.of(context).requestFocus(new FocusNode());
//
//         TimeOfDay? picked =
//         await showTimePicker(context: context, initialTime: time);
//         if (picked != null && picked !="" && picked != time) {
//           // timeCtl.text = picked.toString();  // add this line.
//           setState(() {
//              time = picked;
//             widget.initalVal = picked.toString();
//           });
//         }
//       },
//       // validator: (value) {
//       //   if (value!.isEmpty)
//       //     {return 'cant be empty';}
//       //   return null;},
//     );
//   }
// }
