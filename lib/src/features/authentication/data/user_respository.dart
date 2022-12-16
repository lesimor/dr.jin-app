// Package imports:
import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

// Project imports:
import 'package:bookrabbit/src/features/authentication/controllers/auth_controller.dart';
import 'package:bookrabbit/src/common/data/model/response.dart';
import 'package:bookrabbit/src/features/authentication/models/user.dart';
import 'package:bookrabbit/src/utils/dio_client.dart';

class UserRepository {
  UserRepository();

  static Future<UserDetailModel?> getCurrentUserWithToken(
      String token, bool counselorMode,) async {
    var response = await DioClient().dio.get(
          '/users/auth',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'x-user-type': counselorMode ? 'counselor' : 'customer'
          },),
        );
    return UserDetailModel.fromJson(response.data);
  }

  static Future<UserProfileModel> getUserProfile(int userId) async {
    var authToken = await AuthController.getToken();
    var response = await DioClient().dio.get(
          '/api/db/users/$userId/profile/',
          options: Options(headers: {'Authorization': 'Token $authToken'}),
        );
    return UserProfileModel.fromJson(response.data);
  }

  static Future<void> setFirebaseAnalyticsUserProperty(
    UserDetailModel currentUser,
  ) async {
    // TODO: 성별, 나이 등에 대한 정보도 추가 필요.
    await FirebaseAnalytics.instance.setUserId(id: "${currentUser.id}");
  }

  static Future<UserDetailModel?> patchCurrentUserInfo(
    String token,
    dynamic data,
  ) async {
    var response = await DioClient().dio.patch(
          '/api/user_info',
          data: data,
          options: Options(
            headers: {
              'Authorization': 'Token $token',
              'Content-Type': 'application/json'
            },
          ),
        );
    return UserDetailModel.fromJson(response.data);
  }

  static Future<void> deleteUserWithToken(
    String token,
    String userId,
  ) async {
    await DioClient().dio.delete(
          '/api/db/users/$userId/',
          options: Options(headers: {'Authorization': 'Token $token'}),
        );
  }

  static Future<CustomApiResponse?> setRelationship(
    String command,
    int targetUserId,
  ) async {
    var token = await AuthController.getToken();
    var response = await DioClient().dio.patch(
          '/api/relationship',
          data: {
            "user_id": targetUserId,
            "command": command,
          },
          options: Options(headers: {'Authorization': 'Token $token'}),
        );
    return CustomApiResponse.fromJson(response.data, (json) => json);
  }

  static Future<CustomApiResponse> reportUser(
    int userId,
    String content,
  ) async {
    var authToken = await AuthController.getToken();
    var response = await DioClient().dio.post(
          '/api/db/users/${userId}/report/',
          data: {
            "content": content,
          },
          options: Options(
            headers: {
              'Authorization': 'Token $authToken',
            },
          ),
        );
    return CustomApiResponse.fromJson(response.data, (json) {
      return json;
    });
  }
}
