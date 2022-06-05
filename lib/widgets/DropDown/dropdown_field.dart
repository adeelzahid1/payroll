import 'package:flutter/material.dart';

import '../TypeOfFunctions.dart';

class DropDownField extends StatelessWidget {
  const DropDownField({
    this.chooseValue,
    required this.onChanged,
    required this.listItems,
    required this.hintText,
  });

  final String? chooseValue;
  final OnChangeFunctionPNullType onChanged;
  final List<String> listItems;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: DropdownButton(
        hint: Text('$hintText'),
        value: chooseValue,

        underline: SizedBox(),
        isDense: true,
        dropdownColor: Colors.white,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 30.0,
        isExpanded: true,
        style: TextStyle(color: Colors.black, fontSize: 16.0),
        onChanged: onChanged,
        items: listItems.map((valueItem) {
          return DropdownMenuItem(
            value: valueItem,
            child: Text(
              valueItem,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: true,
            ),
          );
        }).toList(),

      ),
    );
  }
}
