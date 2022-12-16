// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:bookrabbit/src/features/products/models/product.dart';
import 'package:bookrabbit/src/features/authentication/models/user.dart';

part 'participation.g.dart';

@JsonSerializable(explicitToJson: true)
class ParticipationModel {
  ParticipationModel({
    required this.id,
    this.user,
    required this.product,
    required this.chatroomJoined,
    required this.createdAt,
  });

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'user', includeIfNull: true)
  final UserSummaryModel? user;

  @JsonKey(name: 'product')
  final ProductSummaryModel product;

  @JsonKey(name: 'chatroom_joined')
  final bool chatroomJoined;

  @JsonKey(name: 'created_at')
  final String createdAt;

  factory ParticipationModel.fromJson(Map<String, dynamic> json) =>
      _$ParticipationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ParticipationModelToJson(this);
}
