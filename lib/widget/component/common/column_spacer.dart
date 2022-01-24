import 'package:flutter/material.dart';

class ColumnSpacer extends StatelessWidget {
  const ColumnSpacer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 20,
      width: double.infinity,
    );
  }
}
