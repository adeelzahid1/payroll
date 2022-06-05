import 'package:flutter/material.dart';
import 'package:payroll/values/AppColors.dart';
import 'package:payroll/widgets/buttons/CustomRaisedButton.dart';

class RaisedButtonLeftImage extends CustomRaisedButton {
  RaisedButtonLeftImage({
    required String assetName,
    required String text,
    Color color = AppColors.ColorBtnPositive,
    Color textColor = AppColors.ColorBtnTextPositive,
    required VoidCallback onPress,
  }) : super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(assetName),
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 15.0,
                ),
              ),
              Opacity(
                opacity: 0.0,
                child: Image.asset(assetName),
              ),
            ],
          ),
          color: color,
          onPress: onPress,
        );
}
