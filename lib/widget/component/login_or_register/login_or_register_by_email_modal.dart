import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:simple_book_log/bloc/global_session_cubit.dart';
import 'package:simple_book_log/resource/model/enum/login_authentication_type.dart';
import 'package:simple_book_log/widget/component/common/is_bottom_space.dart';

class LoginOrRegisterByEmailModal extends StatefulWidget {
  final Future<void> Function(
    LoginAuthenticationType, {
    String? email,
    String? password,
  }) onSubmit;

  LoginOrRegisterByEmailModal({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  static void open(
    BuildContext context, {
    required Future<void> Function(
      LoginAuthenticationType, {
      String? email,
      String? password,
    })
        onSubmit,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => LoginOrRegisterByEmailModal(onSubmit: onSubmit),
      enableDrag: false,
      barrierColor: Colors.black.withAlpha(200),
    );
  }

  @override
  State<StatefulWidget> createState() => LoginOrRegisterByEmailModalState();
}

class LoginOrRegisterByEmailModalState extends State<LoginOrRegisterByEmailModal> {
  String? email;
  String? password;

  bool isEmailValidated() {
    return email != null && EmailValidator.validate(email!);
  }

  bool isPasswordValidated() {
    return password != null && RegExp(r"^([a-zA-Z0-9]{8,16})$").hasMatch(password!);
  }

  String? generateEmailErrorText() {
    if (email == null) {
      return null;
    }

    if (!EmailValidator.validate(email!)) {
      return "正しいメールアドレスを入力してください。";
    }
  }

  String? generatePasswordErrorText() {
    if (password == null) return null;

    if (!RegExp(r"^([a-zA-Z0-9]{8,16})$").hasMatch(password!)) {
      return "8文字以上16文字以下の半角英数字で入力してください。";
    }
  }

  @override
  Widget build(BuildContext context) {
    SessionCubit _sessionCubit = context.read<SessionCubit>();

    final bottomSpace = MediaQuery.of(context).viewInsets.bottom;

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: bottomSpace + 400,
      curve: Curves.easeInOut,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "メールアドレスでサインイン",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                    child: TextButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("キャンセル"),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: const Text("メールアドレスとパスワードを使ってアカウント作成、\nすでにアカウントが存在する場合はログインを行います。"),
          ),
          const Divider(
            height: 20,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: "メールアドレス",
                      hintStyle: const TextStyle(fontSize: 12),
                      errorText: generateEmailErrorText(),
                    ),
                    style: const TextStyle(fontSize: 12),
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "パスワード",
                      hintStyle: TextStyle(fontSize: 12),
                      errorText: generatePasswordErrorText(),
                    ),
                    style: TextStyle(fontSize: 12),
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: (isEmailValidated() && isPasswordValidated())
                  ? () async {
                      await widget.onSubmit(
                        LoginAuthenticationType.email,
                        email: email,
                        password: password,
                      );
                      Navigator.of(context).pop();
                    }
                  : null,
              child: const Text("ログインする"),
              style: const ButtonStyle(),
            ),
          ),
          SizedBox(
            height: 20 + bottomSpace,
          ),
          IosBottomSpace()
        ],
      ),
    );
  }
}
