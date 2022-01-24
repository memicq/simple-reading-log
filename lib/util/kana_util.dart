class KanaUtil {
  static String hiraToKana(String str) {
    return str.replaceAllMapped(
      RegExp("[ぁ-ゔ]"),
      (Match m) => String.fromCharCode(m.group(0)!.codeUnitAt(0) + 0x60),
    );
  }

  static String kanaToHira(String str) {
    return str.replaceAllMapped(
      RegExp("[ァ-ヴ]"),
      (Match m) => String.fromCharCode(m.group(0)!.codeUnitAt(0) - 0x60),
    );
  }
}
