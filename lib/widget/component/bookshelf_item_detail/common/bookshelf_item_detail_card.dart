import 'package:flutter/material.dart';
import 'package:simple_book_log/const/borders.dart';
import 'package:simple_book_log/const/color_constants.dart';
import 'package:simple_book_log/const/fonts.dart';

class BookshelfItemDetailCard extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Widget child;

  const BookshelfItemDetailCard({
    Key? key,
    required this.iconData,
    required this.title,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border(bottom: BorderConstant.defaultBorderSide),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  iconData,
                  color: ColorConstants.accentColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    title,
                    style: FontConstants.textStyleBold,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          child,
        ],
      ),
    );
  }
}
