import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:simple_book_log/bloc/global_session_cubit.dart';
import 'package:simple_book_log/resource/model/enum/application_theme.dart';
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
    SessionCubit _sessionCubit = context.read<SessionCubit>();
    ApplicationTheme _theme = _sessionCubit.getTheme();

    List<ApplicationTheme> _themes = ApplicationTheme.values;

    List<SettingChangeThemeItem> _items = _themes.map((theme) {
      return SettingChangeThemeItem(
        title: theme.japaneseName,
        color: theme.accentColor,
        isSelected: theme == _theme,
        onPressed: () async {
          await _sessionCubit.updateTheme(theme);
          Navigator.of(context).pop();
        },
      );
    }).toList();

    return TemplateScaffold(
      title: "テーマカラーを変更する",
      body: Column(
        children: [const ColumnSpacer(), ..._items],
      ),
    );
  }
}
