import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double borderRadious;
  final EdgeInsetsGeometry? padding;
  final double height;
  final VoidCallback? onPress;

  CustomRaisedButton(
      {required this.child,
      this.color,
      this.borderRadious = 2.0,
        this.padding,
      this.height = 50.0,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: RaisedButton(
        child: child,
        color: color,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadious))),
        onPressed: onPress,
        padding: EdgeInsets.fromLTRB(0,0,0,0),
      ),
    );
  }
}
