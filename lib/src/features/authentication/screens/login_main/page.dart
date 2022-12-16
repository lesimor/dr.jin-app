// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/common/widgets/agreement.dart';
import 'package:bookrabbit/src/common/widgets/buttons/social_login.dart';
import 'package:bookrabbit/src/features/authentication/screens/login_main/controller.dart';
import 'package:bookrabbit/src/common/widgets/buttons/sns_login_button.dart';
import 'package:bookrabbit/src/routing/routes.dart';
import 'package:bookrabbit/src/themes/custom_colors.dart';
import 'package:bookrabbit/src/utils/logger.dart';

class LoginPage extends GetView<ModelTemplateController> {
  const LoginPage({super.key});

  void onClickEmailLogin() {
    logger.d('다른 방법으로 시작하기 클릭');
    Get.toNamed(AppRoutes.LOGIN_WITH_EMAIL);
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      body: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: CustomColors.primaryGreen,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 40),
                      child: Image(
                        image: AssetImage('assets/splash_4x.png'),
                        width: 164,
                        height: 22,
                      ),
                    ),
                  ),
                  flex: 6,
                ),
                Expanded(
                  child: new LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: constraints.maxHeight,
                        padding: const EdgeInsets.only(
                          top: 56,
                          left: 16,
                          right: 16,
                        ),
                        decoration: BoxDecoration(
                          color: CustomColors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        child: Column(
                          children: [
                            SocialLoginButtonContainer(),
                            SizedBox(
                              height: 46,
                            ),
                            SocialLoginButton(
                              text: '다른방법으로 시작하기',
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontSize: 14,
                                    height: 1.21,
                                  ),
                              onPressedFunction: onClickEmailLogin,
                              height: 42,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            AgreementRichText(),
                            // SizedBox(
                            //   height: 20,
                            // ),
                            // TextButton(
                            //   onPressed: () {},
                            //   child: Text(
                            //     "아이디/비밀번호 찾기",
                            //     style: Theme.of(context)
                            //         .textTheme
                            //         .bodyMedium!
                            //         .copyWith(
                            //           color: CustomColors.grayScale[500],
                            //           decoration: TextDecoration.underline,
                            //         ),
                            //   ),
                            // ),
                          ],
                        ),
                      );
                    },
                  ),
                  flex: 5,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
