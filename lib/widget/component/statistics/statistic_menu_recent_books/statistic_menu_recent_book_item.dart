import 'package:flutter/material.dart';
import 'package:simple_book_log/const/borders.dart';
import 'package:simple_book_log/const/color_constants.dart';
import 'package:simple_book_log/util/datetime_util.dart';

class StatisticMenuRecentBookItem extends StatelessWidget {
  final String title;
  final DateTime? start;
  final DateTime end;

  StatisticMenuRecentBookItem({
    Key? key,
    required this.title,
    required this.start,
    required this.end,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String startDateString = start != null ? DateTimeUtil.toLocaleDateString(start!) : "不明";

    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(
          top: BorderConstant.defaultBorderSide,
          bottom: BorderConstant.defaultBorderSide,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                startDateString,
                style: TextStyle(color: ColorConstants.grayTextColor),
              ),
              Text(
                " - ",
                style: TextStyle(color: ColorConstants.grayTextColor),
              ),
              Text(
                DateTimeUtil.toLocaleDateString(end),
                style: TextStyle(color: ColorConstants.grayTextColor),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
