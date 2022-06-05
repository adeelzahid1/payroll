
import 'package:flutter/material.dart';


class CustomTextSL extends StatelessWidget {
  String text;
  double size;
  FontWeight fontWeight;
  int maxLine;
  TextAlign textAlign;
  double letterSpacing;
  Color? color;
  TextOverflow? overflow;

  CustomTextSL({
    required this.text,
    this.size = 14,
    this.maxLine =-1,
    this.textAlign= TextAlign.start,
    this.fontWeight = FontWeight.normal,
    this.color,
    this.letterSpacing = 1.0,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return maxLine ==-1 ?
    textNoMaxLine() : textSetMaxLine();
  }

  Widget textNoMaxLine()
  {
    return Text(
      text,
      textAlign:  textAlign,
      overflow: overflow,
      style: TextStyle(
        fontSize: size,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
      ),
    );
  }
  Widget textSetMaxLine()
  {
    return Text(
      text,
      maxLines: maxLine,
      textAlign:  textAlign,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: size,
          fontWeight: fontWeight,
          color: color,
          letterSpacing: letterSpacing
      ),
    );
  }
}
