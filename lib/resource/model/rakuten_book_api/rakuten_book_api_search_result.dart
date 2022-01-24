class RakutenBookApiSearchResult {
  // 全体情報
  int count;
  int page;
  int first;
  int last;
  int hits;
  int carrier; // 0:PC, 1:mobile
  int pageCount;

  // 商品情報
  List<RakutenBookApiSearchResultItem> items;

  RakutenBookApiSearchResult.fromMap(Map<String, dynamic> map)
      : count = map['count'],
        page = map['page'],
        first = map['first'],
        last = map['last'],
        hits = map['hits'],
        carrier = map['carrier'],
        pageCount = map['pageCount'],
        items = (map['Items'] as List<dynamic>)
            .map(
              (item) => new RakutenBookApiSearchResultItem.fromMap(item['Item']),
            )
            .toList();

  @override
  String toString() =>
      "RakutenBookApiSearchResult<$count:$page:$first:$last:$hits:$carrier:$pageCount:$items>";
}

class RakutenBookApiSearchResultItem {
  String title;
  String titleKana;
  String? subTitle;
  String? subTitleKana;
  String? seriesName;
  String? seriesNameKana;
  String? contents;
  String? contentsKana;
  String author;
  String authorKana;
  String publisherName;
  String size;
  String isbn;
  String itemCaption;
  String salesDate;
  int itemPrice;
  int listPrice;
  int discountRate;
  int discountPrice;
  String itemUrl;
  String affiliateUrl;
  String smallImageUrl;
  String mediumImageUrl;
  String largeImageUrl;
  String chirayomiUrl;
  String availability;
  int postageFlag;
  int limitedFlag;
  int reviewCount;
  String reviewAverage;
  String booksGenreId;

  RakutenBookApiSearchResultItem.fromMap(Map<String, dynamic> map)
      : title = map['title'],
        titleKana = map['titleKana'],
        subTitle = map['subTitle'],
        subTitleKana = map['subTitleKana'],
        seriesName = map['seriesName'],
        seriesNameKana = map['seriesNameKana'],
        contents = map['contents'],
        contentsKana = map['contentsKana'],
        author = map['author'],
        authorKana = map['authorKana'],
        publisherName = map['publisherName'],
        size = map['size'],
        isbn = map['isbn'],
        itemCaption = map['itemCaption'],
        salesDate = map['salesDate'],
        itemPrice = map['itemPrice'],
        listPrice = map['listPrice'],
        discountRate = map['discountRate'],
        discountPrice = map['discountPrice'],
        itemUrl = map['itemUrl'],
        affiliateUrl = map['affiliateUrl'],
        smallImageUrl = map['smallImageUrl'],
        mediumImageUrl = map['mediumImageUrl'],
        largeImageUrl = map['largeImageUrl'],
        chirayomiUrl = map['chirayomiUrl'],
        availability = map['availability'],
        postageFlag = map['postageFlag'],
        limitedFlag = map['limitedFlag'],
        reviewCount = map['reviewCount'],
        reviewAverage = map['reviewAverage'],
        booksGenreId = map['booksGenreId'];

  @override
  String toString() =>
      "RakutenBookApiSearchResultItem<title=$title, author=$author, publishedName=$publisherName, isbn:$isbn>";
}
