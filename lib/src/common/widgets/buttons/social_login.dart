// Dart imports:
import 'dart:io' show Platform;

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/features/authentication/controllers/auth_controller.dart';
import 'package:bookrabbit/src/common/widgets/buttons/sns_login_button.dart';
import 'package:bookrabbit/src/routing/routes.dart';
import 'package:bookrabbit/src/themes/custom_colors.dart';

getAuthorizedTokenAndRoute(String token) async {
  await AuthController.syncTokenAndCurrentUser(token);
  Get.offAllNamed(AppRoutes.INITIAL_PAGE);
}

class SocialLoginButtonContainer extends StatelessWidget {
  static _getAuthorizedTokenAndRoute(String token) async {
    await AuthController.syncTokenAndCurrentUser(token);
    Get.offAllNamed(AppRoutes.INITIAL_PAGE);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SocialLoginButton(
          iconPath: 'assets/icon/login/ic_login_kakao.png',
          text: '카카오로 로그인',
          textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 14,
                height: 1.21,
                color: CustomColors.grayScale[900],
              ),
          backgroundColor: CustomColors.kakaoYellow,
          onPressedFunction: () async {
            var token = await AuthController.loginWithKakao();
            _getAuthorizedTokenAndRoute(token!);
          },
          height: 42,
        ),
        // SizedBox(
        //   height: 12,
        // ),
        // SocialLoginButton(
        //   iconPath: 'assets/icon/login/ic_login_naver.png',
        //   text: '네이버 아이디로 시작하기',
        //   textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
        //         fontSize: 14,
        //         height: 1.21,
        //       ),
        //   onPressedFunction: () {},
        //   height: 42,
        // ),
        Platform.isIOS
            ? Column(
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  SocialLoginButton(
                    backgroundColor: CustomColors.black,
                    iconPath: 'assets/icon/login/ic_login_apple_white.png',
                    iconHeight: 19,
                    text: 'Apple로 로그인',
                    textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 14,
                          height: 1.21,
                          color: CustomColors.white,
                        ),
                    onPressedFunction: () async {
                      var token = await AuthController.loginWithApple();
                      _getAuthorizedTokenAndRoute(token!);
                    },
                    height: 42,
                  ),
                ],
              )
            : Container(),
      ],
    );
  }
}
