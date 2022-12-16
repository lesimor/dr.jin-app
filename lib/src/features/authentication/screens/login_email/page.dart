// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/common/widgets/buttons/social_login.dart';
import 'package:bookrabbit/src/common/widgets/layout/appbar.dart';
import 'package:bookrabbit/src/common/widgets/forms/login_form.dart';
import 'package:bookrabbit/src/routing/routes.dart';
import 'package:bookrabbit/src/themes/custom_colors.dart';
import 'package:bookrabbit/src/utils/logger.dart';

class LoginWithEmailPage extends StatelessWidget {
  const LoginWithEmailPage({super.key});

  void onClickLoginButton(String email, String password) async {}

  void onClickRegistration() {
    logger.d('회원가입 버튼 클릭');
    Get.toNamed(AppRoutes.REGISTRATION);
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    // User의 목록을 가져온다.
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBarBuilder(
        context: context,
      ),
      body: Container(
        color: CustomColors.page,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 54, left: 24),
              child: Text(
                "로그인하기",
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            
            SizedBox(height: 35),
            LoginForm(),
            SizedBox(height: 58),
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 16),
              child: Text(
                "SNS 계정으로 간편 로그인하기",
                style: Theme.of(context).textTheme.button!.copyWith(
                      color: CustomColors.grayScale[600],
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SocialLoginButtonContainer(),
            ),
            // SizedBox(
            //   height: 20,
            // ),
            // TextButton(
            //   onPressed: () {},
            //   child: Text(
            //     "아이디/비밀번호 찾기",
            //     style: Theme.of(context).textTheme.bodySmall!.copyWith(
            //           color: CustomColors.grayScale[500],
            //           decoration: TextDecoration.underline,
            //         ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
