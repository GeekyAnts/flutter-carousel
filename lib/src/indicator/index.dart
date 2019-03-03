import 'package:flutter_multi_carousel/src/indicator/widget/bar_indicator.dart';
import 'package:flutter_multi_carousel/src/indicator/widget/bubble_indicator.dart';
import 'package:flutter_multi_carousel/src/indicator/widget/dot_indicator.dart';
import 'package:flutter_multi_carousel/src/indicator/widget/props.dart';
import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final int currentPage;
  final String indicatorName;
  final Color selectedColor;
  final Color unSelectedColor;
  final int totalPage;
  final double width;
  final PageController controller;

  Indicator({
    this.currentPage,
    this.indicatorName,
    this.selectedColor,
    this.unSelectedColor,
    this.width,
    this.totalPage,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    Props props = Props(
        currentPage: currentPage,
        selectedColor: selectedColor,
        totalPage: this.totalPage,
        unSelectedColor: unSelectedColor,
        width: width,
        controller: controller);
    return getIndicator(indicatorName, props);
  }
}

Widget getIndicator(
  String indicatorName,
  Props props,
) {
  Widget indicator;
  switch (indicatorName) {
    case "bar":
      {
        indicator = BarIndicator(
          props: props,
        );
      }
      break;
    case "bubble":
      {
        indicator = BubbleIndicator(
          props: props,
        );
      }
      break;
    case "dot":
      {
        indicator = DotIndicator(
          props: props,
        );
      }
      break;
  }
  return indicator;
}
