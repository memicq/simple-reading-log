import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:simple_book_log/bloc/bookshelf_addition_cubit.dart';
import 'package:simple_book_log/bloc/global_session_cubit.dart';
import 'package:simple_book_log/const/borders.dart';
import 'package:simple_book_log/resource/model/enum/book_status.dart';
import 'package:simple_book_log/resource/model/rakuten_book_api/rakuten_book_api_search_result.dart';
import 'package:simple_book_log/resource/model/table/book_row.dart';
import 'package:simple_book_log/widget/component/bookshelf/bookshelf_list/bookshelf_list_item_header.dart';
import 'package:simple_book_log/widget/component/common/rectangle_image.dart';
import 'package:simple_book_log/widget/screen/bookshelf_addition_screen.dart';

class BookSelectionListItem extends StatelessWidget {
  final RakutenBookApiSearchResultItem rakutenBook;

  const BookSelectionListItem({
    Key? key,
    required this.rakutenBook,
  }) : super(key: key);

  Future<void> onPressed(BuildContext context) async {
    SessionCubit _sessionCubit = context.read<SessionCubit>();
    BookshelfAdditionCubit _bookshelfAdditionCubit = context.read<BookshelfAdditionCubit>();
    String userId = _sessionCubit.getCurrentUserId();
    BookRow bookRow = BookRow.createNewBook(
      title: rakutenBook.title,
      titleKana: rakutenBook.titleKana,
      subTitle: rakutenBook.subTitle,
      subTitleKana: rakutenBook.subTitleKana,
      seriesName: rakutenBook.seriesName,
      seriesNameKana: rakutenBook.seriesNameKana,
      author: rakutenBook.author,
      authorKana: rakutenBook.authorKana,
      publisherName: rakutenBook.publisherName,
      salesDate: rakutenBook.salesDate,
      size: rakutenBook.size,
      isbn: rakutenBook.isbn,
      itemUrl: rakutenBook.itemUrl,
      itemPrice: rakutenBook.itemPrice,
      imageUrl: rakutenBook.largeImageUrl,
      status: BookStatus.tsundoku,
      memo: "",
    );
    await _bookshelfAdditionCubit.create(userId, bookRow);
    BookshelfAdditionScreen.close(context);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () => onPressed(context),
        child: Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border(
              top: BorderConstant.defaultBorderSide,
              bottom: BorderConstant.defaultBorderSide,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              RectangleImage(
                imageUrl: rakutenBook.largeImageUrl,
                height: 80,
                width: 80,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: BookshelfListItemHeader(
                        title: rakutenBook.title,
                        subTitle: rakutenBook.author,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
