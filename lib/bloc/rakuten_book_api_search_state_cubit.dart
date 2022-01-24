import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_log/resource/model/rakuten_book_api/rakuten_book_api_search_request.dart';
import 'package:simple_book_log/resource/model/rakuten_book_api/rakuten_book_api_search_result.dart';
import 'package:simple_book_log/resource/repository/rakuten_book_api_repository.dart';

class RakutenBookApiSearchStateCubit extends Cubit<RakutenBookApiSearchResult?> {
  RakutenBookApiSearchStateCubit() : super(null);

  final RakutenBookApiRepository _rakutenBookApiRepository = RakutenBookApiRepository();

  Future<void> searchByQuery(String query) async {
    // TODO(memicq): 検索結果が謎なので、検索のチューニングをする
    RakutenBookApiSearchRequest _request = RakutenBookApiSearchRequest.fromQuery(query: query);
    RakutenBookApiSearchResult result = await _rakutenBookApiRepository.search(_request);
    emit(result);
  }
}
