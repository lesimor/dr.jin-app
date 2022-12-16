// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:bookrabbit/src/utils/datetime.dart';

part 'club.g.dart';

@JsonSerializable(explicitToJson: true)
class ClubModel {
  ClubModel({
    this.id,
    required this.title,
    required this.subTitle,
    required this.description,
    this.logoImage,
    this.coverImage,
    this.instagramUrl,
    this.serviceCenterUrl,
    this.clubChatUrl,
    this.createdAt,
  });

  @JsonKey(name: 'id', includeIfNull: false)
  final int? id;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'sub_title')
  final String subTitle;

  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'logo_image', includeIfNull: false)
  final String? logoImage;

  @JsonKey(name: 'cover_image', includeIfNull: false)
  final String? coverImage;

  @JsonKey(name: 'instagram_url', includeIfNull: false)
  final String? instagramUrl;

  @JsonKey(name: 'service_center_url', includeIfNull: false)
  final String? serviceCenterUrl;

  @JsonKey(name: 'club_chat_url', includeIfNull: false)
  final String? clubChatUrl;

  @JsonKey(
    name: 'created_at',
    fromJson: fromDateTimeString,
    includeIfNull: false,
  )
  final DateTime? createdAt;

  factory ClubModel.fromJson(Map<String, dynamic> json) =>
      _$ClubModelFromJson(json);

  Map<String, dynamic> toJson() => _$ClubModelToJson(this);
}
