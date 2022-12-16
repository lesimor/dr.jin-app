// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:bookrabbit/src/features/products/models/product.dart';
import 'package:bookrabbit/src/themes/custom_colors.dart';

class StatusTag extends StatelessWidget {
  final Widget? child;
  final String? text;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? fontColor;
  StatusTag({
    super.key,
    this.child,
    this.text,
    this.borderColor,
    this.backgroundColor,
    this.fontColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 17,
          decoration: BoxDecoration(
            color: backgroundColor ?? CustomColors.transparent,
            border: Border.all(
              color: borderColor ?? CustomColors.grayScale[600]!,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: child ??
                Center(
                  child: Text(
                    text ?? '',
                    style: Theme.of(context).textTheme.overline!.copyWith(
                          height: 1,
                          color: fontColor ?? CustomColors.grayScale[600],
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
          ),
        ),
      ],
    );
  }

  factory StatusTag.participationTag({
    required BuildContext context,
    required ProductSummaryModel product,
    Color? backgroundColor,
    Color? borderColor,
    Color? fontColor,
  }) {
    return StatusTag(
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/images/person.svg',
            width: 7,
            color: fontColor,
          ),
          SizedBox(width: 4),
          Center(
            child: Text(
              "${product.totalMemberIds.length}/${product.participantsNumber}",
              style: Theme.of(context).textTheme.overline!.copyWith(
                    height: 1,
                    color: fontColor,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
