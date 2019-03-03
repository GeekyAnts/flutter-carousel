import 'package:flutter/material.dart';

class ScreenRatio {
  static double heightRatio;
  static double widthRatio;

  static setScreenRatio({context, Size size}) {
    // Size size = MediaQuery.of(context).size;
    heightRatio = size.height / 667.0;
    widthRatio = size.width / 375.0;
  }
}
