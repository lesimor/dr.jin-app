// Package imports:
import 'package:bookrabbit/src/features/authentication/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

// Project imports:

part 'content.g.dart';

@JsonSerializable(explicitToJson: true)
class ContentInModel {
  ContentInModel({
    this.title,
    this.description,
    this.thumbnail,
  });

  @JsonKey(name: 'title', includeIfNull: false)
  String? title;

  @JsonKey(name: 'content', includeIfNull: false)
  String? description;

  @JsonKey(
      name: 'image',
      defaultValue:
          'https://firebasestorage.googleapis.com/v0/b/book-a-rabbit.appspot.com/o/images%2F2022-09-18T11%3A38%3A12.9934012022-09-18%2011%3A38%3A12.835491..jpg?alt=media&token=54caac25-28c1-4798-8fe7-959e271c7a21',)
  String? thumbnail;

  factory ContentInModel.fromJson(Map<String, dynamic> json) =>
      _$ContentInModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContentInModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ContentOutModel {
  ContentOutModel({
    this.title,
    this.description,
    this.thumbnail,
    this.creator,
  });

  @JsonKey(name: 'uid', includeIfNull: false)
  String? id;

  @JsonKey(name: 'title', includeIfNull: false)
  String? title;

  @JsonKey(name: 'content', includeIfNull: false)
  String? description;

  @JsonKey(name: 'image')
  String? thumbnail;

  @JsonKey(name: 'creator')
  UserOutModel? creator;

  factory ContentOutModel.fromJson(Map<String, dynamic> json) =>
      _$ContentOutModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContentOutModelToJson(this);
}
