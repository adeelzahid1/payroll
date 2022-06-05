import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../TypeOfFunctions.dart';

class RoundIconButton extends StatelessWidget {
  final IconData icon;
  final OnTapFunctionType onPress;
  double? height;
  double? width;
  double? elevation;
  Color? fillColor;
  Color? iconColor;

    RoundIconButton({Key? key,
    required this.icon,
    required this.onPress,
    this.height = 56.0,
    this.width = 56.0,
    this.elevation = 6.0,
    this.fillColor = Colors.white,  //const Color(0xFF4C4F5E),
    this.iconColor = Colors.black54,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(icon, color: iconColor,),
      constraints: BoxConstraints.tightFor(
        width: width,
        height: height,
      ),
      elevation: elevation!,
      // shape: CircleBorder(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
      fillColor: fillColor,
      onPressed: onPress,
    );
  }
}
