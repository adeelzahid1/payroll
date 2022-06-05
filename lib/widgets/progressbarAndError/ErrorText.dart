import 'package:flutter/material.dart';
import '../TypeOfFunctions.dart';


class ErrorText extends StatelessWidget {

  OnTapFunctionType? function ;
  String error = "";


  ErrorText({this.function });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Center(
        child: Text("Error\nPlease click to retry"),
      ),
    );
  }
}
