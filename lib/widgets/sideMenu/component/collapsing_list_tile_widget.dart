
import 'package:flutter/material.dart';
import 'package:network/models/theme/ThemeProvider.dart';
import 'package:provider/provider.dart';

import '../../TypeOfFunctions.dart';

class CollapsingListTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final AnimationController animationController;
  final bool isSelected;
  final OnTapFunctionType onTap;

  CollapsingListTile(
      {required this.title,
      required this.icon,
      required this.animationController,
      this.isSelected = false,
      required this.onTap});

  @override
  _CollapsingListTileState createState() => _CollapsingListTileState();
}

class _CollapsingListTileState extends State<CollapsingListTile> {
  late Animation<double> widthAnimation, sizedBoxAnimation;

  @override
  void initState() {
    super.initState();
    widthAnimation =
        Tween<double>(begin: 260, end: 66).animate(widget.animationController);
    sizedBoxAnimation =
        Tween<double>(begin: 10, end: 0).animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          color: widget.isSelected
              ? Colors.transparent.withOpacity(0.3)
              : Colors.transparent,
        ),
        width: widthAnimation.value,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Row(
          children: <Widget>[
            Icon(
              widget.icon,
              color: widget.isSelected ? themeProvider.themeMode().iconSelectedColorOnPrimary : themeProvider.themeMode().iconColorOnPrimary,
              size: 24.0,
            ),
            SizedBox(width: sizedBoxAnimation.value),
            (widthAnimation.value >= 190)
                ? Text(widget.title,
                    style: widget.isSelected
                        ? TextStyle(color: themeProvider.themeMode().textSelectColorOnPrimary, fontWeight: FontWeight.w600)
                        : TextStyle(color: themeProvider.themeMode().textColorOnPrimary, fontWeight: FontWeight.w600))
                : Container()
          ],
        ),
      ),
    );
  }
}
