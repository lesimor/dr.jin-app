// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:bookrabbit/src/features/products/models/resource.dart';

part 'response.g.dart';

class CustomApiResponse<T> {
  final dynamic error;
  final T result;

  CustomApiResponse({
    this.error,
    required this.result,
  });

  get isError => this.error != null;

  factory CustomApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> json) fromJsonT,
  ) {
    return CustomApiResponse(
      error: json['error'],
      result: fromJsonT(json['result']),
    );
  }
}

@JsonSerializable()
class KakaoPaginatedResponseMeta {
  KakaoPaginatedResponseMeta(
    this.isEnd,
    this.pageableCount,
    this.totalCount,
  );
  @JsonKey(name: 'is_end')
  bool isEnd;

  @JsonKey(name: 'pageable_count')
  int pageableCount;

  @JsonKey(name: 'total_count')
  int totalCount;

  factory KakaoPaginatedResponseMeta.fromJson(Map<String, dynamic> json) =>
      _$KakaoPaginatedResponseMetaFromJson(json);
  Map<String, dynamic> toJson() => _$KakaoPaginatedResponseMetaToJson(this);
}

@JsonSerializable(explicitToJson: true)
class KakaoPaginatedResponse {
  KakaoPaginatedResponse(this.documents, this.meta);

  @JsonKey(name: 'documents')
  List<KakaoBookApiResult> documents;

  @JsonKey(name: 'meta')
  KakaoPaginatedResponseMeta meta;

  factory KakaoPaginatedResponse.fromJson(Map<String, dynamic> json) =>
      _$KakaoPaginatedResponseFromJson(json);
  Map<String, dynamic> toJson() => _$KakaoPaginatedResponseToJson(this);
}
