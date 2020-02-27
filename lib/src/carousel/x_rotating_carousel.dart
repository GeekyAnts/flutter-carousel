import 'package:flutter/material.dart';
import 'dart:math' as math;

class XcarouselState extends StatelessWidget {
  int currentPage;
  bool initial = true;
  final dynamic props;

  XcarouselState(this.props) {
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
    initial = true;
    Widget caouselBuilder = new PageView.builder(
        controller: props.controller,
        scrollDirection: props.axis,
        itemCount: count,
        onPageChanged: (i) {
          props.updatePositionCallBack(i);
          if (props.onPageChange != null) {
            props.onPageChange(i);
          }
          currentPage = i;
        },
        itemBuilder: (context, index) => builder(index));
    return Center(
      child: new Container(
        height: props.height,
        width: props.width,
        margin: new EdgeInsets.only(bottom: 5.0),
        child: props.axis == Axis.horizontal
            ? caouselBuilder
            : Container(
                child: caouselBuilder,
              ),
      ),
    );
  }

  builder(
    int index,
  ) {
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
            ? initiate(index) ??
                //  props.controller.page - index
                0
            : props.controller.page - index;
        value = (1 - (value.abs())).clamp(0.0, 1.0);
        return new Transform(
          alignment: FractionalOffset.center,
          transform: perspective.scaled(1.0, 1.0, 1.0)
            ..rotateX((value * ((180 * 6) + 50.0)) / 180)
            ..rotateY(0.0)
            ..rotateZ(0.0),
          child: new Opacity(
            opacity: math.pow(value, 4),
            child: new Material(
              elevation: (value > 0.9 ? 50.0 : 0.0),
              child: new Container(
                height: (props.height) * value,
                width: props.width,
                child: props.children[index],
              ),
            ),
          ),
        );
      },
    );
  }
}
