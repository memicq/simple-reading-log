import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_log/bloc/setting_cubit.dart';
import 'package:simple_book_log/widget/component/setting/setting_template.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingCubit>(
      create: (context) => SettingCubit(),
      child: SettingTemplate(),
    );
  }

  static void open(
    BuildContext context, {
    void Function()? callback,
  }) {
    void Function() _callback = (callback != null) ? callback : () {};
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => SettingScreen(),
            fullscreenDialog: true,
          ),
        )
        .then(
          (value) => _callback(),
        );
  }

  static void close(BuildContext context) {
    Navigator.of(context).pop();
  }
}
