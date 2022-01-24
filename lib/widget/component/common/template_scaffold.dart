import 'package:flutter/material.dart';
import 'package:simple_book_log/widget/component/common/template_app_bar.dart';

class TemplateScaffold extends StatelessWidget {
  final Widget body;
  final String title;

  final double appBarElevation;

  const TemplateScaffold({
    Key? key,
    required this.title,
    required this.body,
    this.appBarElevation = 1.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TemplateAppBar(
        title: title,
        appBarElevation: appBarElevation,
      ),
      body: body,
    );
  }
}
