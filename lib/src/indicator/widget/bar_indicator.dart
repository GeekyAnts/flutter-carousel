import 'package:flutter/material.dart';
import 'package:flutter_multi_carousel/src/indicator/widget/props.dart';

class BarIndicator extends AnimatedWidget {
  final Props props;
  BarIndicator({this.props}) : super(listenable: props.controller);
  @override
  Widget build(BuildContext context) {
    return new Container(
        alignment: Alignment.topLeft,
        height: 4.0,
        width: ((props.width) * .80),
        color: props.unSelectedColor ?? Color(0xff4C5158),
        padding: new EdgeInsets.only(
          left: (((props.width * 0.8) / props.totalPage) *
              (props.controller.page ?? props.controller.initialPage)),
        ),
        child: new Container(
          width: (props.width * 0.8) / props.totalPage,
          color: props.selectedColor ?? Colors.black,
        ));
  }
}
