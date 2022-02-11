import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_review/app_review.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_log/bloc/global_session_cubit.dart';
import 'package:simple_book_log/resource/model/enum/login_authentication_type.dart';
import 'package:simple_book_log/resource/model/state/session_cubit_state.dart';
import 'package:simple_book_log/resource/model/table/user_row.dart';
import 'package:simple_book_log/widget/component/common/column_spacer.dart';
import 'package:simple_book_log/widget/component/common/template_scaffold.dart';
import 'package:simple_book_log/widget/component/setting/another_login_authentication_for_anonymous_user/another_login_authentication_for_anonymous_user.dart';
import 'package:simple_book_log/widget/component/setting/setting_change_theme/setting_change_theme_template.dart';
import 'package:simple_book_log/widget/component/setting/setting_menu/setting_menu_item.dart';
import 'package:simple_book_log/widget/component/setting/setting_menu/setting_menu_user_info.dart';
import 'package:simple_book_log/widget/component/setting/setting_privacy_policy_template.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class SettingTemplate extends StatelessWidget {
  const SettingTemplate({Key? key}) : super(key: key);

  Future<void> sendInquiryEmail() async {
    final Email email = Email(
      body: "",
      subject: "シンプル読書ログについてのお問い合わせ・要望",
      recipients: ["simplereadinglog@gmail.com"],
      isHTML: true,
    );

    await FlutterEmailSender.send(email);
  }

  Future<void> _logout(
    BuildContext context,
    SessionCubit sessionCubit,
    UserRow currentUser,
  ) async {
    if (currentUser.authenticationType == LoginAuthenticationType.anonymous) {
      bool willDelete = await showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          message: const Text("匿名ログインの場合、ログアウトするとすべてのデータが削除されてしまいます。"),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text(
                "匿名アカウントにログイン認証を紐付ける",
                style: TextStyle(fontSize: 18),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text(
                "アカウントを削除する",
                style: TextStyle(fontSize: 18),
              ),
              isDestructiveAction: true,
            )
          ],
        ),
      );

      if (willDelete) {
        await sessionCubit.logout();
      } else {
        AnotherLoginAuthenticationForAnonymousUserTemplate.open(context);
      }
    } else {
      await sessionCubit.logout();
    }
  }

  @override
  Widget build(BuildContext context) {
    SessionCubit _sessionCubit = context.read<SessionCubit>();
    return BlocBuilder<SessionCubit, SessionCubitState>(
      builder: (context, sessionState) {
        return TemplateScaffold(
          title: "設定",
          body: ListView(
            children: [
              const ColumnSpacer(),
              SettingMenuUserInfo(),
              const ColumnSpacer(),
              SettingMenuItem(
                iconData: Icons.color_lens_outlined,
                title: "テーマカラーを変更する",
                onPressed: () => SettingChangeThemeTemplate.open(context),
              ),
              // SettingMenuItem(
              //   iconData: Icons.do_not_disturb,
              //   title: "広告を消す",
              //   onPressed: () {},
              // ),
              const ColumnSpacer(),
              SettingMenuItem(
                iconData: Icons.question_answer_outlined,
                title: "お問い合わせ",
                onPressed: () => sendInquiryEmail(),
              ),
              const ColumnSpacer(),
              SettingMenuItem(
                iconData: Icons.privacy_tip_outlined,
                title: "プライバシーポリシー",
                onPressed: () {
                  print("プライバシーポリシー");
                  SettingPrivacyPolicyTemplate.open(context);
                },
              ),
              // const SettingMenuItem(
              //   iconData: Icons.update,
              //   title: "最近の更新",
              // ),
              // const ColumnSpacer(),
              SettingMenuItem(
                iconData: Icons.reviews_outlined,
                title: "AppStoreでレビューを書く",
                onPressed: () {
                  print("レビュー");
                  AppReview.requestReview;
                },
              ),
              // const SettingMenuItem(
              //   iconData: Icons.share_outlined,
              //   title: "このアプリをシェア",
              // ),
              // const ColumnSpacer(),
              // const SettingMenuItem(
              //   iconData: Icons.person_outlined,
              //   title: "開発者を支援する",
              // ),
              const ColumnSpacer(),
              SettingMenuItem(
                iconData: Icons.logout,
                title: "ログアウト",
                onPressed: () => _logout(context, _sessionCubit, sessionState.currentUser!),
              ),
            ],
          ),
        );
      },
    );
  }
}
