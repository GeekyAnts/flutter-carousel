import 'package:flutter_multi_carousel/src/indicator/widget/bar_indicator.dart';
import 'package:flutter_multi_carousel/src/indicator/widget/bubble_indicator.dart';
import 'package:flutter_multi_carousel/src/indicator/widget/dot_indicator.dart';
import 'package:flutter_multi_carousel/src/indicator/widget/props.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_carousel/src/services/type_declaration.dart';

class Indicator extends StatelessWidget {
  final int currentPage;
  final dynamic indicatorName;
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
  var indicatorName,
  Props props,
) {
  IndicatorTypes indicatorType = indicatorName.runtimeType == IndicatorTypes
      ? indicatorName
      : _getIndicatorType(indicatorName);

  Widget indicator;

  switch (indicatorType) {
    case IndicatorTypes.bar:
      {
        indicator = BarIndicator(
          props: props,
        );
      }
      break;
    case IndicatorTypes.bubble:
      {
        indicator = BubbleIndicator(
          props: props,
        );
      }
      break;
    case IndicatorTypes.dot:
      {
        indicator = DotIndicator(
          props: props,
        );
      }
      break;
    default:
      return SizedBox();
  }
  return indicator;
}

IndicatorTypes _getIndicatorType(String indicatorName) {
  switch (indicatorName) {
    case "bar":
      {
        return IndicatorTypes.bar;
      }
      break;
    case "bubble":
      {
        return IndicatorTypes.bubble;
      }
      break;
    case "dot":
      {
        return IndicatorTypes.dot;
      }
      break;
    default:
      return null;
  }
}
