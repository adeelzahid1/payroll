
import 'package:flutter/material.dart';
import 'package:payroll/modals/widgets/DropDownValue.dart';

import '../TypeOfFunctions.dart';

class CustomDropdownFormField<T> extends StatefulWidget {
  List<DropDownVal>? DropDownValuesList;
  dynamic? selectedValue;
  onValidateDDLFunctionType? validate;
  final ValueChanged<DropDownVal?>? onChanged;
  OnSaveDDLFunctionType? onSave;
  List<DropdownMenuItem<DropDownVal>> dropdownMenuItemList = [];
  DropDownVal? value = null;
  bool isEnabled;
  bool isExpanded;
  bool isDense;
  String? label;
  Color? errorColor;
  Color? labelColor;

  CustomDropdownFormField({
    this.onChanged,
    this.onSave,
    Key? key,
    this.validate,
    this.DropDownValuesList,
    this.selectedValue,
    this.isEnabled = true,
    this.isExpanded = false,
    this.isDense = true,
    this.errorColor = Colors.red, //
    this.labelColor = Colors.blue,//.withAlpha(100), Not Used

    this.label,
  }) : super(key: key);

  @override
  _CustomDropdownFormFieldState<T> createState() => _CustomDropdownFormFieldState<T>();
}

class _CustomDropdownFormFieldState<T> extends State<CustomDropdownFormField<T>> {
  void dropdownValues() {
    widget.dropdownMenuItemList =
        buildDropDownValDropdown(widget.DropDownValuesList);
    if (widget.selectedValue != null && widget.DropDownValuesList != null) {
      final index = widget.DropDownValuesList!
          .indexWhere((element) => element.value == widget.selectedValue);
      if (index != -1) {
        widget.value = widget.DropDownValuesList![index];
      } else {
        if (widget.DropDownValuesList!.length > 0)
          widget.value = widget.DropDownValuesList![0];
      }
    } else {
      if (widget.DropDownValuesList != null &&
          widget.DropDownValuesList!.length > 0)
        widget.value = widget.DropDownValuesList![0];
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dropdownMenuItemList == null ||
        widget.dropdownMenuItemList.isEmpty) dropdownValues();
    return IgnorePointer(
      ignoring: !widget.isEnabled,
        child: SizedBox(
          height: 55.0,
          child: DropdownButtonFormField( // DropdownButtonHideUnderline
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(14, 20, 10, 0),
              labelText: widget.label,
              labelStyle: TextStyle(
                letterSpacing: 1.6, fontSize: 15.0, color: widget.selectedValue != -1 ? Colors.black : Colors.redAccent,
              ),
              errorStyle: TextStyle(
                color: widget.errorColor, // Colors.red[400],
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
             border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
               focusColor: Theme.of(context).primaryColor,
            ),
             isDense: widget.isDense,
            itemHeight: 55.0,
            isExpanded: widget.isExpanded,

            items: widget.dropdownMenuItemList,
            onChanged: (DropDownVal? val) {
              setState(() {
                widget.selectedValue = val!.value;
                widget.value = val;
              });
              if(widget.onChanged != null){
                widget.onChanged!(val);
              }
            },
            value: widget.value,
            validator: widget.validate,
            onSaved: widget.onSave,
          ),
        ),
     // ), // Container
    );
  }

  List<DropdownMenuItem<DropDownVal>> buildDropDownValDropdown(
      List? DropDownValList) {
    List<DropdownMenuItem<DropDownVal>> items = [];
    if (DropDownValList != null) {
      for (DropDownVal dropDownVal in DropDownValList) {
        items.add(DropdownMenuItem(
          value: dropDownVal,
          child: Text(dropDownVal.name!),
        ));
      }
    }
    return items;
  }
}


