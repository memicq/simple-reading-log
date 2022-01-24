class RakutenBookApiSearchRequest {
  static String domain = "app.rakuten.co.jp";
  static String path = "/services/api/BooksBook/Search/20170404";

  // TODO(memicq): 他の場所に保管
  final String _applicationId = "1085577155712228789";

  final String query;

  String? _isbn;
  String? _title;
  String? _author;

  RakutenBookApiSearchRequest.fromQuery({
    required this.query,
  }) {
    _classifyQuery();
  }

  void _classifyQuery() {
    bool _isIsbn10 = RegExp(r'[0-9]{10}').hasMatch(query);
    bool _isIsbn13 = RegExp(r'[0-9]{13}').hasMatch(query);

    if (_isIsbn10 || _isIsbn13) {
      _isbn = query;
    } else {
      _title = query;
    }
  }

  Map<String, String> toQueryParam() {
    Map<String, String> map = {"applicationId": _applicationId};
    if (_title != null) map.addAll({"title": _title!});
    if (_author != null) map.addAll({"author": _author!});
    if (_isbn != null) map.addAll({"isbn": _isbn!});
    return map;
  }
}
