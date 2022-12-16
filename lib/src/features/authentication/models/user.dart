// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:bookrabbit/src/features/products/models/participation.dart';
import 'package:bookrabbit/src/features/products/models/product.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class UserInModel {
  UserInModel({
    this.id,
    this.username,
    this.introduction,
    this.profileThumbnail,
    this.contact,
    this.realName,
  });

  @JsonKey(name: 'uid')
  String? id;

  @JsonKey(name: 'username')
  String? username;

  @JsonKey(
      name: 'profile_thumbnail',
      defaultValue:
          'https://firebasestorage.googleapis.com/v0/b/book-a-rabbit.appspot.com/o/images%2F2022-09-18T11%3A38%3A12.9934012022-09-18%2011%3A38%3A12.835491..jpg?alt=media&token=54caac25-28c1-4798-8fe7-959e271c7a21',)
  String? profileThumbnail;

  @JsonKey(name: 'introduction', defaultValue: '안녕하세요.')
  String? introduction;

  @JsonKey(name: 'real_name', defaultValue: '김철수(DEFAULT)')
  String? realName;

  @JsonKey(name: 'contact', defaultValue: '010-1234-1234(DEFAULT')
  String? contact;

  factory UserInModel.fromJson(Map<String, dynamic> json) =>
      _$UserInModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserInModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserOutModel extends UserInModel {
  UserOutModel(
    this.id,
    this.username,
    this.introduction,
    this.profileThumbnail,
    this.contact,
    this.realName,
  );

  @JsonKey(name: 'uid')
  final String id;

  @JsonKey(name: 'username')
  final String username;

  @JsonKey(name: 'profile_thumbnail', includeIfNull: true)
  final String? profileThumbnail;

  @JsonKey(name: 'introduction', defaultValue: '안녕하세요.')
  final String introduction;

  @JsonKey(name: 'real_name', defaultValue: '김철수(DEFAULT)')
  final String realName;

  @JsonKey(name: 'contact', defaultValue: '010-1234-1234(DEFAULT')
  final String contact;

  factory UserOutModel.fromJson(Map<String, dynamic> json) =>
      _$UserOutModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserOutModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserSummaryModel {
  UserSummaryModel(this.id, this.nickname, this.profileThumbnail);

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'nickname')
  final String nickname;

  @JsonKey(name: 'profile_thumbnail', defaultValue: '')
  final String profileThumbnail;

  factory UserSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$UserSummaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserSummaryModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserDetailModel {
  UserDetailModel(
    this.id,
    this.username,
    this.userType,
    this.introduction,
    this.profileThumbnail,
    this.contact,
    this.realName,
  );

  @JsonKey(name: 'uid')
  final String id;

  @JsonKey(name: 'username')
  final String username;

  // user_type
  @JsonKey(name: 'user_type')
  final String userType;
  @JsonKey(
      name: 'profile_thumbnail',
      defaultValue:
          'https://firebasestorage.googleapis.com/v0/b/book-a-rabbit.appspot.com/o/images%2F2022-09-18T11%3A38%3A12.9934012022-09-18%2011%3A38%3A12.835491..jpg?alt=media&token=54caac25-28c1-4798-8fe7-959e271c7a21',)
  final String profileThumbnail;

  @JsonKey(name: 'introduction', defaultValue: '안녕하세요.')
  final String introduction;

  @JsonKey(name: 'real_name', defaultValue: '김철수(DEFAULT)')
  final String realName;

  @JsonKey(name: 'contact', defaultValue: '010-1234-1234(DEFAULT')
  final String contact;

  factory UserDetailModel.fromJson(Map<String, dynamic> json) =>
      _$UserDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailModelToJson(this);

  UserSummaryModel toUserSummaryModel() {
    return UserSummaryModel(
      this.id,
      'tmp_nickname',
      'tmp_profile_thumbnail',
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserProfileModel {
  UserProfileModel({
    this.id,
    this.participations,
    this.createdProducts,
    this.userGrade,
    this.nickname,
    this.introduction,
    this.profileThumbnail,
  });

  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'participations')
  final List<ParticipationModel>? participations;

  @JsonKey(name: 'created_products')
  final List<ProductSummaryModel>? createdProducts;

  @JsonKey(name: 'user_grade')
  final UserGrade? userGrade;

  @JsonKey(name: 'nickname')
  final String? nickname;

  @JsonKey(name: 'introduction')
  final String? introduction;

  @JsonKey(name: 'profile_thumbnail')
  final String? profileThumbnail;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserGrade {
  UserGrade(this.name, this.grade);

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'grade')
  final int grade;

  factory UserGrade.fromJson(Map<String, dynamic> json) =>
      _$UserGradeFromJson(json);

  Map<String, dynamic> toJson() => _$UserGradeToJson(this);
}
