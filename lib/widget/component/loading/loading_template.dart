import 'package:flutter/material.dart';
import 'package:simple_book_log/const/color_constants.dart';

class LoadingTemplate extends StatelessWidget {
  LoadingTemplate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: ColorConstants.grayTextColor,
        ),
      ),
    );
  }
}
