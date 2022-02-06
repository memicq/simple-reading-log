import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:simple_book_log/bloc/global_session_cubit.dart';
import 'package:simple_book_log/resource/model/enum/login_authentication_type.dart';
import 'package:simple_book_log/resource/model/state/session_cubit_state.dart';
import 'package:simple_book_log/resource/model/table/user_row.dart';
import 'package:simple_book_log/widget/component/common/template_app_bar.dart';
import 'package:simple_book_log/widget/component/login_or_register/login_or_register_by_email_modal.dart';
import 'package:simple_book_log/widget/screen/login_or_register_screen.dart';

class LoginOrRegisterTemplate extends StatefulWidget {
  const LoginOrRegisterTemplate({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginOrRegisterTemplateState();
}

class LoginOrRegisterTemplateState extends State<LoginOrRegisterTemplate> {
  static const double _loginButtonWidth = 220;
  static const double _loginButtonHeight = 48;

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

    return BlocBuilder<SessionCubit, SessionCubitState>(
      bloc: _sessionCubit,
      builder: (context, sessionState) {
        _checkLoginStateAfterBuild(sessionState.currentUser);
        return Scaffold(
          appBar: TemplateAppBar(
            title: "ログイン・ユーザ登録",
            appBarElevation: 1.5,
            enableCloseButton: false,
          ),
          body: Center(
            child: SizedBox(
              width: _loginButtonWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2 - 80 - _loginButtonHeight * 3,
                  ),
                  SignInButton(
                    Buttons.Google,
                    onPressed: () => _sessionCubit.loginBy(LoginAuthenticationType.google),
                  ),
                  SignInButton(
                    Buttons.AppleDark,
                    onPressed: () => _sessionCubit.loginBy(LoginAuthenticationType.apple),
                  ),
                  SignInButton(
                    Buttons.Email,
                    onPressed: () =>
                        LoginOrRegisterByEmailModal.open(context, onSubmit: _sessionCubit.loginBy),
                  ),
                  const Divider(),
                  Container(
                    height: _loginButtonHeight,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: SizedBox(
                      height: 36,
                      width: _loginButtonWidth,
                      child: ElevatedButton(
                        onPressed: () => _sessionCubit.loginBy(LoginAuthenticationType.anonymous),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.white),
                          foregroundColor: MaterialStateProperty.all(Colors.black),
                        ),
                        child: const Center(
                          child: Text("匿名ログイン"),
                        ),
                      ),
                    ),
                  ),
                  // Divider(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
