import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_log/bloc/login_or_register_cubit.dart';
import 'package:simple_book_log/widget/component/login_or_register/login_or_register_template.dart';

class LoginOrRegisterScreen extends StatelessWidget {
  const LoginOrRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginOrRegisterCubit>(
      create: (context) => LoginOrRegisterCubit(),
      child: const LoginOrRegisterTemplate(),
    );
  }

  static void open(
    BuildContext context, {
    bool fullscreenDialog = false,
    void Function()? callback,
  }) {
    void Function() _callback = (callback != null) ? callback : () {};
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => const LoginOrRegisterScreen(),
            fullscreenDialog: fullscreenDialog,
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
