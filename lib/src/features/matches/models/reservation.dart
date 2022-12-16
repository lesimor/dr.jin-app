// Package imports:
import 'package:bookrabbit/src/features/products/models/content.dart';
import 'package:bookrabbit/src/utils/datetime.dart';
import 'package:json_annotation/json_annotation.dart';

// Project imports:

part 'reservation.g.dart';

@JsonSerializable(explicitToJson: true)
class ReservationInModel {
  ReservationInModel({
    required this.startAt,
    required this.endAt,
    this.contentId,
  });

  @JsonKey(
    name: 'start_at',
    toJson: toIsoFormmatedString,
    fromJson: fromDateTimeString,
  )
  final DateTime startAt;

  @JsonKey(
    name: 'end_at',
    toJson: toIsoFormmatedString,
    fromJson: fromDateTimeString,
  )
  final DateTime endAt;

  @JsonKey(name: 'content_uid')
  final String? contentId;

  // @JsonKey(name: 'content')
  // final ContentModel

  factory ReservationInModel.fromJson(Map<String, dynamic> json) =>
      _$ReservationInModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationInModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ReservationOutModel {
  ReservationOutModel(
    this.uid,
    this.startAt,
    this.endAt,
    this.customerId,
    this.contentId,
    this.content,
  );

  @JsonKey(name: 'uid')
  final String uid;

  @JsonKey(
    name: 'start_at',
    toJson: toIsoFormmatedString,
    fromJson: fromDateTimeString,
  )
  final DateTime startAt;

  @JsonKey(
    name: 'end_at',
    toJson: toIsoFormmatedString,
    fromJson: fromDateTimeString,
  )
  final DateTime endAt;

  @JsonKey(name: 'customer_uid')
  final String customerId;

  @JsonKey(name: 'content_uid')
  final String contentId;

  @JsonKey(name: 'content')
  final ContentOutModel content;

  factory ReservationOutModel.fromJson(Map<String, dynamic> json) =>
      _$ReservationOutModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationOutModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ChatModel {
  ChatModel({
    required this.content,
    required this.senderId,
    required this.createdAt,
  });

  @JsonKey(
    name: 'content',
  )
  final String content;

  @JsonKey(
    name: 'sender_uid',
  )
  final String senderId;

  @JsonKey(
    name: 'created_at',
    toJson: toIsoFormmatedString,
    fromJson: fromDateTimeString,
  )
  final DateTime createdAt;

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);
}

@JsonSerializable(explicitToJson: true)
class SocketData {
  SocketData({
    required this.content,
    required this.sender_uid,
  });

  @JsonKey(
    name: 'content',
  )
  final String content;

  @JsonKey(
    name: 'sender_uid',
  )
  final String sender_uid;

  factory SocketData.fromJson(Map<String, dynamic> json) =>
      _$SocketDataFromJson(json);

  Map<String, dynamic> toJson() => _$SocketDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SocketModel {
  SocketModel({
    required this.type,
    required this.data,
  });

  @JsonKey(
    name: 'type',
  )
  final String type;

  @JsonKey(
    name: 'data',
  )
  final SocketData data;

  factory SocketModel.fromJson(Map<String, dynamic> json) =>
      _$SocketModelFromJson(json);
}
