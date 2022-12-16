// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/common/widgets/agreement.dart';
import 'package:bookrabbit/src/common/widgets/intput.dart';
import 'package:bookrabbit/src/features/authentication/controllers/auth_controller.dart';
import 'package:bookrabbit/src/common/widgets/buttons/login_button.dart';
import 'package:bookrabbit/src/common/widgets/buttons/registration_button.dart';
import 'package:bookrabbit/src/routing/routes.dart';
import 'package:bookrabbit/src/utils/logger.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late FocusNode focusNode;
  final TextEditingController _mailCon = TextEditingController();
  final TextEditingController _pwCon = TextEditingController();
  bool isButtonEnabled = false;
  bool? _isChecked = false;

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
    if (_mailCon.text.isEmpty || _pwCon.text.isEmpty) {
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
    logger.d('로그인 버튼 클릭');

    String email = _mailCon.text;
    String password = _pwCon.text;

    var token = await AuthController.loginWithEmailPassword(
      email,
      password,
      counselorMode: _isChecked,
    );

    if (token == null) {
      logger.d('로그인 실패');
      return;
    }

    await AuthController.syncTokenAndCurrentUser(
      token,
      counselorMode: _isChecked,
    );
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
                    controller: _mailCon,
                    label: "이메일",
                    focusNode: focusNode,
                    onChanged: (text) {
                      checkIsEmpty();
                    },
                  ),
                  SizedBox(height: 1),
                  Input(
                    controller: _pwCon,
                    label: "비밀번호",
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
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (value) {
                      setState(() {
                        _isChecked = value;
                      });
                    },
                  ),
                  Text('상담사로 로그인', style: Theme.of(context).textTheme.button)
                ],
              ),
            ),
            SizedBox(height: 23),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: LoginButton(
                onPressedFunction: onPressedLoginButton,
                disabled: !isButtonEnabled,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
              ),
              child: SignUpButton(),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: AgreementRichText(),
            ),
          ],
        ),
      ),
    );
  }
}
