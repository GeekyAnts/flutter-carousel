import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_multi_carousel/indicator/widget/props.dart';
import 'package:flutter_multi_carousel/services/screen_ratio.dart';

class DotIndicator extends AnimatedWidget {
  Color selectedColor;
  Color unselectedColor;
  Animatable<Color> background;
  final Props props;
  final double wf = ScreenRatio.widthRatio;

  DotIndicator({this.props}) : super(listenable: props.controller) {
    selectedColor = props.selectedColor ?? Colors.white;
    unselectedColor = props.unSelectedColor ?? Colors.transparent;
    background = TweenSequence<Color>([
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: unselectedColor,
          end: selectedColor,
        ),
      ),
    ]);
  }

  transformValue(index) {
    double value;
    if (props.controller.hasClients) {
      value = max(
        0.0,
        1.0 - ((props.controller.page ?? 0.0) - index).abs(),
      );
    }
    return value ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        alignment: Alignment.topLeft,
        height: 20.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[]..addAll(List.generate(
              props.totalPage,
              (int index) => Container(
                    child: Center(
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 100),
                        height: (((props.width * wf) / (props.totalPage))
                            .clamp(1.0, 8.0)),
                        width: (((props.width * wf) / (props.totalPage))
                            .clamp(1.0, 8.0)),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: selectedColor),
                            color: transformValue(index) > 0.1
                                ? background.evaluate(AlwaysStoppedAnimation(
                                    transformValue(index)))
                                : unselectedColor),
                      ),
                    ),
                  )).toList()),
        ));
  }
}
