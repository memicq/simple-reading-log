import 'package:flutter/material.dart';
import 'package:simple_book_log/const/color_constants.dart';

class BottomTabItem extends StatefulWidget {
  final bool isActive;

  final IconData iconData;
  final IconData filledIconData;
  final String menuTitle;

  final Function() onPressed;

  BottomTabItem({
    Key? key,
    this.isActive = false,
    required this.iconData,
    required this.filledIconData,
    required this.menuTitle,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => BottomTabItemState();
}

class BottomTabItemState extends State<BottomTabItem> {
  @override
  Widget build(BuildContext context) {
    Icon icon = widget.isActive
        ? Icon(
            widget.filledIconData,
            color: ColorConstants.accentColor,
            size: 25,
          )
        : Icon(
            widget.iconData,
            color: ColorConstants.disabledTextColor,
            size: 22,
          );

    Text text = widget.isActive
        ? Text(
            widget.menuTitle,
            style: TextStyle(
              color: ColorConstants.accentColor,
              fontSize: 10,
            ),
          )
        : Text(
            widget.menuTitle,
            style: TextStyle(
              color: ColorConstants.disabledTextColor,
              fontSize: 10,
            ),
          );

    return Expanded(
      child: TextButton(
        onPressed: widget.onPressed,
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.black12),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            text,
          ],
        ),
      ),
    );
  }
}
