// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:bookrabbit/src/themes/custom_colors.dart';

class AgreementRichText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle guideTextStyle = TextStyle(
      color: CustomColors.grayScale[500],
      fontSize: 10,
    );
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: '가입을 진행할 경우,',
            style: guideTextStyle,
          ),
          TextSpan(
            text: '서비스 약관',
            style: guideTextStyle.copyWith(
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                await launchUrl(
                  Uri.parse(
                    'https://sincere-frill-729.notion.site/82a2040896354b6b911f58fdc7572367',
                  ),
                );
              },
          ),
          TextSpan(
            text: ' 및 ',
            style: guideTextStyle,
          ),
          TextSpan(
            text: '개인정보 처리방침',
            style: guideTextStyle.copyWith(
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                await launchUrl(
                  Uri.parse(
                    'https://sincere-frill-729.notion.site/8e5d37d6f9ac44f2be75950a0d6702f8',
                  ),
                );
              },
          ),
          TextSpan(
            text: '에 동의한 것으로 간주됩니다.',
            style: guideTextStyle,
          ),
        ],
      ),
    );
  }
}
