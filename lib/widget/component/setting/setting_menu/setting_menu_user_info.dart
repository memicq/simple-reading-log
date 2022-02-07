import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_log/bloc/global_session_cubit.dart';
import 'package:simple_book_log/const/color_constants.dart';
import 'package:simple_book_log/resource/model/enum/login_authentication_type.dart';
import 'package:simple_book_log/resource/model/state/session_cubit_state.dart';
import 'package:simple_book_log/resource/model/table/user_row.dart';
import 'package:simple_book_log/widget/component/setting/another_login_authentication_for_anonymous_user/another_login_authentication_for_anonymous_user.dart';
import 'package:simple_book_log/widget/component/setting/setting_menu/setting_menu_card.dart';

class SettingMenuUserInfo extends StatelessWidget {
  SettingMenuUserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SessionCubit _sessionCubit = context.read<SessionCubit>();
    return BlocBuilder<SessionCubit, SessionCubitState>(
      bloc: _sessionCubit,
      builder: (context, sessionState) {
        UserRow userRow = sessionState.currentUser!;

        return SettingMenuCard(
          child: Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.account_circle_rounded,
                      color: _sessionCubit.getAccentColor(),
                    ),
                    SizedBox(width: 10),
                    Text("ユーザ情報"),
                  ],
                ),
                const Divider(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (userRow.email != null)
                      Row(
                        children: [
                          const Text("メールアドレス: "),
                          Text(userRow.email!),
                        ],
                      ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(userRow.authenticationType.japaneseName!),
                          const Text(" でログイン"),
                        ],
                      ),
                    ),
                    if (userRow.authenticationType == LoginAuthenticationType.anonymous)
                      Container(
                        alignment: Alignment.centerRight,
                        height: 25,
                        child: TextButton(
                          style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
                          onPressed: () =>
                              AnotherLoginAuthenticationForAnonymousUserTemplate.open(context),
                          child: Text(
                            "ログイン認証を紐付ける",
                            style: TextStyle(
                              color: _sessionCubit.getAccentColor(),
                            ),
                          ),
                        ),
                      )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
