// Flutter imports:
import 'package:bookrabbit/src/routing/routes.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:bookrabbit/src/themes/custom_colors.dart';
import 'package:get/get.dart';

class RegistrationButton extends StatelessWidget {
  final void Function() onPressedFunction;
  final bool disabled;

  const RegistrationButton({
    Key? key,
    required this.onPressedFunction,
    this.disabled = true,
  });

  ButtonStyle disabledButtonStyle() {
    return OutlinedButton.styleFrom(
      backgroundColor: CustomColors.grayScale[200],
      side: BorderSide.none,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
    );
  }

  ButtonStyle enabledButtonStyle() {
    return OutlinedButton.styleFrom(
      backgroundColor: CustomColors.grayScale[900],
      side: BorderSide.none,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      child: OutlinedButton(
        style: disabled ? disabledButtonStyle() : enabledButtonStyle(),
        child: Center(
          child: Text(
            "로그인",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        onPressed: onPressedFunction,
      ),
    );
  }
}

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    Key? key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          side: BorderSide(
            color: CustomColors.grayScale[300]!,
            width: 1,
          ),
        ),
        onPressed: () {
          Get.toNamed(AppRoutes.REGISTRATION);
        },
        child: Center(
          child: Text(
            "이메일로 가입하기",
            style: Theme.of(context).textTheme.button!.copyWith(
                  color: CustomColors.grayScale[900],
                ),
          ),
        ),
      ),
    );
  }
}
