import 'package:flutter/material.dart';

enum BookStatus {
  tsundoku,
  nextToRead,
  reading,
  finishReading,
}

extension BookStatusExt on BookStatus {
  static final stateCodes = {
    BookStatus.tsundoku: "tsundoku",
    BookStatus.nextToRead: "nextToRead",
    BookStatus.reading: "reading",
    BookStatus.finishReading: "finishReading",
  };

  static final stateJapaneseNames = {
    BookStatus.tsundoku: "積読",
    BookStatus.nextToRead: "次に読む",
    BookStatus.reading: "読んでる",
    BookStatus.finishReading: "読んだ",
  };

  static final Map<BookStatus, Color> stateColors = {
    BookStatus.tsundoku: Colors.grey,
    BookStatus.nextToRead: Colors.orange,
    BookStatus.reading: Colors.blue,
    BookStatus.finishReading: Colors.green,
  };

  String? get code => stateCodes[this];
  String? get japaneseName => stateJapaneseNames[this];
  Color? get color => stateColors[this];

  static BookStatus fromCode(String code) =>
      stateCodes.entries.firstWhere((e) => e.value == code).key;
}
