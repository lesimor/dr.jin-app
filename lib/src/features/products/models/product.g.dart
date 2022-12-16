// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarModel _$CalendarModelFromJson(Map<String, dynamic> json) =>
    CalendarModel(
      id: json['id'] as int?,
      datetime: fromDateTimeString(json['datetime'] as String),
      participations: (json['related_participations'] as List<dynamic>?)
          ?.map((e) => ParticipationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      isFull: json['is_full'] as bool?,
      isOver: json['is_over'] as bool?,
    );

Map<String, dynamic> _$CalendarModelToJson(CalendarModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('related_participations',
      instance.participations?.map((e) => e.toJson()).toList());
  writeNotNull('is_full', instance.isFull);
  writeNotNull('is_over', instance.isOver);
  val['datetime'] = toIsoFormmatedString(instance.datetime);
  return val;
}

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      json['id'] as int,
      json['name'] as String,
      json['fee_required'] as bool,
      json['description'] as String,
      json['code'] as String,
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'fee_required': instance.feeRequired,
      'description': instance.description,
      'code': instance.code,
    };

ProductStatus _$ProductStatusFromJson(Map<String, dynamic> json) =>
    ProductStatus(
      json['isFull'] as bool,
      json['isExpired'] as bool,
    );

Map<String, dynamic> _$ProductStatusToJson(ProductStatus instance) =>
    <String, dynamic>{
      'isFull': instance.isFull,
      'isExpired': instance.isExpired,
    };

ProductSummaryModel _$ProductSummaryModelFromJson(Map<String, dynamic> json) =>
    ProductSummaryModel(
      id: json['id'] as int?,
      typeCode: json['type_code'] as String?,
      category: json['category'] == null
          ? null
          : CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
      creator:
          UserSummaryModel.fromJson(json['creator'] as Map<String, dynamic>),
      title: json['title'] as String,
      thumbnail: json['thumbnail'] as String,
      price: json['price'] as int,
      address1: json['address1'] as String,
      datetime: json['datetime'] as String,
      totalMemberIds: (json['total_member_ids'] as List<dynamic>)
          .map((e) => e as int?)
          .toList(),
      participantsNumber: json['participants_number'] as int,
      allowed: json['allowed'] as bool?,
      status: json['status'] == null
          ? null
          : ProductStatus.fromJson(json['status'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductSummaryModelToJson(
        ProductSummaryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type_code': instance.typeCode,
      'category': instance.category?.toJson(),
      'creator': instance.creator.toJson(),
      'title': instance.title,
      'thumbnail': instance.thumbnail,
      'price': instance.price,
      'address1': instance.address1,
      'datetime': instance.datetime,
      'total_member_ids': instance.totalMemberIds,
      'participants_number': instance.participantsNumber,
      'allowed': instance.allowed,
      'status': instance.status?.toJson(),
    };

ProductDetailModel _$ProductDetailModelFromJson(Map<String, dynamic> json) =>
    ProductDetailModel(
      id: json['id'] as int?,
      creator:
          UserSummaryModel.fromJson(json['creator'] as Map<String, dynamic>),
      likes: (json['likes'] as List<dynamic>?)?.map((e) => e as int).toList(),
      title: json['title'] as String,
      chatUrl: json['chat_url'] as String,
      thumbnail: json['thumbnail'] as String,
      price: json['price'] as int,
      description: json['description'] as String,
      address1: json['address1'] as String,
      datetime: fromDateTimeString(json['datetime'] as String),
      participations: (json['participations'] as List<dynamic>?)
          ?.map((e) => ParticipationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      participantsNumber: json['participants_number'] as int,
      totalMemberIds: (json['total_member_ids'] as List<dynamic>?)
          ?.map((e) => e as int?)
          .toList(),
      dRecommendation: json['d_recommendation'] as String? ?? '',
      dPlan: json['d_plan'] as String? ?? '',
      dLocation: json['d_location'] as String? ?? '',
      dParticipation: json['d_participation'] as String? ?? '',
      relatedResources: (json['related_resources'] as List<dynamic>?)
          ?.map((e) => ExternalResource.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      allowed: json['allowed'] as bool? ?? true,
    );

Map<String, dynamic> _$ProductDetailModelToJson(ProductDetailModel instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'creator': ProductDetailModel._creatorToJson(instance.creator),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('likes', instance.likes);
  val['title'] = instance.title;
  val['chat_url'] = instance.chatUrl;
  val['thumbnail'] = instance.thumbnail;
  val['price'] = instance.price;
  val['description'] = instance.description;
  val['address1'] = instance.address1;
  val['datetime'] = toIsoFormmatedString(instance.datetime);
  val['participations'] =
      instance.participations?.map((e) => e.toJson()).toList();
  val['participants_number'] = instance.participantsNumber;
  val['total_member_ids'] = instance.totalMemberIds;
  val['d_recommendation'] = instance.dRecommendation;
  val['d_plan'] = instance.dPlan;
  val['d_location'] = instance.dLocation;
  val['d_participation'] = instance.dParticipation;
  val['reviews'] = instance.reviews?.map((e) => e.toJson()).toList();
  val['related_resources'] =
      ProductDetailModel._externalResourcesToJson(instance.relatedResources);
  writeNotNull('allowed', instance.allowed);
  return val;
}
