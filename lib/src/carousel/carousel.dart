import 'package:flutter/material.dart';
import 'package:flutter_multi_carousel/src/carousel/multi_axis_carousel.dart';
import 'package:flutter_multi_carousel/src/carousel/rotatingcarousel.dart';
import 'package:flutter_multi_carousel/src/carousel/simple_carousel.dart';
import 'package:flutter_multi_carousel/src/carousel/slide_swipe.dart';
import 'package:flutter_multi_carousel/src/carousel/x_rotating_carousel.dart';
import 'package:flutter_multi_carousel/src/carousel/zrotatingcarousel.dart';
import 'package:flutter_multi_carousel/src/indicator/index.dart';
import 'package:flutter_multi_carousel/src/services/renderer.dart';
import 'package:flutter_multi_carousel/src/services/screen_ratio.dart';

class Carousel extends StatefulWidget {
  final String type;

  final Axis axis;

  /// This feild is required.
  ///
  /// Defines the height of the Carousel
  final double height;

  /// Defines the width of the Carousel
  final double width;

  final List<Widget> children;

  ///  callBack function on page Change
  final onPageChange;

  /// Defines the Color of the active Indicator
  final Color activeIndicatorColor;

  ///defines type of indicator to carousel
  final String indicatorType;

  final bool showArrow;

  ///defines the arrow colour
  final Color arrowColor;

  ///choice to show indicator
  final bool showIndicator;

  /// Defines the Color of the non-active Indicator
  final Color unActiveIndicatorColor;

  /// Paint the background of indicator with the color provided
  ///
  /// The default background color is Color(0xff121212)
  final Color indicatorBackgroundColor;

  /// Provide opacity to background of the indicator
  ///
  /// An opacity of 1.0 is fully opaque. An opacity of 0.0 is fully transparent
  /// (i.e., invisible).
  ///
  /// The default value of opacity is 0.5 nothing is initialised.
  ///

  final double indicatorBackgroundOpacity;
  dynamic updateIndicator;
  PageController controller;

  Carousel(
      {Key key,
      @required this.height,
      @required this.width,
      @required this.type,
      this.axis,
      this.showArrow,
      this.arrowColor,
      this.onPageChange,
      this.showIndicator = true,
      this.indicatorType,
      this.indicatorBackgroundOpacity,
      this.unActiveIndicatorColor,
      this.indicatorBackgroundColor,
      this.activeIndicatorColor,
      @required this.children})
      : super(key: key) {
    this.createState();
  }
  @override
  createState() {
    return _CarouselState();
  }
}

class _CarouselState extends State<Carousel> {
  int position = 0;
  double animatedFactor;
  double offset;

  @override
  dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  scrollPosition(dynamic updateRender, {String function}) {
    updateRender(false);

    if ((widget.controller.page.round() == 0 && function == "back") ||
        widget.controller.page == widget.children.length - 1 &&
            function != "back") {
      widget.controller.jumpToPage(
          widget.controller.page.round() == 0 && function == "back"
              ? widget.children.length - 1
              : 0);
    } else {
      widget.controller.animateToPage(
          (function == "back"
              ? (widget.controller.page.round() - 1)
              : (widget.controller.page.round() + 1)),
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 500));
    }
  }

  @override
  Widget build(BuildContext context) {
    offset = widget.type == "slideswiper" ? 0.8 : 1.0;
    Size size = MediaQuery.of(context).size;
    ScreenRatio.setScreenRatio(size: size);
    animatedFactor =
        widget.axis == Axis.horizontal ? widget.width : widget.height;
    widget.controller = new PageController(
      initialPage: 0,
      keepPage: true,
      viewportFraction: offset,
    );
    return Container(
        child: Stack(
      children: <Widget>[
        Center(child: getCarousel(widget)),
        Container(
            margin: EdgeInsets.only(top: widget.height / 4),
            child: widget.showArrow == null || widget.showArrow == false
                ? SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[]..addAll(["back", "forward"]
                        .map((f) => Renderer((updateRender, active) {
                              return GestureDetector(
                                onTapUp: (d) {
                                  scrollPosition(updateRender, function: f);
                                },
                                onTapDown: (d) {
                                  updateRender(true);
                                },
                                onLongPress: () {
                                  scrollPosition(updateRender, function: f);
                                },
                                child: Container(
                                  height: widget.height / 2,
                                  width: 40.0,
                                  color: active
                                      ? Color(0x77121212)
                                      : Colors.transparent,
                                  child: Icon(
                                    f == "back"
                                        ? Icons.arrow_back_ios
                                        : Icons.arrow_forward_ios,
                                    color: active
                                        ? Colors.white
                                        : widget.arrowColor != null
                                            ? widget.arrowColor
                                            : Colors.black,
                                  ),
                                ),
                              );
                            }))),
                  )),
        widget.showIndicator != true
            ? SizedBox()
            : Container(
                height: widget.height,
                alignment: Alignment.bottomCenter,
                child: Wrap(
                  children: <Widget>[
                    Container(
                      width: widget.width,
                      alignment: Alignment.bottomCenter,
                      color:
                          (widget.indicatorBackgroundColor ?? Color(0xff121212))
                              .withOpacity(
                                  widget.indicatorBackgroundOpacity ?? 0.5),
                      padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                      child: Indicator(
                        indicatorName: widget.indicatorType,
                        selectedColor: widget.activeIndicatorColor,
                        unSelectedColor: widget.unActiveIndicatorColor,
                        totalPage: widget.children.length,
                        width: widget.width,
                        controller: widget.controller,
                      ),
                    ),
                  ],
                ),
              ),
      ],
    ));
  }

  getCarousel(dynamic widget) {
    dynamic carousel;
    switch (widget.type.toLowerCase()) {
      case "simple":
        {
          carousel = SimpleCarousel(widget);
        }
        break;
      case "slideswiper":
        {
          carousel = SlideSwipe(widget);
        }
        break;

      case "xrotating":
        {
          carousel = XcarouselState(widget);
        }
        break;
      case "yrotating":
        {
          carousel = RotatingCarouselState(widget);
        }
        break;
      case "zrotating":
        {
          carousel = ZcarouselState(widget);
        }
        break;
      case "multirotating":
        {
          carousel = MultiAxisCarouselState(widget);
        }
        break;
      default:
        carousel = SimpleCarousel(widget);
        break;
    }
    return carousel;
  }
}
