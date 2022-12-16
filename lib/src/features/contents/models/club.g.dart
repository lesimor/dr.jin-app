// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClubModel _$ClubModelFromJson(Map<String, dynamic> json) => ClubModel(
      id: json['id'] as int?,
      title: json['title'] as String,
      subTitle: json['sub_title'] as String,
      description: json['description'] as String,
      logoImage: json['logo_image'] as String?,
      coverImage: json['cover_image'] as String?,
      instagramUrl: json['instagram_url'] as String?,
      serviceCenterUrl: json['service_center_url'] as String?,
      clubChatUrl: json['club_chat_url'] as String?,
      createdAt: fromDateTimeString(json['created_at'] as String),
    );

Map<String, dynamic> _$ClubModelToJson(ClubModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['title'] = instance.title;
  val['sub_title'] = instance.subTitle;
  val['description'] = instance.description;
  writeNotNull('logo_image', instance.logoImage);
  writeNotNull('cover_image', instance.coverImage);
  writeNotNull('instagram_url', instance.instagramUrl);
  writeNotNull('service_center_url', instance.serviceCenterUrl);
  writeNotNull('club_chat_url', instance.clubChatUrl);
  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  return val;
}
