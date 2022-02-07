import 'package:flutter/material.dart';

enum ApplicationTheme {
  defaultGray,
  simpleCyan,
  simpleGreen,
  simpleRed,
  simpleOrange,
}

extension ApplicationThemeExt on ApplicationTheme {
  static final themeCodes = {
    ApplicationTheme.defaultGray: "defaultGray",
    ApplicationTheme.simpleCyan: "simpleCyan",
    ApplicationTheme.simpleGreen: "simpleGreen",
    ApplicationTheme.simpleRed: "simpleRed",
    ApplicationTheme.simpleOrange: "simpleOrange",
  };

  static final themeJapaneseNames = {
    ApplicationTheme.defaultGray: "グレー",
    ApplicationTheme.simpleCyan: "シアン",
    ApplicationTheme.simpleGreen: "グリーン",
    ApplicationTheme.simpleRed: "レッド",
    ApplicationTheme.simpleOrange: "オレンジ",
  };

  static final themeMainColor = {
    ApplicationTheme.defaultGray: Colors.grey,
    ApplicationTheme.simpleCyan: Colors.cyan,
    ApplicationTheme.simpleGreen: Colors.green,
    ApplicationTheme.simpleRed: Colors.redAccent,
    ApplicationTheme.simpleOrange: Colors.deepOrangeAccent,
  };

  String get code => themeCodes[this] ?? "simpleCyan";
  String get japaneseName => themeJapaneseNames[this] ?? "シアン";
  Color get accentColor => themeMainColor[this] ?? Colors.cyan;

  static ApplicationTheme fromCode(String code) =>
      themeCodes.entries.firstWhere((e) => e.value == code).key;
}
