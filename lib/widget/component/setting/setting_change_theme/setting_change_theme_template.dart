import 'package:flutter/material.dart';
import 'package:simple_book_log/widget/component/common/column_spacer.dart';
import 'package:simple_book_log/widget/component/common/template_scaffold.dart';
import 'package:simple_book_log/widget/component/setting/setting_change_theme/setting_change_theme_item.dart';
import 'package:simple_book_log/widget/component/setting/setting_menu/setting_menu_item.dart';

class SettingChangeThemeTemplate extends StatelessWidget {
  SettingChangeThemeTemplate({Key? key}) : super(key: key);

  static void open(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SettingChangeThemeTemplate(),
        fullscreenDialog: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TemplateScaffold(
      title: "テーマカラーを変更する",
      body: Column(
        children: [
          const ColumnSpacer(),
          SettingChangeThemeItem(
            title: "シアン",
            color: Colors.cyan,
            isSelected: true,
          ),
          SettingChangeThemeItem(
            title: "グリーン",
            color: Colors.green,
          ),
          SettingChangeThemeItem(
            title: "レッド",
            color: Colors.redAccent,
          ),
          SettingChangeThemeItem(
            title: "オレンジ",
            color: Colors.deepOrange,
          ),
        ],
      ),
    );
  }
}
