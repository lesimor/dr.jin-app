// Flutter imports:
import "package:flutter/material.dart";

// Project imports:
import 'package:bookrabbit/src/themes/custom_colors.dart';

class ActionButton extends StatelessWidget {
  final String? buttonText;
  final bool active;
  final Widget? child;
  final double? height;
  final Function()? onPressed;
  final ButtonStyle? activatedButtonStyle = OutlinedButton.styleFrom(
    backgroundColor: CustomColors.primaryGreen,
  );
  final Color activatedTextColor = CustomColors.white;

  final ButtonStyle? inactivedButtonStyle = OutlinedButton.styleFrom(
    foregroundColor: Colors.black, backgroundColor: Colors.grey,
  );
  final Color inactivatedTextColor = CustomColors.white;

  ActionButton({
    super.key,
    this.buttonText,
    this.child,
    this.height,
    this.active = true,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: OutlinedButton(
        onPressed:
            (active && onPressed != null) ? onPressed : onPressed ?? () {},
        style: active ? activatedButtonStyle : inactivedButtonStyle,
        child: Center(
          child: child ??
              Text(
                this.buttonText ?? "",
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: active ? activatedTextColor : inactivatedTextColor,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    ),
              ),
        ),
      ),
    );
  }
}

class SelectionButton extends ActionButton {
  final ButtonStyle? activatedButtonStyle = OutlinedButton.styleFrom(
    backgroundColor: CustomColors.primaryGreen,
    shape: RoundedRectangleBorder(),
  );
  final ButtonStyle? inactivedButtonStyle = OutlinedButton.styleFrom(
    foregroundColor: Colors.black, backgroundColor: Colors.transparent,
  );
  SelectionButton({
    super.key,
    super.buttonText,
    super.child,
    super.height,
    super.active = true,
    super.onPressed,
  });
}

class MovebackButton extends ActionButton {
  final ButtonStyle? activatedButtonStyle = OutlinedButton.styleFrom(
    backgroundColor: CustomColors.white,
  );
  final Color activatedTextColor = CustomColors.primaryGreen;
  MovebackButton({
    super.key,
    super.buttonText,
    super.child,
    super.height,
    super.active = true,
    super.onPressed,
  });
}
