// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
      json['id'] as int,
      UserSummaryModel.fromJson(json['writer'] as Map<String, dynamic>),
      (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      json['product_review'] as String,
      json['creator_review'] as String,
      ReviewModel._createAtFromJson(json['created_at'] as String),
      json['product'] as int,
    );

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'writer': instance.writer.toJson(),
      'images': instance.images,
      'product_review': instance.productReview,
      'creator_review': instance.creatorReview,
      'created_at': instance.createdAt.toIso8601String(),
      'product': instance.product,
    };
