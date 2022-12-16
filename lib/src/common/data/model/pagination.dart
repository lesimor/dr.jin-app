// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'pagination.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PaginatedResult<T> {
  PaginatedResult({
    required this.count,
    this.currentPageNumber,
    this.nextPageNumber,
    this.previousPageNumber,
    this.previousPageUrl,
    required this.results,
  });

  @JsonKey(name: 'count', includeIfNull: false)
  final int count;

  @JsonKey(name: 'currentPageNumber', includeIfNull: false)
  final int? currentPageNumber;

  @JsonKey(name: 'nextPageNumber', includeIfNull: false)
  final int? nextPageNumber;

  @JsonKey(name: 'previousPageNumber', includeIfNull: false)
  final String? previousPageNumber;

  @JsonKey(name: 'previousPageUrl', includeIfNull: false)
  final String? previousPageUrl;

  @JsonKey(name: 'results', includeIfNull: false)
  final List<T> results;

  factory PaginatedResult.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$PaginatedResultFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(T Function(Object? json) toJsonT) =>
      _$PaginatedResultToJson(this, toJsonT);

  // this.count = json['count'];
  // this.currentPageNumber = json['currentPageNumber'];
  // this.nextPageNumber = json['nextPageNumber'];
  // this.nextPageurl = json['nextPageurl'];
  // this.previousPageNumber = json['previousPageNumber'];
  // this.previousPageUrl = json['previousPageUrl'];
  // this.results =
  //     (json['results'] as List).map((data) => fromJson(data)).toList();
}

class PaginationFilter {
  var page;
  var pageSize;
  var productCode;
  PaginationFilter({
    this.page = 1,
    this.productCode = 'BD',
    this.pageSize = 10,
  });

  @override
  String toString() => 'PaginationFilter(page: $page, pageSize: $pageSize)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PaginationFilter && o.page == page && o.pageSize == pageSize;
  }

  @override
  int get hashCode => page.hashCode ^ pageSize.hashCode;

  PaginationFilter copyWith({int? page, String? productCode, int? pageSize}) =>
      PaginationFilter(
        page: page ?? this.page,
        productCode: productCode ?? this.productCode,
        pageSize: pageSize ?? this.pageSize,
      );
}
