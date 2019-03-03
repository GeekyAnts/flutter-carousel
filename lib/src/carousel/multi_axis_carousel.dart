import 'package:flutter/material.dart';
import 'dart:math' as math;

class MultiAxisCarouselState extends StatelessWidget {
  int currentPage;
  bool initial = true;
  final dynamic props;
  MultiAxisCarouselState(
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
          if (props.onPageChange != null) {
            props.onPageChange(i);
          }
        },
        itemBuilder: (context, index) => builder(index, props.controller));
    return Center(
      child: Container(
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

  builder(int index, controller1) {
    Matrix4 _pmat(num pv) {
      return Matrix4(
        1.0, 0.0, 0.0, 0.0, //
        0.0, 1.0, 0.0, 0.0, //
        0.0, 0.0, 1.0, pv * 0.001, //
        0.0, 0.0, 0.0, 1.0,
      );
    }

    Matrix4 perspective = _pmat(1.0);
    return AnimatedBuilder(
      animation: controller1,
      builder: (context, child) {
        double value = 1.0;
        value = initial
            ? initiate(index) ?? controller1.page - index
            : value = controller1.page - index;
        value = (1 - (value.abs() * 0.2)).clamp(0.0, 1.0);
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RotationTransition(
              turns: AlwaysStoppedAnimation(1800 * (value) / 360),
              child: Transform(
                alignment: FractionalOffset.center,
                transform: perspective.scaled(1.0, 1.0, 1.0)
                  ..rotateX(0.0)
                  ..rotateY(((value) * 3393) / 90)
                  ..rotateZ(0.0),
                child: Opacity(
                  opacity: math.pow(value, 4),
                  child: Container(
                    color: Colors.green,
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
