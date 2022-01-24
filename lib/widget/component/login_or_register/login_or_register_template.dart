import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:simple_book_log/bloc/global_session_cubit.dart';
import 'package:simple_book_log/resource/model/enum/login_authentication_type.dart';
import 'package:simple_book_log/resource/model/table/user_row.dart';
import 'package:simple_book_log/widget/component/common/template_app_bar.dart';
import 'package:simple_book_log/widget/screen/login_or_register_screen.dart';

class LoginOrRegisterTemplate extends StatefulWidget {
  const LoginOrRegisterTemplate({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginOrRegisterTemplateState();
}

class LoginOrRegisterTemplateState extends State<LoginOrRegisterTemplate> {
  void _checkLoginStateAfterBuild(UserRow? _user) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (_user != null) {
        LoginOrRegisterScreen.close(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SessionCubit _sessionCubit = context.read<SessionCubit>();

    return BlocBuilder<SessionCubit, UserRow?>(
      bloc: _sessionCubit,
      builder: (context, _user) {
        _checkLoginStateAfterBuild(_user);
        return Scaffold(
          appBar: TemplateAppBar(
            title: "ログイン・ユーザ登録",
            appBarElevation: 1.5,
            enableCloseButton: false,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                ),
                SignInButton(
                  Buttons.Google,
                  onPressed: () => _sessionCubit.login(LoginAuthenticationType.google),
                ),
                SignInButton(
                  Buttons.Apple,
                  onPressed: () => _sessionCubit.login(LoginAuthenticationType.apple),
                ),
                SignInButton(
                  Buttons.Email,
                  onPressed: () {},
                ),
                // Divider(),
              ],
            ),
          ),
        );
      },
    );
  }
}
