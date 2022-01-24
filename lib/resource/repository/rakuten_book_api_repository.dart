import 'dart:convert';

import 'package:http/http.dart';
import 'package:simple_book_log/resource/model/rakuten_book_api/rakuten_book_api_search_request.dart';
import 'package:simple_book_log/resource/model/rakuten_book_api/rakuten_book_api_search_result.dart';

class RakutenBookApiRepository {
  Future<RakutenBookApiSearchResult> search(RakutenBookApiSearchRequest request) async {
    Uri uri = Uri.https(
      RakutenBookApiSearchRequest.domain,
      RakutenBookApiSearchRequest.path,
      request.toQueryParam(),
    );
    Response res = await get(uri);

    Map<String, dynamic> map = json.decode(res.body);
    return RakutenBookApiSearchResult.fromMap(map);
  }
}
