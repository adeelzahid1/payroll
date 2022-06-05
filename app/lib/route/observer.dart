import 'package:flutter/material.dart';

import 'nav_stack.dart';

class CustomRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);

    // TRY TO REMOVE FOCUS FROM SEARCH BAR
    final focus = FocusManager.instance.primaryFocus;
    focus?.unfocus();

    final _screenName = route.settings.name;
    // print('>>>>>> Pushed Route is $_screenName');
    _navStack.push(_screenName);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);

    // final _screenName = route.settings.name;
    // _navStack.pop();
    // print('>>>>>> Popped Route is $_screenName ');
  }

  final NavStack<String?> _navStack = NavStack<String?>();

  NavStack<String?> get navStack => _navStack;
}
