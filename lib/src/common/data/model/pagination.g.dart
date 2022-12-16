// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedResult<T> _$PaginatedResultFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    PaginatedResult<T>(
      count: json['count'] as int,
      currentPageNumber: json['currentPageNumber'] as int?,
      nextPageNumber: json['nextPageNumber'] as int?,
      previousPageNumber: json['previousPageNumber'] as String?,
      previousPageUrl: json['previousPageUrl'] as String?,
      results: (json['results'] as List<dynamic>).map(fromJsonT).toList(),
    );

Map<String, dynamic> _$PaginatedResultToJson<T>(
  PaginatedResult<T> instance,
  Object? Function(T value) toJsonT,
) {
  final val = <String, dynamic>{
    'count': instance.count,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('currentPageNumber', instance.currentPageNumber);
  writeNotNull('nextPageNumber', instance.nextPageNumber);
  writeNotNull('previousPageNumber', instance.previousPageNumber);
  writeNotNull('previousPageUrl', instance.previousPageUrl);
  val['results'] = instance.results.map(toJsonT).toList();
  return val;
}
