library carousel;

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
import 'package:flutter_multi_carousel/src/services/type_declaration.dart';

typedef OnCarouselTap = Function(int);

class Carousel extends StatefulWidget {
  final dynamic type;

  ///The scroll Axis of Carousel
  final Axis axis;

  final int initialPage;

  dynamic updatePositionCallBack;

  /// call back function triggers when gesture tap is registered
  final OnCarouselTap onCarouselTap;

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
  final dynamic indicatorType;

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

  /// Defines if the carousel should wrap once you reach the end or if your at the begining and go left if it should take you to the end
  ///
  /// The default behavior is to allow wrapping
  final bool allowWrap;

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
  int currentPage = 0;

  GlobalKey key;

  Carousel(
      {this.key,
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
      this.allowWrap = true,
      this.initialPage,
      this.onCarouselTap,
      @required this.children})
      : assert(initialPage >= 0 && initialPage < children.length,
            "intialPage must be a int value between 0 and length of children"),
        super(key: key) {
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
  final GlobalKey<RendererState> rendererKey1 = new GlobalKey();
  final GlobalKey<RendererState> rendererKey2 = new GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    widget.updatePositionCallBack = updatePosition;
    super.initState();
  }

  @override
  dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  updatePosition(int index) {
    if (widget.controller.page.round() == widget.children.length - 1) {
      rendererKey2.currentState.updateRenderer(false);
    }
    if (widget.controller.page.round() == widget.children.length - 2) {
      rendererKey2.currentState.updateRenderer(false);
    }
    if (widget.controller.page.round() == 1) {
      rendererKey1.currentState.updateRenderer(false);
    }
    if (widget.controller.page.round() == 0) {
      rendererKey1.currentState.updateRenderer(false);
    }
  }

  scrollPosition(dynamic updateRender, {String function}) {
    updateRender(false);

    if ((widget.controller.page.round() == 0 && function == "back") ||
        widget.controller.page == widget.children.length - 1 &&
            function != "back") {
      if (widget.allowWrap) {
        widget.controller.jumpToPage(
            widget.controller.page.round() == 0 && function == "back"
                ? widget.children.length - 1
                : 0);
      }
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
    offset = (widget.type.toString().toLowerCase() == "slideswiper" ||
            widget.type == Types.slideSwiper)
        ? 0.8
        : 1.0;
    Size size = MediaQuery.of(context).size;
    ScreenRatio.setScreenRatio(size: size);
    animatedFactor =
        widget.axis == Axis.horizontal ? widget.width : widget.height;
    widget.controller = new PageController(
      initialPage: widget.initialPage ?? 0,
      keepPage: true,
      viewportFraction: offset,
    );
    dynamic carousel = _getCarousel(widget);
    return Container(
        child: Stack(
      children: <Widget>[
        Center(
            child: GestureDetector(
          child: carousel,
          onTap: () {
            if (widget.onCarouselTap != null) {
              widget.onCarouselTap(widget.controller.page.round());
            }
          },
        )),
        Center(
          child: Container(
              height: widget.height,
              child: widget.showArrow == null || widget.showArrow == false
                  ? SizedBox()
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[]..addAll([
                          "back",
                          "forward"
                        ].map((f) =>
                            Renderer(f == 'back' ? rendererKey1 : rendererKey2,
                                (updateRender, active) {
                              return Visibility(
                                visible: widget.allowWrap
                                    ? true
                                    : (f == 'back' &&
                                                widget?.controller?.page
                                                        ?.round() ==
                                                    0 ||
                                            f == 'forward' &&
                                                widget.controller.page
                                                        ?.round() ==
                                                    widget.children.length - 1
                                        ? false
                                        : true),
                                child: GestureDetector(
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
                                ),
                              );
                            }))),
                    )),
        ),
        Center(
          child: widget.showIndicator != true
              ? SizedBox()
              : Container(
                  height: widget.height,
                  alignment: Alignment.bottomCenter,
                  child: Wrap(
                    children: <Widget>[
                      Container(
                        width: widget.width,
                        alignment: Alignment.bottomCenter,
                        color: (widget.indicatorBackgroundColor ??
                                Color(0xff121212))
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
        ),
      ],
    ));
  }

  _getCarousel(Carousel widget) {
    dynamic carousel;
    dynamic type = widget.type.runtimeType == Types
        ? widget.type
        : _getType(widget.type.toLowerCase());

    switch (type) {
      case Types.simple:
        {
          carousel = SimpleCarousel(widget);
        }
        break;
      case Types.slideSwiper:
        {
          carousel = SlideSwipe(widget);
        }
        break;

      case Types.xRotating:
        {
          carousel = XcarouselState(widget);
        }
        break;
      case Types.yRotating:
        {
          carousel = RotatingCarouselState(widget);
        }
        break;
      case Types.zRotating:
        {
          carousel = ZcarouselState(widget);
        }
        break;
      case Types.multiRotating:
        {
          carousel = MultiAxisCarouselState(widget);
        }
        break;
      // default:
      //   carousel = SimpleCarousel(widget);
      //   break;
    }
    return carousel;
  }
}

_getType(String type) {
  switch (type) {
    case "simple":
      {
        return Types.simple;
      }
      break;
    case "slideswiper":
      {
        return Types.slideSwiper;
      }
      break;

    case "xrotating":
      {
        return Types.xRotating;
      }
      break;
    case "yrotating":
      {
        return Types.yRotating;
      }
      break;
    case "zrotating":
      {
        return Types.zRotating;
      }
      break;
    case "multirotating":
      {
        return Types.multiRotating;
      }
      break;
  }
}
