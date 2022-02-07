import 'package:flutter/material.dart';
import 'package:simple_book_log/const/borders.dart';
import 'package:simple_book_log/const/color_constants.dart';
import 'package:simple_book_log/const/fonts.dart';

class StatisticMenuCard extends StatefulWidget {
  final String title;
  final Widget child;
  final bool closable;
  final Color mainColor;

  const StatisticMenuCard({
    Key? key,
    required this.title,
    required this.child,
    required this.mainColor,
    this.closable = true,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => StatisticMenuCardState();
}

class StatisticMenuCardState extends State<StatisticMenuCard> {
  bool _isOpened = true;

  void onPressedToggleButton() {
    setState(() {
      _isOpened = !_isOpened;
    });
  }

  @override
  Widget build(BuildContext context) {
    double? contentHeight = _isOpened ? null : 0;
    Widget content = _isOpened ? widget.child : Container();
    IconData _toggleButtonIconData =
        _isOpened ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded;

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
              border: Border(
                bottom: BorderConstant.defaultBorderSide,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.insert_chart_outlined_rounded,
                  color: widget.mainColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    widget.title,
                    style: FontConstants.textStyleBold,
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  height: 25,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      _toggleButtonIconData,
                      color: ColorConstants.grayTextColor,
                    ),
                    onPressed: () => onPressedToggleButton(),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            child: SizedBox(
              height: contentHeight,
              child: content,
            ),
          )
        ],
      ),
    );
  }
}
