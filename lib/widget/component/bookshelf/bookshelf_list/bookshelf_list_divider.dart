import 'package:flutter/material.dart';

class BookshelfListDivider extends StatelessWidget {
  final String title;

  BookshelfListDivider({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 20,
      width: double.infinity,
      color: Colors.grey.shade200,
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 12,
          ),
          strutStyle: const StrutStyle(
            fontSize: 12.0,
            height: 1.3,
          ),
        ),
      ),
    );
  }
}
