// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:bookrabbit/src/features/authentication/models/user.dart';

part 'review.g.dart';

@JsonSerializable(explicitToJson: true)
class ReviewModel {
  ReviewModel(
    this.id,
    this.writer,
    this.images,
    this.productReview,
    this.creatorReview,
    this.createdAt,
    this.product,
  );

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'writer')
  final UserSummaryModel writer;

  @JsonKey(name: 'images')
  final List<String> images;

  @JsonKey(name: 'product_review')
  final String productReview;

  @JsonKey(name: 'creator_review')
  final String creatorReview;

  static DateTime _createAtFromJson(String value) => DateTime.parse(value);

  @JsonKey(name: 'created_at', fromJson: _createAtFromJson)
  final DateTime createdAt;

  @JsonKey(name: 'product')
  final int product;

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);

  bool isLikedBy(UserDetailModel user) {
    // return likes.any((like) => like.user.nickname == user.nickname);
    return true;
  }

  void addLikeIfUnlikedFor(UserDetailModel user) {
    // if (!isLikedBy(user)) {
    //   likes.add(Like(user: user));
    // }
  }

  void toggleLikeFor(UserDetailModel user) {
    // if (isLikedBy(user)) {
    //   likes.removeWhere((like) => like.user.nickname == user.nickname);
    // } else {
    //   addLikeIfUnlikedFor(user);
    // }
  }
}
