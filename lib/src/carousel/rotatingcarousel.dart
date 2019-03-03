import 'package:flutter/material.dart';
import 'dart:math';

class RotatingCarouselState extends StatelessWidget {
  int currentPage;
  bool initial = true;
  final dynamic props;
  RotatingCarouselState(this.props) {
    currentPage = 0;
  }

  initiate(index) {
    double value;
    if (index == currentPage && initial) value = 0.0;
    initial = false;
    return value;
  }

  @override
  Widget build(BuildContext context) {
    int count = props.children.length;

    Widget caroselBuilder = new PageView.builder(
        scrollDirection: props.axis,
        controller: props.controller,
        itemCount: count,
        onPageChanged: (i) {
          if (props.onPageChange != null) {
            props.onPageChange(i);
          }
          currentPage = i;
        },
        itemBuilder: (context, index) => builder(index, props.controller));
    return new Center(
        child: new Container(
      height: props.height,
      width: props.width,
      child: props.axis == Axis.horizontal
          ? caroselBuilder
          : Container(
              child: caroselBuilder,
            ),
    ));
  }

  builder(int index, controller1) {
    return new AnimatedBuilder(
      animation: controller1,
      builder: (context, child) {
        double value = 1.0;
        value = initial
            ? initiate(index) ?? controller1.page - index
            : controller1.page - index;
        value = (1 - (value.abs() * .2)).clamp(0.0, 1.0);
        return new RotationTransition(
          turns: new AlwaysStoppedAnimation((value * ((180 * 6))) / 180),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Opacity(
                opacity: pow(value, 4),
                child: new Material(
                  borderRadius: new BorderRadius.circular(
                      (5 - ((1.0 - value) * 25)).clamp(0.1, 5.0)),
                  elevation: (value > 0.9 ? 50.0 : 0.0),
                  child: new Container(
                    height: props.height * value,
                    width: props.width * value,
                    child: props.children[index],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
