// Flutter imports:
import "package:flutter/material.dart";

// Project imports:
import 'package:bookrabbit/src/themes/custom_colors.dart';

PreferredSize appBarBuilder({
  required BuildContext context,
  Widget? titleWidget,
  String? titleText,
  bool? automaticallyImplyLeading,
  Color backgroundColor = CustomColors.page,
  PreferredSizeWidget? bottom,
  double preferredHeight = 60.0,
  List<Widget>? actions,
}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(preferredHeight),
    child: AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading ?? true,
      title: titleWidget ??
          Text(
            titleText ?? '',
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
      centerTitle: true,
      actions: actions,
      elevation: 0,
      backgroundColor: backgroundColor,
      bottom: bottom,
    ),
  );
}
