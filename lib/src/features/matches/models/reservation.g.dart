// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationInModel _$ReservationInModelFromJson(Map<String, dynamic> json) =>
    ReservationInModel(
      startAt: fromDateTimeString(json['start_at'] as String),
      endAt: fromDateTimeString(json['end_at'] as String),
      contentId: json['content_uid'] as String?,
    );

Map<String, dynamic> _$ReservationInModelToJson(ReservationInModel instance) =>
    <String, dynamic>{
      'start_at': toIsoFormmatedString(instance.startAt),
      'end_at': toIsoFormmatedString(instance.endAt),
      'content_uid': instance.contentId,
    };

ReservationOutModel _$ReservationOutModelFromJson(Map<String, dynamic> json) =>
    ReservationOutModel(
      json['uid'] as String,
      fromDateTimeString(json['start_at'] as String),
      fromDateTimeString(json['end_at'] as String),
      json['customer_uid'] as String,
      json['content_uid'] as String,
      ContentOutModel.fromJson(json['content'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReservationOutModelToJson(
        ReservationOutModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'start_at': toIsoFormmatedString(instance.startAt),
      'end_at': toIsoFormmatedString(instance.endAt),
      'customer_uid': instance.customerId,
      'content_uid': instance.contentId,
      'content': instance.content.toJson(),
    };

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) => ChatModel(
      content: json['content'] as String,
      senderId: json['sender_uid'] as String,
      createdAt: fromDateTimeString(json['created_at'] as String),
    );

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
      'content': instance.content,
      'sender_uid': instance.senderId,
      'created_at': toIsoFormmatedString(instance.createdAt),
    };

SocketData _$SocketDataFromJson(Map<String, dynamic> json) => SocketData(
      content: json['content'] as String,
      sender_uid: json['sender_uid'] as String,
    );

Map<String, dynamic> _$SocketDataToJson(SocketData instance) =>
    <String, dynamic>{
      'content': instance.content,
      'sender_uid': instance.sender_uid,
    };

SocketModel _$SocketModelFromJson(Map<String, dynamic> json) => SocketModel(
      type: json['type'] as String,
      data: SocketData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SocketModelToJson(SocketModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'data': instance.data.toJson(),
    };
