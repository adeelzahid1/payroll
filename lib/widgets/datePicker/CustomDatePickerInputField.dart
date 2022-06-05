import 'package:flutter/material.dart';
import 'package:payroll/utils/AppUtiles.dart';
import '../TypeOfFunctions.dart';
import 'package:intl/intl.dart';

class CustomDatePickerInputField extends StatefulWidget {

  String hint;
  String label;
  OnSaveFunctionType onSave;
  OnChangeFunctionType? onChange;
  OnValidateFunctionType? validate;
  TextInputType textInputType;
  OnTapFunctionType? onTap;
  DateTime? minDate;
  DateTime maxDate;
  bool isEnable;
  bool isDense;

  TextEditingController? dateController;

  CustomDatePickerInputField(
      {
        maxDate,
        this.isEnable = true,
        this.minDate,
        this.hint = "",
        this.label = "",
        required this.onSave,
        this.validate,
        this.onChange,
        this.onTap,
        this.textInputType = TextInputType.datetime,
        this.isDense = true,
        required this.dateController}) : maxDate = maxDate ?? DateTime.now().add(Duration(days: 90));

  @override
  _CustomDatePickerInputFieldState createState() =>
      _CustomDatePickerInputFieldState();
}

class _CustomDatePickerInputFieldState extends State<CustomDatePickerInputField> {
  String newDate = AppUtiles.getCurrentDate();
  DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await showDatePicker(
          context: context,
          initialDate: DateTime.tryParse(newDate) ?? currentDate,
          firstDate: widget.minDate ?? DateTime.now(),
          lastDate: widget.maxDate,
        ).then((date) {
           if(date!=null){
             setState(() {
               //newDate = DateFormat('yyyy-MM-dd').format(date);
                //newDate = DateFormat('dd MMMM yyyy').format(date); // AppUtiles.dateToString(date); DateFormat('dd-MM-yyyy')
               newDate = date.toString();
               widget.dateController!.text = newDate;
             });
             widget.onChange!(newDate);
           }
           else{
             widget.dateController!.text = DateTime.now().toString();
           }
        });
      },
      child: AbsorbPointer(
        child: TextFormField(
          //initialValue: AppUtiles.getCurrentDate().toString(),
          controller: widget.dateController,

          keyboardType: widget.textInputType,
          onChanged: widget.onChange,
          validator: widget.validate,
          onSaved: widget.onSave,
          onTap: widget.onTap,
          readOnly: true,
          decoration: InputDecoration(
            isDense: widget.isDense,
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
