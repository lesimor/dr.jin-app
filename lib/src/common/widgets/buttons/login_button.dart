// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:bookrabbit/src/themes/custom_colors.dart';

class LoginButton extends StatelessWidget {
  final void Function() onPressedFunction;
  final bool disabled;

  const LoginButton({
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
            style: Theme.of(context).textTheme.button!.copyWith(
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
