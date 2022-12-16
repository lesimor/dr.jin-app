// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExternalResource _$ExternalResourceFromJson(Map<String, dynamic> json) =>
    ExternalResource(
      json['uid'] as String,
      json['title'] as String,
      (json['creators'] as List<dynamic>).map((e) => e as String).toList(),
      json['publisher'] as String,
      json['content'] as String,
      json['released_at'] as String,
      json['price'] as int,
      json['thumbnail'] as String,
      json['site_url'] as String,
      json['json_data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$ExternalResourceToJson(ExternalResource instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'title': instance.title,
      'creators': instance.creators,
      'publisher': instance.publisher,
      'content': instance.content,
      'released_at': instance.releasedAt,
      'price': instance.price,
      'thumbnail': instance.thumbnail,
      'site_url': instance.siteUrl,
      'json_data': instance.jsonData,
    };

KakaoBookApiResult _$KakaoBookApiResultFromJson(Map<String, dynamic> json) =>
    KakaoBookApiResult(
      json['isbn'] as String,
      json['sale_price'] as int,
      json['publisher'] as String,
      (json['authors'] as List<dynamic>).map((e) => e as String).toList(),
      json['contents'] as String,
      json['title'] as String,
      json['thumbnail'] as String,
      json['url'] as String,
      DateTime.parse(json['datetime'] as String),
    );

Map<String, dynamic> _$KakaoBookApiResultToJson(KakaoBookApiResult instance) =>
    <String, dynamic>{
      'isbn': instance.isbn,
      'sale_price': instance.price,
      'publisher': instance.publisher,
      'title': instance.title,
      'contents': instance.contents,
      'thumbnail': instance.thumbnail,
      'authors': instance.authors,
      'url': instance.url,
      'datetime': instance.datetime.toIso8601String(),
    };
