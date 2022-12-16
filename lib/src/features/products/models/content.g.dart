// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentInModel _$ContentInModelFromJson(Map<String, dynamic> json) =>
    ContentInModel(
      title: json['title'] as String?,
      description: json['content'] as String?,
      thumbnail: json['image'] as String? ??
          'https://firebasestorage.googleapis.com/v0/b/book-a-rabbit.appspot.com/o/images%2F2022-09-18T11%3A38%3A12.9934012022-09-18%2011%3A38%3A12.835491..jpg?alt=media&token=54caac25-28c1-4798-8fe7-959e271c7a21',
    );

Map<String, dynamic> _$ContentInModelToJson(ContentInModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('content', instance.description);
  val['image'] = instance.thumbnail;
  return val;
}

ContentOutModel _$ContentOutModelFromJson(Map<String, dynamic> json) =>
    ContentOutModel(
      title: json['title'] as String?,
      description: json['content'] as String?,
      thumbnail: json['image'] as String?,
      creator: json['creator'] == null
          ? null
          : UserOutModel.fromJson(json['creator'] as Map<String, dynamic>),
    )..id = json['uid'] as String?;

Map<String, dynamic> _$ContentOutModelToJson(ContentOutModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uid', instance.id);
  writeNotNull('title', instance.title);
  writeNotNull('content', instance.description);
  val['image'] = instance.thumbnail;
  val['creator'] = instance.creator?.toJson();
  return val;
}
