// Dart imports:
import 'dart:convert';
import 'dart:io';

// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:bookrabbit/src/features/authentication/models/auth.dart';
import 'package:bookrabbit/src/utils/dio_client.dart';
import 'package:bookrabbit/src/utils/storage_provider.dart';
import 'package:bookrabbit/src/utils/logger.dart';

const LOGIN_KEY = 'login';

class AuthRepository {
  AuthRepository();

  static getAuthorizedToken() async {
    return await StorageProvider.getValue(LOGIN_KEY);
  }

  static writeAuthorizedToken(String value) async {
    await StorageProvider.setValue(LOGIN_KEY, value);
  }

  static deleteAuthorizedToken() async {
    await StorageProvider.deleteValue(LOGIN_KEY);
  }

  static getTokenWithKakaoAccessToken({
    required String kakaoAccessToken,
  }) async {
    try {
      var response = await DioClient().dio.post(
            '/api/account/login/kakao/todjango',
            options: Options(
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
              },
            ),
            data: jsonEncode({
              'access_token': kakaoAccessToken,
            }),
          );

      if (response.statusCode == 200) {
        return AuthResponse.fromJson(response.data);
      } else
        logger.e('erro -get');
    } catch (_) {}
  }

  static getTokenWithAppleAccessToken({
    required String appleAccessToken,
    required String appleIdToken,
  }) async {
    try {
      var response = await DioClient().dio.post(
            '/api/account/login/apple/todjango',
            options: Options(
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
              },
            ),
            data: jsonEncode(
              {
                'access_token': appleAccessToken,
                'id_token': appleIdToken,
              },
            ),
          );

      if (response.statusCode == 200) {
        return AuthResponse.fromJson(response.data);
      } else
        logger.e('erro -get');
    } catch (_) {}
  }

  static Future<AuthResponse?> registerEmailPassword({
    required String email,
    required String password1,
    required String password2,
  }) async {
    try {
      var response = await DioClient().dio.post(
            '/api/account/registration/',
            options: Options(
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
              },
            ),
            data: jsonEncode({
              'email': email,
              'password1': password1,
              'password2': password2,
            }),
          );

      if (response.statusCode == 201) {
        return await AuthRepository.getTokenWithNameAndPassword(
          username: email,
          password: password1,
        );
      } else
        logger.e('erro -get');
    } catch (_) {}
    return null;
  }

  static Future<AuthResponse?> getTokenWithNameAndPassword(
      {required String username,
      required String password,
      bool counselorMode = false,}) async {
    try {
      var response = await DioClient().dio.post(
        '/users/token',
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
            'x-user-type': counselorMode ? 'counselor' : 'customer',
          },
        ),
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return AuthResponse.fromJson(response.data);
      } else
        logger.e('erro -get');
    } catch (_) {}
    return null;
  }
}
