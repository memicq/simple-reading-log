import 'package:flutter/material.dart';
import 'package:simple_book_log/const/color_constants.dart';

class StatisticMenuRecentBookNotFound extends StatelessWidget {
  StatisticMenuRecentBookNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child: Text(
        "まだ本を読み終わった記録がないようです。",
        style: TextStyle(color: ColorConstants.grayTextColor),
      ),
    );
  }
}
