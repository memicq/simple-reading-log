import 'package:flutter/material.dart';
import 'package:simple_book_log/const/color_constants.dart';

class BookshelfBooksNotFound extends StatelessWidget {
  BookshelfBooksNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 80),
            Icon(
              Icons.lightbulb_outline,
              size: 100,
              color: ColorConstants.grayTextColor,
            ),
            const SizedBox(height: 10),
            Text(
              "まだ本棚に本がありません",
              style: TextStyle(color: ColorConstants.grayTextColor),
            ),
            const SizedBox(height: 20),
            Text(
              "右下のボタンを押して、",
              style: TextStyle(color: ColorConstants.grayTextColor),
            ),
            Text(
              "新しく本を追加してみてください！",
              style: TextStyle(color: ColorConstants.grayTextColor),
            )
          ],
        ),
      ),
    );
  }
}
