import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_log/bloc/setting_inquiry_cubit.dart';
import 'package:simple_book_log/widget/component/setting/setting_inquiry_template.dart';

class SettingInquiryScreen extends StatelessWidget {
  const SettingInquiryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingInquiryCubit>(
      create: (context) => SettingInquiryCubit(),
      child: SettingInquiryTemplate(),
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
            builder: (context) => SettingInquiryScreen(),
            fullscreenDialog: false,
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
