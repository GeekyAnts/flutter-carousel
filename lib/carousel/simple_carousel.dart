import 'package:flutter/material.dart';
import 'dart:math' as math;

class SimpleCarousel extends StatelessWidget {
  Widget carouserBuilder;

  int currentPage;
  bool initial = true;
  final dynamic props;

  SimpleCarousel(
    this.props,
  ) {
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
    initial = true;
    currentPage = 0;
    carouserBuilder = new PageView.builder(
        scrollDirection: props.axis,
        controller: props.controller,
        itemCount: props.children.length,
        onPageChanged: (i) {
          currentPage = i;
          if (props.onPageChange != null) {
            props.onPageChange(i);
          }
        },
        itemBuilder: (context, index) => builder(index, props.controller));
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Container(
          color: Colors.transparent,
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
    initial = true;
    return new AnimatedBuilder(
      animation: controller1,
      builder: (context, child) {
        double value = 1.0;
        value = initial
            ? initiate(index) ?? controller1.page - index
            : controller1.page - index;
        value = (1 - (value.abs())).clamp(0.0, 1.0);
        return new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Opacity(
              opacity: math.pow(value, 1.2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    height: (props.height) * math.pow(value, 5),
                    width: (props.width) * math.pow(value, 5),
                    child: props.children[index],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
