// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/common/widgets/intput.dart';
import 'package:bookrabbit/src/features/authentication/controllers/auth_controller.dart';
import 'package:bookrabbit/src/common/widgets/buttons/registration_button.dart';
import 'package:bookrabbit/src/routing/routes.dart';
import 'package:bookrabbit/src/utils/logger.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key});

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  late FocusNode focusNode;
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _pwConfirmController = TextEditingController();
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  void checkIsEmpty() {
    if (_mailController.text.isEmpty ||
        _pwController.text.isEmpty ||
        _pwConfirmController.text.isEmpty) {
      setState(() {
        isButtonEnabled = false;
      });
    } else {
      setState(() {
        isButtonEnabled = true;
      });
    }
  }

  void onPressedLoginButton() async {
    logger.d('이메일 회원가입 버튼 클릭');

    String email = _mailController.text;
    String password1 = _pwController.text;
    String password2 = _pwConfirmController.text;

    var token =
        await AuthController.registerEmailPassword(email, password1, password2);

    if (token == null) {
      logger.d('회원가입 실패');
      return;
    }

    await AuthController.syncTokenAndCurrentUser(token);
    Get.offAllNamed(AppRoutes.INITIAL_PAGE);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Container(
        child: Column(
          children: <Widget>[
            // Input Area
            Container(
              child: Column(
                children: <Widget>[
                  Input(
                    controller: _mailController,
                    label: "이메일",
                    focusNode: focusNode,
                    onChanged: (text) {
                      checkIsEmpty();
                    },
                  ),
                  SizedBox(height: 1),
                  Input(
                    controller: _pwController,
                    label: "비밀번호",
                    obscureText: true,
                    focusNode: focusNode,
                    onChanged: (text) {
                      checkIsEmpty();
                    },
                  ),
                  SizedBox(height: 1),
                  Input(
                    controller: _pwConfirmController,
                    label: "비밀번호 확인",
                    obscureText: true,
                    focusNode: focusNode,
                    onChanged: (text) {
                      checkIsEmpty();
                    },
                  ),
                ].asMap().entries.map((entry) {
                  if (entry.key == 1) {
                    return SizedBox(height: 8);
                  }

                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: 12,
                      left: 30,
                      right: 30,
                    ),
                    child: entry.value,
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 23),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: RegistrationButton(
                onPressedFunction: onPressedLoginButton,
                disabled: !isButtonEnabled,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
