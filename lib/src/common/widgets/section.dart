// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bookrabbit/src/constants/size.dart';
import 'package:bookrabbit/src/themes/custom_colors.dart';

class HomeSectionTitle extends StatelessWidget {
  final String preText;
  final String postText;
  const HomeSectionTitle({
    super.key,
    required this.preText,
    required this.postText,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.subtitle2!.copyWith(
          fontWeight: FontWeight.bold,
          height: 1.0,
        );
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: this.preText, style: textTheme),
          TextSpan(text: ' ', style: textTheme),
          TextSpan(
            text: this.postText,
            style: textTheme.copyWith(
              color: CustomColors.green,
            ),
          ),
        ],
      ),
    );
  }
}

class TitleAndMore extends StatelessWidget {
  final Widget title;
  final String? pageName;

  const TitleAndMore({
    super.key,
    required this.title,
    this.pageName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        this.title,
        GestureDetector(
          child: Icon(Icons.arrow_forward_ios),
          onTap: this.pageName != null
              ? () {
                  Get.toNamed(this.pageName!);
                }
              : () {},
        ),
      ],
    );
  }
}

class HomeSection extends StatelessWidget {
  final String preText;
  final String postText;
  final Color? backgroundColor;
  final Widget? contentWidget;
  final double? minHeight;
  final List<Widget> cards;
  final int? crossAxisCount;
  final double? childAspectRatio;
  final double? spacing;
  final String? pageName;
  const HomeSection({
    super.key,
    required this.preText,
    required this.postText,
    this.backgroundColor,
    this.contentWidget,
    this.minHeight,
    required this.cards,
    this.crossAxisCount,
    this.childAspectRatio,
    this.spacing,
    this.pageName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: this.backgroundColor ?? Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(
          COMMON_PADDING,
        ),
        child: Column(
          children: [
            TitleAndMore(
              title: HomeSectionTitle(
                preText: this.preText,
                postText: this.postText,
              ),
              pageName: this.pageName,
            ),
            Container(
              constraints: BoxConstraints(
                minHeight: this.minHeight ?? 0.0,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: COMMON_PADDING),
                child: GridView.count(
                  crossAxisCount: crossAxisCount ?? 1,
                  childAspectRatio: childAspectRatio ?? 1,
                  physics:
                      NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                  shrinkWrap: true,
                  crossAxisSpacing: spacing ?? 0.0,
                  mainAxisSpacing: spacing ?? 0.0,
                  children: <Widget>[...this.cards],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
