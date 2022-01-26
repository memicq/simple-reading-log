import 'package:flutter/material.dart';
import 'package:app_review/app_review.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_log/bloc/global_session_cubit.dart';
import 'package:simple_book_log/resource/model/table/user_row.dart';
import 'package:simple_book_log/widget/component/common/column_spacer.dart';
import 'package:simple_book_log/widget/component/common/template_scaffold.dart';
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

  @override
  Widget build(BuildContext context) {
    SessionCubit _sessionCubit = context.read<SessionCubit>();
    return BlocBuilder<SessionCubit, UserRow?>(
      builder: (context, user) {
        return TemplateScaffold(
          title: "設定",
          body: ListView(
            children: [
              const ColumnSpacer(),
              SettingMenuUserInfo(),
              const ColumnSpacer(),
              SettingMenuItem(
                iconData: Icons.question_answer_outlined,
                title: "お問い合わせ",
                onPressed: () => sendInquiryEmail(),
              ),
              const ColumnSpacer(),
              // SettingMenuItem(
              //   iconData: Icons.article_outlined,
              //   title: "利用規約",
              //   onPressed: () => SettingTermsOfServiceTemplate.open(context),
              // ),
              SettingMenuItem(
                iconData: Icons.privacy_tip_outlined,
                title: "プライバシーポリシー",
                onPressed: () => SettingPrivacyPolicyTemplate.open(context),
              ),
              // const SettingMenuItem(
              //   iconData: Icons.update,
              //   title: "最近の更新",
              // ),
              // const ColumnSpacer(),
              SettingMenuItem(
                iconData: Icons.reviews_outlined,
                title: "AppStoreでレビューを書く",
                onPressed: () => AppReview.requestReview,
              ),
              // const SettingMenuItem(
              //   iconData: Icons.share_outlined,
              //   title: "このアプリをシェア",
              // ),
              // const ColumnSpacer(),
              const SettingMenuItem(
                iconData: Icons.person_outlined,
                title: "開発者を支援する",
              ),
              const ColumnSpacer(),
              SettingMenuItem(
                iconData: Icons.logout,
                title: "ログアウト",
                onPressed: () => _sessionCubit.logout(),
              ),
            ],
          ),
        );
      },
    );
  }
}
