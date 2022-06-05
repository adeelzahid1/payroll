import 'package:flutter/material.dart';

class InheritedProvider<T> extends InheritedWidget {
  T inheritedData;

  InheritedProvider({
    required Widget child,
    required this.inheritedData,
  }) : super(child: child);

  @override
  bool updateShouldNotify(InheritedProvider oldWidget) =>
      inheritedData != oldWidget.inheritedData;


  //static T of<T>(BuildContext context) =>   (context.inheritFromWidgetOfExactType(InheritedProvider<T>().runtimeType) as InheritedProvider<T>).inheritedData;


  static T of<T>(BuildContext context) {
      return (context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>())!.inheritedData;
  }
}
