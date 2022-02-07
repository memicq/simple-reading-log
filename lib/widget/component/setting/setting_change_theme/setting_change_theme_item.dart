import 'package:flutter/material.dart';
import 'package:simple_book_log/const/borders.dart';
import 'package:simple_book_log/const/color_constants.dart';
import 'package:simple_book_log/resource/model/enum/application_theme.dart';

class SettingChangeThemeItem extends StatelessWidget {
  final String title;
  final Color color;
  final bool isSelected;
  final Future<void> Function() onPressed;

  SettingChangeThemeItem({
    Key? key,
    required this.title,
    required this.color,
    required this.onPressed,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorConstants.mainBgColor,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border(
              top: BorderConstant.defaultBorderSide,
              bottom: BorderConstant.defaultBorderSide,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 30,
                height: 30,
                color: color,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(title),
              if (isSelected)
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "選択中",
                      style: TextStyle(color: ColorConstants.grayTextColor),
                    ),
                  ),
                ),
              SizedBox(width: 10)
            ],
          ),
        ),
      ),
    );
  }
}
