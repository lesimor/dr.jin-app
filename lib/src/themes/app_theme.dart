// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:bookrabbit/src/themes/custom_colors.dart';

const BaseFontColor = Color(0xFF111111);

const TextTheme textTheme = const TextTheme(
  headline1: TextStyle(
    fontFamily: 'Pretendard',
    color: BaseFontColor,
    letterSpacing: 0,
    fontSize: 56,
    fontWeight: FontWeight.w700,
    height: 1.29,
  ),
  headline2: TextStyle(
    fontFamily: 'Pretendard',
    color: BaseFontColor,
    letterSpacing: 0,
    fontSize: 48,
    fontWeight: FontWeight.w700,
    height: 1.33,
  ),
  headline3: TextStyle(
    fontFamily: 'Pretendard',
    color: BaseFontColor,
    letterSpacing: 0,
    fontSize: 40,
    fontWeight: FontWeight.w700,
    height: 1.4,
  ),
  headline4: TextStyle(
    fontFamily: 'Pretendard',
    color: BaseFontColor,
    letterSpacing: 0,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.38,
  ),
  // largeText1 == headline5
  headline5: TextStyle(
    fontFamily: 'Pretendard',
    color: BaseFontColor,
    letterSpacing: 0,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.57,
  ),
  // largeText2 == headline6
  headline6: TextStyle(
    fontFamily: 'Pretendard',
    color: BaseFontColor,
    letterSpacing: 0,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.67,
  ),
  // mediumText1 == subtitle1
  subtitle1: TextStyle(
    fontFamily: 'Pretendard',
    color: BaseFontColor,
    letterSpacing: 0,
    fontSize: 22,
    fontWeight: FontWeight.w400,
    height: 1.73,
  ),
  // mediumText2 == subtitle2
  subtitle2: TextStyle(
    fontFamily: 'Pretendard',
    color: BaseFontColor,
    letterSpacing: 0,
    fontSize: 20,
    fontWeight: FontWeight.w400,
    height: 1.8,
  ),
  // normalText == bodyText2
  bodyText2: TextStyle(
    fontFamily: 'Pretendard',
    color: BaseFontColor,
    letterSpacing: 0,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.75,
  ),
  caption: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.67,
  ),
  // smallText == bodySmall
  button: TextStyle(
    fontFamily: 'Pretendard',
    color: BaseFontColor,
    letterSpacing: 0,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.71,
  ),
  // extraSmallText == labelSmall
  overline: TextStyle(
    fontFamily: 'Pretendard',
    color: BaseFontColor,
    letterSpacing: 0,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.67,
  ),
);

final ThemeData appThemeData = ThemeData(
  // textTheme
  fontFamily: 'Pretendard',
  textTheme: textTheme,
  // color 초기화
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  hoverColor: Colors.transparent,
  // set primaryColor
  primaryColor: CustomColors.primaryGreen,
  canvasColor: Colors.white,
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black),
    foregroundColor: Colors.black,
  ),
);
