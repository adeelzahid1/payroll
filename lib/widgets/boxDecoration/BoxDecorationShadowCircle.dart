

import 'package:flutter/material.dart';

Decoration BoxDecorationShadowCircle () {

  return BoxDecoration(boxShadow: [

    BoxShadow(
        color: Colors.blue[900]!.withOpacity(0.2),
        blurRadius: 20,
        spreadRadius: 2,
        offset: Offset(5, 0)),
    BoxShadow(
        color: Colors.white12,
        blurRadius: 0,
        spreadRadius: -2,
        offset: Offset(0, 0)),
  ], shape: BoxShape.circle, color: Colors.white24);
}


Decoration BoxDecorationShadowRectangle () {

  return BoxDecoration(boxShadow: [

    BoxShadow(
        color: Colors.blue[900]!.withOpacity(0.2),
        blurRadius: 10,
        spreadRadius: 2,
        offset: Offset(2, 0)),
    BoxShadow(
        color: Colors.white,
        blurRadius: 0,
        spreadRadius: -2,
        offset: Offset(0, 0)),
  ], shape: BoxShape.rectangle, color: Colors.white70);
}
Decoration BoxDecorationShadowRectangleDark () {

  return BoxDecoration(boxShadow: [

    BoxShadow(
        color: Colors.blue[500]!.withOpacity(0.2),
        blurRadius: 10,
        spreadRadius: 2,
        offset: Offset(2, 0)),
    BoxShadow(
        color: Colors.white12,
        blurRadius: 0,
        spreadRadius: -2,
        offset: Offset(0, 0)),
  ], shape: BoxShape.rectangle, color: Colors.white10);
}