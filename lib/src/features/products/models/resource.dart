// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'resource.g.dart';

@JsonSerializable(explicitToJson: true)
class ExternalResource {
  ExternalResource(
    this.uid,
    this.title,
    this.creators,
    this.publisher,
    this.content,
    this.releasedAt,
    this.price,
    this.thumbnail,
    this.siteUrl,
    this.jsonData,
  );

  @JsonKey(name: 'uid')
  String uid;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'creators')
  List<String> creators;

  @JsonKey(name: 'publisher')
  String publisher;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'released_at')
  String releasedAt;

  @JsonKey(name: 'price')
  int price;

  @JsonKey(name: 'thumbnail')
  String thumbnail;

  @JsonKey(name: 'site_url')
  String siteUrl;

  @JsonKey(name: 'json_data')
  Map<String, dynamic> jsonData;

  factory ExternalResource.fromJson(Map<String, dynamic> json) =>
      _$ExternalResourceFromJson(json);
  Map<String, dynamic> toJson() => _$ExternalResourceToJson(this);

  factory ExternalResource.fromKakaoBookApiResult(
    KakaoBookApiResult r,
  ) {
    // 해상도가 높은 도서 이미지 주소로 변환
    // 1. 썸네일 주소로부터 도서 ID 추출
    // https://search.daum.net/search?w=bookpage&bookId=1630448&q=%EB%AF%B8%EC%9B%80%EB%B0%9B%EC%9D%84+%EC%9A%A9%EA%B8%B0%28%ED%8A%B9%EB%B3%84+%ED%95%A9%EB%B3%B8%ED%98%B8%29%28%ED%95%9C%EC%A0%95%ED%8C%90%29%28%EC%96%91%EC%9E%A5%EB%B3%B8+HardCover%29
    var uri = Uri.parse(r.url);
    var imageUrl = '';
    uri.queryParameters.forEach((k, v) {
      if (k == 'bookId') {
        imageUrl = 'http://t1.daumcdn.net/lbook/image/$v';
      }
    });
    // 2. http://t1.daumcdn.net/lbook/image/632577 포멧으로 변경
    return _$ExternalResourceFromJson({
      "uid": r.isbn,
      "title": r.title,
      "creators": r.authors,
      "publisher": r.publisher,
      "content": r.contents,
      "released_at": r.datetime.toIso8601String(),
      "price": r.price,
      "thumbnail": imageUrl,
      "site_url": r.url,
      "json_data": r.toJson(),
    });
  }
}

class KakaoBookApiWrapper {
  late KakaoBookApiResult apiResultContainer;
  Map<String, dynamic> json;
  KakaoBookApiWrapper(this.json) {
    apiResultContainer = KakaoBookApiResult.fromJson(this.json);
  }
}

@JsonSerializable(explicitToJson: true)
class KakaoBookApiResult {
  KakaoBookApiResult(
    this.isbn,
    this.price,
    this.publisher,
    this.authors,
    this.contents,
    this.title,
    this.thumbnail,
    this.url,
    this.datetime,
  );
  @JsonKey(name: 'isbn')
  String isbn;

  @JsonKey(name: 'sale_price')
  int price;

  @JsonKey(name: 'publisher')
  String publisher;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'contents')
  String contents;

  @JsonKey(name: 'thumbnail')
  String thumbnail;

  @JsonKey(name: 'authors')
  List<String> authors;

  @JsonKey(name: 'url')
  String url;

  @JsonKey(name: 'datetime')
  DateTime datetime;

  factory KakaoBookApiResult.fromJson(Map<String, dynamic> json) =>
      _$KakaoBookApiResultFromJson(json);
  Map<String, dynamic> toJson() => _$KakaoBookApiResultToJson(this);
}
