// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/common/widgets/layout/appbar.dart';
import 'package:bookrabbit/src/features/authentication/screens/registration/controller.dart';
import 'package:bookrabbit/src/common/widgets/forms/registration_form.dart';
import 'package:bookrabbit/src/routing/routes.dart';
import 'package:bookrabbit/src/themes/custom_colors.dart';
import 'package:bookrabbit/src/utils/logger.dart';

class RegistrationPage extends GetView<RegistrationController> {
  const RegistrationPage({super.key});

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
        titleText: '회원가입',
      ),
      body: Container(
        color: CustomColors.page,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 54, left: 24),
              child: Text(
                "이메일로 가입하기",
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            SizedBox(height: 35),
            RegistrationForm(),
          ],
        ),
      ),
    );
  }
}
