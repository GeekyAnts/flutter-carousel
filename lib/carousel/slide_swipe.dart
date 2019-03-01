import 'dart:math';
import 'package:flutter/material.dart';

class SlideSwipe extends StatelessWidget {
  PageController controller;
  int currentPage;
  bool initial = true;
  final dynamic props;

  SlideSwipe(
    this.props,
  ) {
    currentPage = 0;
    controller = props.controller;
  }

  initiate(index) {
    double value;

    if (index == currentPage - 1 && initial) value = 1.0;
    if (index == currentPage && initial) value = 0.0;
    if (index == currentPage + 1 && initial) {
      value = 1.0;
      initial = false;
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    initial = true;
    int count = props.children.length;
    Widget carouserBuilder = new PageView.builder(
        scrollDirection: props.axis,
        controller: controller,
        itemCount: count,
        onPageChanged: (i) {
           if (props.onPageChange != null) {
            props.onPageChange(i);
          }
          currentPage = i;
        },
        itemBuilder: (context, index) => builder(index, controller));
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Container(
          height: props.height,
          width: props.width,
          child: props.axis == Axis.horizontal
              ? carouserBuilder
              : Container(
                  child: carouserBuilder,
                ),
        ),
      ],
    );
  }

  builder(int index, PageController controller1) {
    return new AnimatedBuilder(
      animation: controller1,
      builder: (context, child) {
        double value = 1.0;
        value = initial
            ? initiate(index) ?? controller1.page - index
            : controller1.page - index;
        value = (1 - (value.abs() * .2)).clamp(0.0, 1.0);
        return new Opacity(
          opacity: pow(value, 4),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Center(
                child: new Container(
                  height: (props.height -
                          (props.axis == Axis.vertical
                              ? props.height / 5
                              : 0.0)) *
                      (props.axis == Axis.vertical ? 1.0 : value),
                  width: props.width * value,
                  child: props.children[index],
                  alignment: Alignment.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
