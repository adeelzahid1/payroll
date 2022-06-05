import "dart:io";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

typedef _AlertAction<T> = void Function(T index);

class DialogBoxMultiAction {
  DialogBoxMultiAction(
      {required this.cancelTitle,
      this.alertTitle = "Alert",
      this.alertDetailMessage = "",
      required this.alertActionTitles,
      required this.onAlertAction});

  String alertTitle;
  String alertDetailMessage;
  String cancelTitle;
  List<String> alertActionTitles;
  _AlertAction<int> onAlertAction;

  void show(BuildContext context) {
    List<Widget> actions = <Widget>[];
//Customize the cancel button as per the requirement
    Widget actionButton = FlatButton(
      child: Text(cancelTitle),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    actions.add(actionButton);
    for (int i = 0; i < alertActionTitles.length; i++) {
      Widget actionButton = FlatButton(
        child: Text(alertActionTitles[i]),
        onPressed: () {
          Navigator.pop(context);
          onAlertAction(i);
        },
      );
      actions.add(actionButton);
    }
// show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return _getAlertDialog(actions);
      },
    );
  }

  Widget _getAlertDialog(List<Widget> actions) {
    if (Platform.isIOS)
      return CupertinoAlertDialog(
          title: Text(alertTitle),
          content: Text(alertDetailMessage),
          actions: actions);
    else
      return AlertDialog(
          title: Text(alertTitle),
          content: Text(alertDetailMessage),
          actions: actions);
  }
}
