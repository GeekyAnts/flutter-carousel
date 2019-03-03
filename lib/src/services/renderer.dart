import 'package:flutter/material.dart';

typedef OnCall = Function(bool);
typedef Widget Builder(OnCall rebuild, bool active);

class Renderer extends StatefulWidget {
  final Builder builder;
  Renderer(this.builder);

  @override
  _RendererState createState() => _RendererState();
}

class _RendererState extends State<Renderer> {
  int data;
  bool active;

  @override
  initState() {
    super.initState();
    active = false;
  }

  updateRenderer(bool status) {
    setState(() {
      active = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(updateRenderer, active);
  }
}
