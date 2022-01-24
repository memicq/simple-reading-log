enum LoginAuthenticationType {
  google,
  apple,
  email,
  anonymous,
}

extension LoginAuthenticationTypeExt on LoginAuthenticationType {
  static final typeCodes = {
    LoginAuthenticationType.google: "google",
    LoginAuthenticationType.apple: "apple",
    LoginAuthenticationType.email: "email",
    LoginAuthenticationType.anonymous: "anonymous",
  };

  static final typeJapaneseNames = {
    LoginAuthenticationType.google: "Google",
    LoginAuthenticationType.apple: "Apple",
    LoginAuthenticationType.email: "メールアドレス",
    LoginAuthenticationType.anonymous: "匿名",
  };

  String? get code => typeCodes[this];
  String? get japaneseName => typeJapaneseNames[this];

  static LoginAuthenticationType fromCode(String code) =>
      typeCodes.entries.firstWhere((e) => e.value == code).key;
}
