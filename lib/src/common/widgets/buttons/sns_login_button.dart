// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:bookrabbit/src/themes/custom_colors.dart';

class SocialLoginButton extends StatelessWidget {
  final String? iconPath;
  final double iconWidth;
  final double iconHeight;
  final String text;
  final TextStyle textStyle;
  final Color backgroundColor;
  final Function onPressedFunction;
  final double height;
  final double? width;

  const SocialLoginButton({
    Key? key,
    this.iconPath,
    this.iconWidth = 16,
    this.iconHeight = 16,
    required this.text,
    required this.textStyle,
    this.backgroundColor = Colors.white,
    required this.onPressedFunction,
    required this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final hasIcon = iconPath != null && iconPath!.isNotEmpty;

    return Container(
      width: width,
      height: height,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          // elevation: 0,
          padding: const EdgeInsets.all(0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          side: backgroundColor == Colors.white
              ? BorderSide(
                  color: CustomColors.grayScale[300]!,
                  width: 1,
                )
              : BorderSide.none,
        ),
        child: Stack(
          children: <Widget>[
            hasIcon
                ? Positioned(
                    left: 25,
                    top: (height - iconHeight) / 2,
                    child: Image(
                      image: AssetImage(iconPath!),
                      width: iconWidth,
                      height: iconHeight,
                    ),
                  )
                : Container(),
            Center(
              child: Text(
                text,
                style: textStyle,
              ),
            ),
          ],
        ),
        onPressed: () => onPressedFunction(),
      ),
    );
  }
}
