import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/src/provider.dart';
import 'package:simple_book_log/bloc/global_session_cubit.dart';
import 'package:simple_book_log/resource/model/enum/login_authentication_type.dart';
import 'package:simple_book_log/widget/component/common/template_scaffold.dart';
import 'package:simple_book_log/widget/component/login_or_register/login_or_register_by_email_modal.dart';

class AnotherLoginAuthenticationForAnonymousUserTemplate extends StatelessWidget {
  AnotherLoginAuthenticationForAnonymousUserTemplate({Key? key}) : super(key: key);

  static const double _loginButtonHeight = 48;

  static void open(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AnotherLoginAuthenticationForAnonymousUserTemplate(),
        fullscreenDialog: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SessionCubit _sessionCubit = context.read<SessionCubit>();

    Future<void> linkWithAndClose(
      LoginAuthenticationType authenticationType, {
      String? email,
      String? password,
    }) async {
      await _sessionCubit.linkWith(authenticationType, email: email, password: password);
      Navigator.of(context).pop();
    }

    return TemplateScaffold(
      title: "アカウントをリンクする",
      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SignInButton(
                Buttons.Google,
                onPressed: () => _sessionCubit.linkWith(LoginAuthenticationType.google),
              ),
              SignInButton(
                Buttons.AppleDark,
                onPressed: () => _sessionCubit.linkWith(LoginAuthenticationType.apple),
              ),
              SignInButton(
                Buttons.Email,
                onPressed: () async {
                  LoginOrRegisterByEmailModal.open(context, onSubmit: linkWithAndClose);
                },
              ),
              const SizedBox(height: _loginButtonHeight * 2)
            ],
          ),
        ),
      ),
    );
  }
}
