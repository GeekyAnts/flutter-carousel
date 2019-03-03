import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_multi_carousel/src/indicator/widget/props.dart';
import 'package:flutter_multi_carousel/src/services/screen_ratio.dart';

class BubbleIndicator extends AnimatedWidget {
  final Props props;
  BubbleIndicator({
    this.props,
  }) : super(listenable: props.controller);
  transformValue(index) {
    if (props.controller.hasClients) {
      return props.controller.hasClients
          ? 1.0 +
              (Curves.easeOut.transform(
                max(
                  0.0,
                  1.0 -
                      ((props.controller.page ?? props.controller.initialPage) -
                              index)
                          .abs(),
                ),
              ))
          : 1.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    double wf = ScreenRatio.widthRatio;
    return new Container(
      alignment: Alignment.topLeft,
      height: 40.0,
      child: Center(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[]
              ..addAll(List.generate(props.totalPage, (int index) {
                return Center(
                  child: Container(
                    width:
                        ((props.width * wf) / props.totalPage).clamp(2.0, 40.0),
                    child: Center(
                      child: Container(
                        height: (((props.width * wf) / (props.totalPage * 2))
                                .clamp(1.0, 8.0)) *
                            transformValue(index),
                        width: (((props.width * wf) / (props.totalPage * 2))
                                .clamp(1.0, 8.0)) *
                            transformValue(index),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: props.selectedColor ?? Colors.white),
                      ),
                    ),
                  ),
                );
              }))),
      ),
    );
  }
}
