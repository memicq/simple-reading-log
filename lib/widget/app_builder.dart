import 'package:flutter/material.dart';

class AppBuilder extends StatefulWidget {
  final Function(BuildContext) builder;

  const AppBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  _AppBuilderState createState() => _AppBuilderState();

  static _AppBuilderState? of(BuildContext context) {
    return context.findAncestorStateOfType<_AppBuilderState>();
  }
}

class _AppBuilderState extends State<AppBuilder> {
  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }

  void rebuild() {
    setState(() {});
  }
}
