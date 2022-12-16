// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:bookrabbit/src/features/products/models/participation.dart';
import 'package:bookrabbit/src/features/products/models/resource.dart';
import 'package:bookrabbit/src/common/data/model/review.dart';
import 'package:bookrabbit/src/features/authentication/models/user.dart';
import 'package:bookrabbit/src/utils/datetime.dart';

part 'product.g.dart';

@JsonSerializable(explicitToJson: true)
class CalendarModel {
  CalendarModel({
    this.id,
    required this.datetime,
    this.participations,
    this.isFull,
    this.isOver,
  });

  @JsonKey(name: 'id', includeIfNull: false)
  final int? id;

  @JsonKey(name: 'related_participations', includeIfNull: false)
  final List<ParticipationModel>? participations;

  @JsonKey(name: 'is_full', includeIfNull: false)
  final bool? isFull;

  @JsonKey(name: 'is_over', includeIfNull: false)
  final bool? isOver;

  @JsonKey(
    name: 'datetime',
    toJson: toIsoFormmatedString,
    fromJson: fromDateTimeString,
  )
  final DateTime datetime;

  factory CalendarModel.fromJson(Map<String, dynamic> json) =>
      _$CalendarModelFromJson(json);

  Map<String, dynamic> toJson() => _$CalendarModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CategoryModel {
  CategoryModel(
    this.id,
    this.name,
    this.feeRequired,
    this.description,
    this.code,
  );

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'fee_required')
  final bool feeRequired;

  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'code')
  final String code;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProductStatus {
  ProductStatus(
    this.isFull,
    this.isExpired,
  );

  @JsonKey(name: 'isFull')
  final bool isFull;

  @JsonKey(name: 'isExpired')
  final bool isExpired;

  factory ProductStatus.fromJson(Map<String, dynamic> json) =>
      _$ProductStatusFromJson(json);

  Map<String, dynamic> toJson() => _$ProductStatusToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProductSummaryModel {
  ProductSummaryModel({
    this.id,
    this.typeCode,
    this.category,
    required this.creator,
    required this.title,
    required this.thumbnail,
    required this.price,
    required this.address1,
    required this.datetime,
    required this.totalMemberIds,
    required this.participantsNumber,
    this.allowed,
    this.status,
  });

  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'type_code')
  final String? typeCode;

  @JsonKey(name: 'category')
  final CategoryModel? category;

  @JsonKey(name: 'creator')
  final UserSummaryModel creator;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'thumbnail')
  final String thumbnail;

  @JsonKey(name: 'price')
  final int price;

  @JsonKey(name: 'address1')
  final String address1;

  @JsonKey(name: 'datetime')
  final String datetime;

  @JsonKey(name: 'total_member_ids')
  final List<int?> totalMemberIds;

  @JsonKey(name: 'participants_number')
  final int participantsNumber;

  @JsonKey(name: 'allowed')
  final bool? allowed;

  @JsonKey(name: 'status')
  final ProductStatus? status;

  factory ProductSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$ProductSummaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductSummaryModelToJson(this);

  bool get isAvailable {
    // 일회성 모임인 경우에만 모집 마감 여부를 결정.
    if (typeCode != 'OT') return true;

    if (status?.isExpired == true || status?.isFull == true) {
      return false;
    }

    return true;
  }
}

@JsonSerializable(explicitToJson: true)
class ProductDetailModel {
  ProductDetailModel({
    this.id,
    required this.creator,
    this.likes,
    required this.title,
    required this.chatUrl,
    required this.thumbnail,
    required this.price,
    required this.description,
    required this.address1,
    required this.datetime,
    this.participations,
    required this.participantsNumber,
    this.totalMemberIds,
    required this.dRecommendation,
    required this.dPlan,
    required this.dLocation,
    required this.dParticipation,
    required this.relatedResources,
    this.reviews,
    this.allowed,
  });

  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'creator', toJson: _creatorToJson)
  final UserSummaryModel creator;

  @JsonKey(name: 'likes', includeIfNull: false)
  final List<int>? likes;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'chat_url')
  final String chatUrl;

  @JsonKey(name: 'thumbnail')
  final String thumbnail;

  @JsonKey(name: 'price')
  final int price;

  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'address1')
  final String address1;

  @JsonKey(
    name: 'datetime',
    toJson: toIsoFormmatedString,
    fromJson: fromDateTimeString,
  )
  final DateTime datetime;

  @JsonKey(name: 'participations')
  final List<ParticipationModel>? participations;

  @JsonKey(name: 'participants_number')
  final int participantsNumber;

  @JsonKey(name: 'total_member_ids')
  final List<int?>? totalMemberIds;

  @JsonKey(name: 'd_recommendation', defaultValue: '')
  final String dRecommendation;

  @JsonKey(name: 'd_plan', defaultValue: '')
  final String dPlan;

  @JsonKey(name: 'd_location', defaultValue: '')
  final String dLocation;

  @JsonKey(name: 'd_participation', defaultValue: '')
  final String dParticipation;

  @JsonKey(name: 'reviews')
  final List<ReviewModel>? reviews;

  @JsonKey(name: 'related_resources', toJson: _externalResourcesToJson)
  final List<ExternalResource>? relatedResources;

  @JsonKey(name: 'allowed', defaultValue: true, includeIfNull: false)
  final bool? allowed;

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailModelToJson(this);

  Map<String, dynamic> toJsonForMutation() {
    var payload = this.toJson();

    // NOTE: 모임 타입에 따라 calendar_list를 복수개 유통하도록 수정해야 함.
    payload['calendar_list'] = [
      CalendarModel(datetime: this.datetime).toJson()
    ];

    return payload;
  }

  static List<String> _externalResourcesToJson(
    List<ExternalResource>? externalResources,
  ) {
    return (externalResources ?? []).map((e) => e.uid).toList();
  }

  static String _creatorToJson(UserSummaryModel creator) {
    return creator.id;
  }

  toProductSummaryModel() {
    return ProductSummaryModel(
      id: id,
      creator: creator,
      title: title,
      thumbnail: thumbnail,
      price: price,
      address1: address1,
      datetime: toIsoFormmatedString(datetime),
      totalMemberIds: [],
      participantsNumber: participantsNumber,
      allowed: allowed,
    );
  }
}
