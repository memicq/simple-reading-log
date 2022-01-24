import 'package:flutter/material.dart';
import 'package:simple_book_log/const/fonts.dart';

class StatisticMenuHabitItem extends StatelessWidget {
  final String title;
  final int value;
  StatisticMenuHabitItem({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Column(
          children: [
            Text(
              title,
              style: FontConstants.textStyleBold,
            ),
            SizedBox(height: 5),
            Text(
              value.toString(),
              style: TextStyle(fontSize: 40),
            ),
          ],
        ),
      ),
    );
  }
}
