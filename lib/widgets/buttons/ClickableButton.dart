// /========= ClickAble Button ============
import 'package:flutter/material.dart';
import 'package:payroll/widgets/texts/CustomTextSL.dart';

class ClickAbleButton extends StatelessWidget {
  Color? color;
  String text;
  double? height;
  double? padding;
  double? margin;
  VoidCallback? onTap;
  double? width;


  ClickAbleButton({Key? key,
    this.color,
    required this.text,
    this.height,
    this.padding,
    this.margin,
    this.onTap,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Flexible(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: InkWell(
          child: Container(
              width: width ?? double.infinity,
              height: height,
              // color: Theme.of(context).primaryColor,
              padding: EdgeInsets.symmetric(horizontal: padding ?? 0.0),
              //margin: EdgeInsets.symmetric(horizontal: 60.0),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10.0),
              ),

              alignment: Alignment.center,
              //margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: CustomTextSL(
                text: text,
                color: Colors.white,
                size: 20.0,
                letterSpacing: 2.0,
              )),

          onTap: onTap,
        ),
      ),
    );
  }
}