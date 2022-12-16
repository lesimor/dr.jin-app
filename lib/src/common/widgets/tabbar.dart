// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:bookrabbit/src/themes/custom_colors.dart';

class MyPageTab extends StatelessWidget {
  final IconData? iconData;
  final String? svgPath;
  final String text;
  final int count;
  final bool selected;
  MyPageTab({
    super.key,
    this.svgPath,
    this.iconData = Icons.people_outline,
    required this.text,
    required this.count,
    this.selected = false,
  });

  final SELECTED_COLOR = CustomColors.primaryGreen;
  final UNSELECTED_COLOR = CustomColors.grayScale[600];

  @override
  Widget build(BuildContext context) {
    var textWithCount = text;
    if (count > 0) textWithCount = '${text} ${count.toString()}';
    return Tab(
      child: Column(
        children: [
          svgPath != null
              ? SvgPicture.asset(
                  svgPath!,
                  width: 15,
                  color: selected ? SELECTED_COLOR : UNSELECTED_COLOR,
                )
              : Icon(
                  Icons.people_outline,
                  color: selected ? SELECTED_COLOR : UNSELECTED_COLOR,
                ),
          SizedBox(
            height: 7.5,
          ),
          Text(
            textWithCount,
            style: Theme.of(context).textTheme.overline!.copyWith(
                  height: 1,
                  color: selected ? SELECTED_COLOR : UNSELECTED_COLOR,
                ),
          ),
        ],
      ),
    );
  }
}
