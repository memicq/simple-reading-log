import 'package:flutter/material.dart';

class Shadows {
  static BoxShadow mainShadow = const BoxShadow(
    color: Colors.black26,
    spreadRadius: 1,
    blurRadius: 2,
  );

  static BoxShadow mainShadowBottom = const BoxShadow(
    color: Colors.black12,
    blurRadius: 1.0,
    offset: Offset(0, 2.0),
  );
}
