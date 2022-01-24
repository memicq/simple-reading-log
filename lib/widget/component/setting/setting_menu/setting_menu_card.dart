import 'package:flutter/material.dart';
import 'package:simple_book_log/const/borders.dart';

class SettingMenuCard extends StatelessWidget {
  final Widget child;

  const SettingMenuCard({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderConstant.defaultBorderSide,
          bottom: BorderConstant.defaultBorderSide,
        ),
      ),
      child: child,
    );
  }
}
