// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInModel _$UserInModelFromJson(Map<String, dynamic> json) => UserInModel(
      id: json['uid'] as String?,
      username: json['username'] as String?,
      introduction: json['introduction'] as String? ?? '안녕하세요.',
      profileThumbnail: json['profile_thumbnail'] as String? ??
          'https://firebasestorage.googleapis.com/v0/b/book-a-rabbit.appspot.com/o/images%2F2022-09-18T11%3A38%3A12.9934012022-09-18%2011%3A38%3A12.835491..jpg?alt=media&token=54caac25-28c1-4798-8fe7-959e271c7a21',
      contact: json['contact'] as String? ?? '010-1234-1234(DEFAULT',
      realName: json['real_name'] as String? ?? '김철수(DEFAULT)',
    );

Map<String, dynamic> _$UserInModelToJson(UserInModel instance) =>
    <String, dynamic>{
      'uid': instance.id,
      'username': instance.username,
      'profile_thumbnail': instance.profileThumbnail,
      'introduction': instance.introduction,
      'real_name': instance.realName,
      'contact': instance.contact,
    };

UserOutModel _$UserOutModelFromJson(Map<String, dynamic> json) => UserOutModel(
      json['uid'] as String,
      json['username'] as String,
      json['introduction'] as String? ?? '안녕하세요.',
      json['profile_thumbnail'] as String?,
      json['contact'] as String? ?? '010-1234-1234(DEFAULT',
      json['real_name'] as String? ?? '김철수(DEFAULT)',
    );

Map<String, dynamic> _$UserOutModelToJson(UserOutModel instance) =>
    <String, dynamic>{
      'uid': instance.id,
      'username': instance.username,
      'profile_thumbnail': instance.profileThumbnail,
      'introduction': instance.introduction,
      'real_name': instance.realName,
      'contact': instance.contact,
    };

UserSummaryModel _$UserSummaryModelFromJson(Map<String, dynamic> json) =>
    UserSummaryModel(
      json['id'] as String,
      json['nickname'] as String,
      json['profile_thumbnail'] as String? ?? '',
    );

Map<String, dynamic> _$UserSummaryModelToJson(UserSummaryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'profile_thumbnail': instance.profileThumbnail,
    };

UserDetailModel _$UserDetailModelFromJson(Map<String, dynamic> json) =>
    UserDetailModel(
      json['uid'] as String,
      json['username'] as String,
      json['user_type'] as String,
      json['introduction'] as String? ?? '안녕하세요.',
      json['profile_thumbnail'] as String? ??
          'https://firebasestorage.googleapis.com/v0/b/book-a-rabbit.appspot.com/o/images%2F2022-09-18T11%3A38%3A12.9934012022-09-18%2011%3A38%3A12.835491..jpg?alt=media&token=54caac25-28c1-4798-8fe7-959e271c7a21',
      json['contact'] as String? ?? '010-1234-1234(DEFAULT',
      json['real_name'] as String? ?? '김철수(DEFAULT)',
    );

Map<String, dynamic> _$UserDetailModelToJson(UserDetailModel instance) =>
    <String, dynamic>{
      'uid': instance.id,
      'username': instance.username,
      'user_type': instance.userType,
      'profile_thumbnail': instance.profileThumbnail,
      'introduction': instance.introduction,
      'real_name': instance.realName,
      'contact': instance.contact,
    };

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) =>
    UserProfileModel(
      id: json['id'] as int?,
      participations: (json['participations'] as List<dynamic>?)
          ?.map((e) => ParticipationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdProducts: (json['created_products'] as List<dynamic>?)
          ?.map((e) => ProductSummaryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      userGrade: json['user_grade'] == null
          ? null
          : UserGrade.fromJson(json['user_grade'] as Map<String, dynamic>),
      nickname: json['nickname'] as String?,
      introduction: json['introduction'] as String?,
      profileThumbnail: json['profile_thumbnail'] as String?,
    );

Map<String, dynamic> _$UserProfileModelToJson(UserProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'participations':
          instance.participations?.map((e) => e.toJson()).toList(),
      'created_products':
          instance.createdProducts?.map((e) => e.toJson()).toList(),
      'user_grade': instance.userGrade?.toJson(),
      'nickname': instance.nickname,
      'introduction': instance.introduction,
      'profile_thumbnail': instance.profileThumbnail,
    };

UserGrade _$UserGradeFromJson(Map<String, dynamic> json) => UserGrade(
      json['name'] as String,
      json['grade'] as int,
    );

Map<String, dynamic> _$UserGradeToJson(UserGrade instance) => <String, dynamic>{
      'name': instance.name,
      'grade': instance.grade,
    };
