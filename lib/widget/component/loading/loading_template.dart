import 'package:flutter/material.dart';

class LoadingTemplate extends StatelessWidget {
  LoadingTemplate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
