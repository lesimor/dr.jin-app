// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KakaoPaginatedResponseMeta _$KakaoPaginatedResponseMetaFromJson(
        Map<String, dynamic> json) =>
    KakaoPaginatedResponseMeta(
      json['is_end'] as bool,
      json['pageable_count'] as int,
      json['total_count'] as int,
    );

Map<String, dynamic> _$KakaoPaginatedResponseMetaToJson(
        KakaoPaginatedResponseMeta instance) =>
    <String, dynamic>{
      'is_end': instance.isEnd,
      'pageable_count': instance.pageableCount,
      'total_count': instance.totalCount,
    };

KakaoPaginatedResponse _$KakaoPaginatedResponseFromJson(
        Map<String, dynamic> json) =>
    KakaoPaginatedResponse(
      (json['documents'] as List<dynamic>)
          .map((e) => KakaoBookApiResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      KakaoPaginatedResponseMeta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$KakaoPaginatedResponseToJson(
        KakaoPaginatedResponse instance) =>
    <String, dynamic>{
      'documents': instance.documents.map((e) => e.toJson()).toList(),
      'meta': instance.meta.toJson(),
    };
