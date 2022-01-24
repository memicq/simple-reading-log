enum BookTimelineItemType {
  addBook,
  changeStatus,
  readBook,
}

extension BookTimelineItemTypeExt on BookTimelineItemType {
  static final typeCodes = {
    BookTimelineItemType.addBook: "addBook",
    BookTimelineItemType.changeStatus: "changeStatus",
    BookTimelineItemType.readBook: "readBook",
  };

  String get code => typeCodes[this]!;

  static BookTimelineItemType fromCode(String code) =>
      typeCodes.entries.firstWhere((e) => e.value == code).key;
}
