import 'package:flutter/material.dart';
import 'package:simple_book_log/const/sizes.dart';

class TemplateAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final double appBarElevation;

  final enableCloseButton;

  @override
  final Size preferredSize = Sizes.appBarSize;

  TemplateAppBar({
    Key? key,
    required this.title,
    required this.appBarElevation,
    this.enableCloseButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Sizes.appBarSize,
      child: AppBar(
        iconTheme: const IconThemeData(color: Colors.black26, size: 10),
        elevation: appBarElevation,
        title: Text(title),
        automaticallyImplyLeading: enableCloseButton,
      ),
    );
  }
}
