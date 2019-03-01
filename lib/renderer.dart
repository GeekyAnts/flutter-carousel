import 'package:flutter/material.dart';

typedef OnCall = Function(int, [bool]);
typedef Widget Builder(int data, OnCall rebuild, bool active);

class Renderer extends StatefulWidget {
  final Builder builder;
  int currentPage;
  bool active;
  Widget child;

  Renderer(this.currentPage, @required this.builder);

  @override
  _RendererState createState() => _RendererState();
}

class _RendererState extends State<Renderer> {
  int data;
  bool active;

  @override
  initState() {
    super.initState();
    data = widget.currentPage;
    active = false;
  }

  updateRenderer(pageIndex, [bool status]) {
    setState(() {
      data = pageIndex;
      active = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(data, updateRenderer, active);
  }
}
