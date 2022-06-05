
import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {

  bool value;
  Function(bool? val) onChange;

  CustomCheckBox(this.value,  this.onChange);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Checkbox(
        onChanged: onChange,
        value: value,
      ),
    );
  }
}
