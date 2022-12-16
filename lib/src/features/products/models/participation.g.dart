// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParticipationModel _$ParticipationModelFromJson(Map<String, dynamic> json) =>
    ParticipationModel(
      id: json['id'] as int,
      user: json['user'] == null
          ? null
          : UserSummaryModel.fromJson(json['user'] as Map<String, dynamic>),
      product:
          ProductSummaryModel.fromJson(json['product'] as Map<String, dynamic>),
      chatroomJoined: json['chatroom_joined'] as bool,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$ParticipationModelToJson(ParticipationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user?.toJson(),
      'product': instance.product.toJson(),
      'chatroom_joined': instance.chatroomJoined,
      'created_at': instance.createdAt,
    };
