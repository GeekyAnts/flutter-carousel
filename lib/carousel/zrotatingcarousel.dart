import 'package:flutter/material.dart';
import 'dart:math' as math;

class ZcarouselState extends StatelessWidget {
  int currentPage;
  bool initial = true;
  final dynamic props;
  ZcarouselState(
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
    int count = props.children.length;

    Widget carouselBuilder = new PageView.builder(
        controller: props.controller,
        scrollDirection: props.axis,
        itemCount: count,
        onPageChanged: (i) {
          currentPage = i;
        },
        itemBuilder: (context, index) => builder(index));
    return Center(
      child: new Container(
        height: props.height,
        width: props.width,
        child: props.axis == Axis.horizontal
            ? carouselBuilder
            : Container(
                child: carouselBuilder,
              ),
      ),
    );
  }

  builder(int index) {
    Matrix4 _pmat(num pv) {
      return new Matrix4(
        1.0, 0.0, 0.0, 0.0, //
        0.0, 1.0, 0.0, 0.0, //
        0.0, 0.0, 1.0, pv * 0.001, //
        0.0, 0.0, 0.0, 1.0,
      );
    }

    Matrix4 perspective = _pmat(1.0);
    return new AnimatedBuilder(
      animation: props.controller,
      builder: (context, child) {
        double value = 1.0;
        value = initial
            ? initiate(index) ?? props.controller1.page - index
            : value = props.controller.page - index;
        value = (1 - (value.abs() * 0.2)).clamp(0.0, 1.0);
        return new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Transform(
              alignment: FractionalOffset.center,
              transform: perspective.scaled(1.0, 1.0, 1.0)
                ..rotateX(0.0)
                ..rotateY(((value) * 3393) / 90)
                ..rotateZ(0.0),
              child: new Opacity(
                opacity: math.pow(value, 2),
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
            ),
          ],
        );
      },
    );
  }
}
