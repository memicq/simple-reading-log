import 'package:flutter/material.dart';
import 'package:simple_book_log/const/color_constants.dart';

class BookSelectionNoResult extends StatelessWidget {
  BookSelectionNoResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 80),
            Icon(
              Icons.search_off_outlined,
              size: 100,
              color: ColorConstants.grayTextColor,
            ),
            const SizedBox(height: 10),
            Text(
              "結果がありません",
              style: TextStyle(color: ColorConstants.grayTextColor),
            )
          ],
        ),
      ),
    );
  }
}
