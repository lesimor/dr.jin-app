// Flutter imports:
import "package:flutter/services.dart";

// Package imports:
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

// Project imports:
import 'package:bookrabbit/src/features/authentication/models/auth.dart';
import 'package:bookrabbit/src/features/authentication/models/user.dart';
import 'package:bookrabbit/src/features/authentication/data/auth_repository.dart';
import 'package:bookrabbit/src/features/authentication/data/user_respository.dart';
import 'package:bookrabbit/src/utils/logger.dart';

const LOGIN_KEY = 'login';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  // null-safety Rx
  // 참고: https://stackoverflow.com/questions/68125824/flutter-getx-initial-value-of-obs-variable-set-to-null
  static final _token = Rxn<String>();
  String? get token => _token.value;

  static final _isLoading = Rxn<bool>(false);
  bool? get isLoading => _isLoading.value;

  static final _isError = Rxn<bool>(false);
  bool? get isError => _isError.value;

  static final _currentUser = Rxn<UserDetailModel>();
  UserDetailModel? get currentUser => _currentUser.value;

  Future<UserDetailModel?> initCurrentUser() async {
    // 로딩 상태 변경
    _isLoading.value = true;

    // 로컬 저장소로부터 토큰값을 가져온다.
    _token.value = await AuthRepository.getAuthorizedToken();
    logger.d("Get user info with token: ${_token.value}");

    if (_token.value == null) {
      // 토큰이 없다면 null을 반환한다. 이렇게 되면 로그인 페이지로 이동한다.
      return null;
    }

    // 저장된 토큰을 이용해 유저 정보를 가져온다.
    try {
      await syncTokenAndCurrentUser(_token.value!);
      _isLoading.value = false;
      return _currentUser.value;
    } catch (e) {
      // 에러가 발생하는 경우 null을 반환. 이 때도 로그인 페이지로 이동한다.
      logger.e(e);

      AuthController.clear();
      _isLoading.value = false;
      _isError.value = true;
      return null;
    }
  }

  get isAuthenticatedUser {
    return _currentUser.value != null;
  }

  static Future<void> clear() async {
    await AuthRepository.deleteAuthorizedToken();
    _token.value = null;
    _currentUser.value = null;
  }

  static Future<void> syncTokenAndCurrentUser(
    String token, {
    bool? counselorMode,
  }) async {
    await AuthRepository.writeAuthorizedToken(token);

    _token.value = token;
    _currentUser.value = await UserRepository.getCurrentUserWithToken(token, counselorMode ?? false);

    // Firebase 유저정보 초기화
    await UserRepository.setFirebaseAnalyticsUserProperty(_currentUser.value!);
  }

  static Future<String?> getToken() async {
    return _token.value;
  }

  static Future<String?> getUserType() async {
    return _currentUser.value?.userType;
  }

  static Future<String?> loginWithKakao() async {
    OAuthToken? kakakoAccessToken;
    AuthResponse? authResponse;
    if (await isKakaoTalkInstalled()) {
      try {
        kakakoAccessToken = await UserApi.instance.loginWithKakaoTalk();
        logger.d('카카오 로그인으로 access_token 획득: ${kakakoAccessToken.accessToken}');
      } catch (error) {
        logger.e('카카오톡으로 로그인 실패 $error');

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return null;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          kakakoAccessToken = await UserApi.instance.loginWithKakaoAccount();
          logger.d("카카오계정으로 로그인 성공 => token: $kakakoAccessToken");
        } catch (error) {
          logger.d('카카오계정으로 로그인 실패 => error: $error');
        }
      }
    } else {
      try {
        kakakoAccessToken = await UserApi.instance.loginWithKakaoAccount();
        logger.d("카카오계정으로 로그인 성공 => $kakakoAccessToken");
      } catch (error) {
        logger.d('카카오계정으로 로그인 실패 => error: $error');
      }
    }

    // 최종적으로 책토 서버로부터 토큰을 가져온다.
    authResponse = await AuthRepository.getTokenWithKakaoAccessToken(
      kakaoAccessToken: kakakoAccessToken!.accessToken,
    );
    logger.d('책토 access_token 획득: ${authResponse?.key}');
    return authResponse?.key;
  }

  static Future<String?> loginWithApple() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    AuthResponse? authResponse =
        await AuthRepository.getTokenWithAppleAccessToken(
      appleAccessToken: credential.authorizationCode,
      appleIdToken: credential.identityToken!,
    );
    logger.d('책토 access_token 획득: ${authResponse?.key}');
    return authResponse?.key;
  }

  static Future<String?> loginWithEmailPassword(
    String email,
    String password, {
    bool? counselorMode,
  }) async {
    AuthResponse? authResponse;

    // 최종적으로 책토 서버로부터 토큰을 가져온다.
    authResponse = await AuthRepository.getTokenWithNameAndPassword(
      username: email,
      password: password,
      counselorMode: counselorMode ?? false,
    );
    logger.d('책토 access_token 획득: ${authResponse?.key}');
    return authResponse?.key;
  }

  static Future<String?> registerEmailPassword(
    String email,
    String password1,
    String password2,
  ) async {
    AuthResponse? authResponse;

    // 최종적으로 책토 서버로부터 토큰을 가져온다.
    authResponse = await AuthRepository.registerEmailPassword(
      email: email,
      password1: password1,
      password2: password2,
    );
    logger.d('책토 access_token 획득: ${authResponse?.key}');
    return authResponse?.key;
  }

  Future<void> deleteUser() {
    return UserRepository.deleteUserWithToken(_token.value!, currentUser!.id);
  }
}
