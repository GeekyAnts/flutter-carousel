import 'package:flutter/material.dart';

typedef OnCall = Function(bool);
typedef Widget Builder(OnCall rebuild, bool active);

class Renderer extends StatefulWidget {
  final Builder builder;
  final Key key;
  Renderer(this.key, this.builder) : super(key: key);

  @override
  RendererState createState() => RendererState();
}

class RendererState extends State<Renderer> {
  int data;
  bool active;

  @override
  initState() {
    super.initState();
    active = false;
  }

  updateRenderer(bool status, [String a]) {
    setState(() {
      active = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(updateRenderer, active);
  }
}
